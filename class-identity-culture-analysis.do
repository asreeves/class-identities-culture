**** How class identities shape highbrow consumption: A cross-national analysis of 30 European countries and regions
**** Poetics

**** Aaron Reeves

**** Analysis file

/* 
Note:
A separate set of code files will replicate the variables.
*/


/*
For any further questions email: aaron.reeves@spi.ox.ac.uk

*/

*** Run variable creation file


*** Table 1: Individual-level predictors
eststo clear
eststo: xtmixed cult_prac_v2 || country: , mle variance
eststo: xtmixed cult_prac_v2 i.social_class || country: , mle variance  
eststo: xtmixed cult_prac_v2 i.social_class  age age2 female || country: , mle  variance
eststo: xtmixed cult_prac_v2 i.social_class age age2 female years_ed ib4.emp || country: , mle variance
eststo: xtmixed cult_prac_v2 i.social_class  age age2 female years_ed ib4.emp i.marital i.community || country: , mle variance
esttab 
eststo clear 



** Fig. 1: Association between social class identification and highbrow consumption varies between countries
foreach num of numlist 1/14 16/30 32 {
	display `num'
	reg cult_prac_v2 age female i.social_class  if country==`num'
	estimates store M`num'
	}
	
	
coefplot M3 || M2 || M7 || M28 || M4 || M1 || M14 || M26 || M32 || M6 ||  M29 || M22 || M18 ||  M17 ///
	|| M21  || M30 || M20 || M24 || M12 ||  M8 || M27 || M11 || M13 || M19 || M10 ///
	|| M5 || M9 || M23 || M25 || M16, ///
	drop(_cons 3.social_class age female ) ///
	yline(0, lpatt(dash) lcolor(gray) ) bycoefs group(1 2 3 4 5 6 7 8 9 10 11 12 13 14 ///
	15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 = "{bf:Countries}") vertical ///
	ytitle("Association between class identity" "and highbrow consumption") ///
	xlabel(1 "The Netherlands" 2 "Belgium" 3 "Denmark" 4 "Slovenia" 5 "Germany West" 6 "France"  7 "Germany East"  ///
	8 "Poland"  9 "Croatia" 10 "Luxembourg" 11 "Bulgaria"  12 "Hungary" 13 "Austria" 14 "Sweden"  ///
	15 "Estonia" 16 "Romania" 17 "Czech Republic" 18 "Lithuania" 19 "Spain" 20 "Ireland" ///
	21 "Slovakia" 22 "Greece" 23 "Portugal" 24 "Cyprus" 25 "N. Ireland" 26 "Italy" 27 "Great Britain" ///
	28 "Latvia" 29 "Malta" 30 "Finland", angle(60))
	
	
*** Table 2: Aggregate level measure

eststo clear
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp m_wc || country: , mle variance  
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp m_wc i.social_class || country: , mle variance 
esttab 
eststo clear	



*** Figure 4:
xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: , mle  
margins, at(wc=(25 30 35 40 45 50 55 60 65 70 75) social_class=(2)) at(wc=(25 30 35 40 45 50 55 60 65 70 75) social_class=(1))
marginsplot, xtitle("Proportion of respondents who identify as working-class (%)") ///
	ytitle("Predicted level of highbrow consumption" "(Scale 1-4)") text(1.15 50 "People who identify as middle-class") ///
	text(0.69 40 "People who identify as working-class") title("") legend(off)

	
*** Table 3: TV and Gallery

eststo clear
eststo: xtmixed galleryv2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: , mle variance 
eststo: xtmixed tvv2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: , mle variance 

esttab 

eststo clear 

	
	
*** Web appendix 1 - predicting class identity
eststo clear 
eststo: xtmixed social_class_mc  age age2 female years_ed ib4.emp i.marital i.community || country: , mle variance
eststo: xtmixed social_class_oth  age age2 female years_ed ib4.emp i.marital i.community || country: , mle variance
esttab 	
eststo clear 


*** Web Appendix 6 - different dependent variables	
eststo clear
eststo: xtmixed cult_omni_wo_con_cine age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: , mle variance
eststo: xtmixed cult_prac_v2_bin2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: , mle variance 
esttab 
eststo clear 


*** Web Apppendix 7 - consistent class identities and class positions
xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.social_class##ib4.emp##c.wc || country: , mle  
margins, at(wc=(20 25 30 35 40 45 50 55 60 65 70 75 80) emp=(8) social_class=(2)) at(wc=(20 25 30 35 40 45 50 55 60 65 70 75 80) emp=(4) social_class=(1))
marginsplot, xtitle("Proportion of respondents who identify as working-class (%)") ylabel(0(0.2)1.6) ///
	ytitle("Predicted level of highbrow consumption" "(Scale 1-4)") text(1.25 60 "Professionals who identify" "as middle-class") ///
	text(.45 40 "Routine manual workers" "who identify as working-class") title("") legend(off)




*** Web Appendix 8 - high level 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.high_level##c.m_high_level_avg || country: , mle variance // strong positive - even after adding covariates
	


*** Web Appendix 9 controlling for country-level predictors
eststo clear
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: , mle variance 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc gni || country: , mle variance 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc social_mobility || country: , mle variance 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc cult_exp || country: , mle variance 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc gini_wb || country: , mle variance 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc urban || country: , mle variance 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc service_class || country: , mle variance 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc gni social_mobility gini_wb cult_exp urban service_class || country: , mle variance 
esttab 
	
eststo clear 


*** web appendix 10 - collapsing similar regions
eststo clear
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: , mle  variance
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || id_new: , mle  variance
esttab 
eststo clear 

*** web appendix 11 - restrictions

eststo clear
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.m_wc || country: if age>25 & age<75 & still_in_school!=1, mle variance  // interaction sig
eststo clear 


*** web appendix 12 - bootstrap model


foreach num of numlist 1/14 16/30 32 {
	display `num'
	qui xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: if country!=`num', mle  
	estimates store M`num'
	}

