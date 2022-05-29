

//Replacing nulls with zero to correct previous mistake
replace years_educ=0 if years_educ==.


 

*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*Regression estimates: effect of fertility on women's bargaining power (Twin IV)
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*------------------------------------------------
* Regression 1: Minimal Controls
*------------------------------------------------
*** First-Stage


eststo: regr num_children twin_first_pregnancy age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)

// Savinvg results into Excel file
esttab using 1st_stage_twin_iv_less_control.csv, se r2 keep ( twin_first_pregnancy age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)



***Second-Stage Regressions


//Clearing previous results stored

eststo clear

// Regressions

eststo: ivregress 2sls monthly_income age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_work age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls income_decision age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls owner_manager_ age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls consulted_doctor_if_sick age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls check_up_not_sick age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_unpaid_other age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls unpaid_children_care age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls hours_unpaid_other age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls hours_children_care age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls mobile_phone_own_if_access age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls total_clothing_expenditures age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls women_clothing_expenditures age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls percentage_women_children age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


// Transferring the regression outputs to Excel
esttab using 2nd_stage_twin_iv_less_control.csv, se r2 keep ( num_children ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear




***Reduced Form Regressions
//Regressions:
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' twin_first_pregnancy age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone [aweight = weight], vce(cluster ea)
}



// Transferring the regression outputs to Excel
esttab using RF_stage_twin_iv_less_control.csv, se r2 keep ( twin_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear






*------------------------------------------------
* Regression 2: Additional controls
*------------------------------------------------
*** First-Stage

eststo: regr num_children twin_first_pregnancy age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)

// Savinvg results into Excel file
esttab using 1st_stage_twin_iv.csv, se r2 keep ( twin_first_pregnancy age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)




***Second-Stage Regressions


// Eliminating stored results from previous regressions
eststo clear
 
// Regressions
eststo: ivregress 2sls monthly_income age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_work age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls income_decision age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls owner_manager_ age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls consulted_doctor_if_sick age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls check_up_not_sick age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_unpaid_other age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls unpaid_children_care age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls hours_unpaid_other age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls hours_children_care age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls mobile_phone_own_if_access age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls total_clothing_expenditures age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls women_clothing_expenditures age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls percentage_women_children age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea)

// Transferring the regression outputs to Excel
esttab using 2nd_stage_twin_iv.csv, se r2 keep ( num_children ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear




*** Reduced Form 

//Regressions:
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' twin_first_pregnancy age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)
}


// Transferring the regression outputs to Excel
esttab using RF_stage_twin_iv.csv, se r2 keep ( twin_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear







*------------------------------------------------
* Regression 3: Robustness Check - same-sex twins
*------------------------------------------------
*** First-Stage
//Regression
eststo: regr num_children same_sex_twins2 age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)

// Saving results into Excel file
esttab using 1st_stage_twin_iv_monozygotic.csv, se r2 keep ( same_sex_twins2 age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)


***Second-Stage Regressions
// Clearing results from previous regressions
eststo clear

eststo: ivregress 2sls monthly_income age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_work age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls income_decision age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls owner_manager_ age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls consulted_doctor_if_sick age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls check_up_not_sick age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_unpaid_other age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls unpaid_children_care age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls hours_unpaid_other age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls hours_children_care age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls mobile_phone_own_if_access age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls total_clothing_expenditures age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls women_clothing_expenditures age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls percentage_women_children age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea)

// Transferring the regression outputs to Excel
esttab using 2nd_stage_twin_iv_monozygotic.csv, se r2 keep ( num_children ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear


*** Reduced Form 
//Regressions:
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' same_sex_twins2 age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)
}



// Transferring the regression outputs to Excel
esttab using RF_stage_twin_iv_monozygotic.csv, se r2 keep ( same_sex_twins2 ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear



*----------------------------------------------------------
* Exogeneity Tests with respect to controls: Twin IV
*----------------------------------------------------------
*** Any twin

eststo: regr twin_first_pregnancy age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)


*** Same gender/"monozygotic" twin

eststo: regr same_sex_twins2 age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)


