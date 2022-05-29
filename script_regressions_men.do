
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*Data cleaning
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//Muslim Dummy
gen muslim=1 if s1q17==2
replace muslim=0 if s1q17!=2
replace muslim=. if s1q17==.



// dropping income outliers
drop if monthly_income>2245600 & monthly_income!=.

//Replacing nulls with zero to correct previous mistake
replace years_educ_husband=0 if years_educ_husband==. & read_write==0

//dropping younger than 15
drop if age<15 & age!=.

//drop missing values or very old men (98, 99 and 999)
drop if s1q4>97 & s1q4!=.

//dropping if age at first child is lower than 13
drop if age_first_pregnancy<13



*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*Regression estimates: effect of fertility on men's bargaining power (Twin IV)
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*** First-Stage

eststo: regr num_children twin_first_pregnancy s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban i.religion i.zone  [aweight = weight], vce(cluster ea)

// Savinvg results into Excel file
esttab using 1st_stage_twin_iv_men.csv, se r2 keep ( twin_first_pregnancy s1q4 age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)


eststo clear 


*** Second Stage

eststo: ivregress 2sls monthly_income s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_work s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls income_decision s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage  urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls owner_manager_ s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage  urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls consulted_doctor_if_sick s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_unpaid_other s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage  urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls unpaid_children_care s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls hours_unpaid_other s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls hours_children_care s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls mobile_phone_own_if_access s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls total_clothing_expenditures s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls men_expenditures s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban  i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls percentage_men  s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban i.zone  (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)




// Transferring the regression outputs to Excel
esttab using 2nd_stage_twin_iv_men.csv, se r2 keep ( num_children ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear





***Reduced Form Regressions
//Regressions:
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures men_expenditures percentage_men  {
eststo: regr `var' twin_first_pregnancy s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage   urban  i.zone  [aweight = weight], vce(cluster ea)
}



// Transferring the regression outputs to Excel
esttab using RF_stage_twin_iv_men.csv, se r2 keep ( twin_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear






*----------------------------------------------------------
* Exogeneity Tests with respect to controls: Twin IV
*----------------------------------------------------------

eststo: regr twin_first_pregnancy s1q4 age age_first_pregnancy i.year_survey urban polygamous_marriage urban i.zone [aweight = weight], vce(cluster ea)



// Transferring the regression outputs to Excel
esttab using twin_exogeneity_men.csv, se r2 keep ( s1q4 age age_first_pregnancy urban polygamous_marriage urban  ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear


*------------------------------------------------
* T-test: Twin IV
*------------------------------------------------
*** All twins
//Regressions:
foreach var in s1q4 age age_first_pregnancy urban polygamous_marriage urban  { 
eststo: regr `var' twin_first_pregnancy  [aweight = weight]
}

esttab using ttest_iv_men.csv, se r2 keep ( twin_first_pregnancy _cons  ) star(* 0.10 ** 0.05 *** 0.01)



*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*Summary Statistics
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

** Men
summarize age age_first_pregnancy num_children twins twin_first_pregnancy polygamous_marriage monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  men_expenditures percentage_men main_activity_non_ag own_house read_write years_educ_husband dif_educ_husband urban muslim s1q4 [aweight = weight]