qui xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc || country: , mle  
estimates store M0

coefplot M2 || M3 || M28 || M6 || M1 || M7 || M4 || M14 || M18 || M26 || M17 || M22 ///
	|| M13 || M32 || M11 || M24 || M12 || M30 || M29 || M20 || M27 || M21 || M8 || M19 || M10 ///
	|| M5 || M9 || M23 || M25 || M16 || M0, ///
	drop(_cons 2.social_class 3.social_class age female age2 years_ed 0.marital 1.marital 2.marital 3.marital ///
	4.marital 5.marital affluence 0.community 1.community 2.community 3.community wc 3.social_class#c.wc 8.emp ///
	1.emp 2.emp 3.emp 4.emp 5.emp 6.emp 7.emp 0.emp) ///
	yline(0, lpatt(dash) lcolor(gray) ) bycoefs group(1 2 3 4 5 6 7 8 9 10 11 12 13 14 ///
	15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 = "{bf:Excluded country}") vertical ///
	ytitle("Interaction term and cultural practice:" "Identifying middle-class x aggregate" "middle-class dis-identification") ///
	xlabel(1 "Belgium" 2 "The Netherlands" 3 "Slovenia" 4 "Luxembourg" 5 "France" 6 "Denmark" 7 "Germany West" 8 "Germany East" ///
	9 "Austria" 10 "Poland" 11 "Sweden" 12 "Hungary" 13 "Portugal" 14 "Croatia" ///
	15 "Greece" 16 "Lithuania" 17 "Spain" 18 "Romania" 19 "Bulgaria" 20 "Czech Republic" ///
	21 "Slovakia" 22 "Estonia" 23 "Ireland" 24 "Cyprus" 25 "N. Ireland" 26 "Italy" 27 "Great Britain" ///
	28 "Latvia" 29 "Malta" 30 "Finland" 31 "None", angle(60)) ylabel(0(0.001)-0.005)

	
*** web appendix 13 - with weights

eststo clear
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp m_wc [pweight=w1] || country: , mle variance 
eststo: xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp m_wc i.social_class [pweight=w1] || country: , mle variance // strong negative - even after adding covariates
esttab 	
eststo clear 



*** web appendix 14 - figure with weights

qui xtmixed cult_prac_v2 age age2 female years_ed i.marital i.community i.emp i.social_class##c.wc [pweight=w1] || country: , mle variance cluster(country) // interaction sig
qui margins, at(wc=(25 30 35 40 45 50 55 60 65 70 75) social_class=(2)) at(wc=(25 30 35 40 45 50 55 60 65 70 75) social_class=(1))
marginsplot, xtitle("Proportion of respondents who identify as working-class (%)") ///
	ytitle("Predicted level of highbrow consumption" "(Scale 1-4)") text(1.15 50 "People who identify as middle-class") ///
	text(0.65 40 "People who identify as working-class") title("") legend(off)


	