// Transferring the regression outputs to Excel
esttab using twin_exogeneity_women.csv, se r2 keep ( age age_first_pregnancy polygamous_marriage previous_health_issues dif_educ_husband urban 1.religion2 ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear


*------------------------------------------------
* T-test: Twin IV
*------------------------------------------------
*** All twins
//Regressions:
foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage previous_health_issues dif_educ_husband urban { 
eststo: regr `var' twin_first_pregnancy  [aweight = weight]
}

esttab using ttest_iv_all_twins.csv, se r2 keep ( twin_first_pregnancy  _cons  ) star(* 0.10 ** 0.05 *** 0.01)


***Same gender twins

// Eliminating stored results from previous regressions
eststo clear

//Regressions:
foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage previous_health_issues dif_educ_husband urban { 
eststo: regr `var' same_sex_twins2  [aweight = weight]
}

esttab using ttest_iv_same_gender_twins.csv, se r2 keep ( same_sex_twins2  _cons  ) star(* 0.10 ** 0.05 *** 0.01)





*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*Regression estimates: effect of fertility on women's bargaining power (Twin IV)
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


*------------------------------------------------
* Regression 4: Entire Sample of Women
*------------------------------------------------

// Preserving current dataset
preserve
//Keeping only the 2010's survey responses

keep if year_survey==2010


*** First-Stage

//Regression

eststo xi:regr any_sons male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)

// Saving results into Excel file
esttab using 1st_stage_gender_iv_complete.csv, se r2 keep ( male age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)



*** Second-Stage Regressions

// Eliminating stored results from previous regressions
eststo clear

eststo: ivregress 2sls monthly_income age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_work age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls income_decision age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls owner_manager_ age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls consulted_doctor_if_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls check_up_not_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls unpaid_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls hours_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls hours_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls mobile_phone_own_if_access age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls total_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls women_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls percentage_women_children age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

// Transferring the regression outputs to Excel
esttab using 2nd_stage_gender_iv_complete.csv, se r2 keep (any_sons ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear





*** Reduced Form 
//Regressions:
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)
}



//   Transferring the regression outputs to Excel
esttab using RF_stage_gender_iv_complete.csv, se r2 keep ( male ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear



*--------------------------------------------------------
* Regression 4: Sample of Young Women (42 and younger)
*--------------------------------------------------------

//Keeping only women within the age range
drop if age>42


*** First-Stage

//Regression

eststo xi:regr any_sons male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)

// Saving results into Excel file
esttab using 1st_stage_gender_iv_42_under.csv, se r2 keep ( male age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)



*** Second-Stage Regressions

// Eliminating stored results from previous regressions
eststo clear

eststo: ivregress 2sls monthly_income age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_work age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls income_decision age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls owner_manager_ age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls consulted_doctor_if_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls check_up_not_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls unpaid_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls hours_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls hours_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls mobile_phone_own_if_access age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls total_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls women_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls percentage_women_children age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

// Transferring the regression outputs to Excel
esttab using 2nd_stage_gender_iv_42_under.csv, se r2 keep ( any_sons ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear





*** Reduced Form 
//Regressions:
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)
}



// Transferring the regression outputs to Excel
esttab using RF_stage_gender_iv_42_under.csv, se r2 keep ( male ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear









*--------------------------------------------------------
* Regression 5: Sample of Young Women (27 and younger)
*--------------------------------------------------------
// Eliminating stored results from previous regressions
eststo clear 

//Keeping only women within the age range
drop if age>27


*** First-Stage

//Regression

eststo xi:regr any_sons male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)

// Saving results into Excel file
esttab using 1st_stage_gender_iv_young_women.csv, se r2 keep ( male age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)



*** Second-Stage Regressions

// Eliminating stored results from previous regressions
eststo clear

eststo: ivregress 2sls monthly_income age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_work age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls income_decision age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls owner_manager_ age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls consulted_doctor_if_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls check_up_not_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls any_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls unpaid_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls hours_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls hours_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls mobile_phone_own_if_access age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)


eststo: ivregress 2sls total_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls women_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

eststo: ivregress 2sls percentage_women_children age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea)

// Transferring the regression outputs to Excel
esttab using 2nd_stage_gender_iv_young_women.csv, se r2 keep ( any_sons ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear





*** Reduced Form 
//Regressions:
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)
}



// Transferring the regression outputs to Excel
esttab using RF_stage_gender_iv_young_women.csv, se r2 keep ( male ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear


//Restoring the original dataset 
restore




*----------------------------------------------------------
* Exogeneity Tests with respect to controls: Gender IV
*----------------------------------------------------------

//Preserving the original dataset 
preserve

//Keeping only 2010 survey responses

keep if year_survey==2010


*** Same gender/"monozygotic" twin

eststo: regr male age age_first_pregnancy i.year_survey polygamous_marriage dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)




//Keeping only Young Mothers under 42

drop if age>42


*** Same gender/"monozygotic" twin

eststo: regr male age age_first_pregnancy i.year_survey polygamous_marriage dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)



//Keeping only Young Mothers under 27

drop if age>27

eststo: regr male age age_first_pregnancy i.year_survey polygamous_marriage dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)


// Transferring the regression outputs to Excel
esttab using gender_iv_exogeneity.csv, se r2 keep ( age age_first_pregnancy polygamous_marriage dif_educ_husband urban 1.religion2 ) star(* 0.10 ** 0.05 *** 0.01)

// Eliminating stored results from previous regressions
eststo clear

//Restoring the original dataset 
restore





*------------------------------------------------
* T-test: Gender IV
*------------------------------------------------


//Preserving the original dataset 
preserve


//Keeping only 2010 survey responses

keep if year_survey==2010

*** All women
//Regressions:
foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage  dif_educ_husband urban { 
eststo: regr `var' male  [aweight = weight]
}

esttab using ttest_iv_gender_all.csv, se r2 keep ( male  _cons  ) star(* 0.10 ** 0.05 *** 0.01)




// Dropping women older than 42

drop if age>42

***Young women

// Eliminating stored results from previous regressions
eststo clear

//Regressions:
foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage dif_educ_husband urban { 
eststo: regr `var' male  [aweight = weight]
}

esttab using ttest_iv_gender_young_women42.csv, se r2 keep ( male  _cons ) star(* 0.10 ** 0.05 *** 0.01)






// Dropping women older than 27

drop if age>27

***Young women

// Eliminating stored results from previous regressions
eststo clear

//Regressions:
foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage dif_educ_husband urban { 
eststo: regr `var' male  [aweight = weight]
}

esttab using ttest_iv_gender_young_women35.csv, se r2 keep ( male  _cons ) star(* 0.10 ** 0.05 *** 0.01)




//Restoring the original dataset 
restore






*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Graphs
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*** Entire Sample - Missing Adult women
//Preserving the dataset
preserve
//Generating a "Firstborn is a daughter" variable
gen female=0 if male==1
replace female=1 if male==0

//Collapsing the data
collapse female, by (age)

drop if age<20
//Plotting
twoway qfitci female age, alwidth(none) || scatter female age, title("Share of Women with a firstborn Daughter by Women's age")  xtitle("Women's Age at the Time of the Survey'")
 
//Restoring the data
restore 


*** Subsample 2010 - Missing Adult Women

//Preserving the dataset
preserve
keep if year_survey==2010
//Generating a "Firstborn is a daughter" variable
gen female=0 if male==1
replace female=1 if male==0

//Collapsing the data
collapse female, by (age)

drop if age<20
drop if age>60
//Plotting
twoway qfitci female age, alwidth(none) || scatter female age, title("Share of Women with a firstborn Daughter by Women's age (2010 Sample)", size(medsmall))  xtitle("Women's Age at the Time of the Survey'")
 
//Restoring the data
restore 






*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*Summary Statistics
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

** Women - entire sample
summarize age age_first_pregnancy num_children twins twin_first_pregnancy same_sex_twins same_sex_twins2 polygamous_marriage previous_health_issues monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  women_clothing_expenditures percentage_women_children main_activity_non_ag own_house read_write years_educ dif_educ_husband urban religion2 male any_sons [aweight = weight]



** Women - 2010 sample
*** Ages 13-65:
// Preserving dataset
preserve

keep if year_survey==2010
summarize age age_first_pregnancy num_children twins twin_first_pregnancy same_sex_twins same_sex_twins2 polygamous_marriage previous_health_issues monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  women_clothing_expenditures percentage_women_children main_activity_non_ag own_house read_write years_educ dif_educ_husband urban religion2 male any_sons [aweight = weight]

*** Ages 13-42:
drop if age>42
summarize age age_first_pregnancy num_children twins twin_first_pregnancy same_sex_twins same_sex_twins2 polygamous_marriage previous_health_issues monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  women_clothing_expenditures percentage_women_children main_activity_non_ag own_house read_write years_educ dif_educ_husband urban religion2 male any_sons [aweight = weight]

*** Ages 13-27:
drop if age>27
summarize age age_first_pregnancy num_children twins twin_first_pregnancy same_sex_twins same_sex_twins2 polygamous_marriage previous_health_issues monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  women_clothing_expenditures percentage_women_children main_activity_non_ag own_house read_write years_educ dif_educ_husband urban religion2 male any_sons [aweight = weight]

restore


