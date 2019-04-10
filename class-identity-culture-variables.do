**** How class identities shape highbrow consumption: A cross-national analysis of 30 European countries and regions
**** Poetics

**** Aaron Reeves

**** Variable creation file

/* 
Note:
A separate set of code files will replicate the analysis.
*/


/*
For any further questions email: aaron.reeves@spi.ox.ac.uk

*/


**** Import Eurobarometer (ZA5688_v4-0-0.dta)

**** Merge in cross-national data set (eurobarometer class disident.dta)
merge m:m country using "eurobarometer class disident.dta"
drop _merge
 
 
**** Create variables


** cultural consumption
recode qb1_1 (1=0) (2=1) (3=2) (4=3) (5=0), g(balletv2)
recode qb1_2 (1=0) (2=1) (3=2) (4=3) (5=0), g(cinemav2)
recode qb1_3 (1=0) (2=1) (3=2) (4=3) (5=0), g(theatrev2)
recode qb1_4 (1=0) (2=1) (3=2) (4=3) (5=0), g(concertv2)
recode qb1_5 (1=0) (2=1) (3=2) (4=3) (5=0), g(libraryv2)
recode qb1_6 (1=0) (2=1) (3=2) (4=3) (5=0), g(historyv2)
recode qb1_7 (1=0) (2=1) (3=2) (4=3) (5=0), g(galleryv2)
recode qb1_8 (1=0) (2=1) (3=2) (4=3) (5=0), g(tvv2)
recode qb1_9 (1=0) (2=1) (3=2) (4=3) (5=0), g(bookv2)

*** remaking cultural participation index
gen test = (balletv2 + theatrev2 + libraryv2 + historyv2 + galleryv2 + tvv2 + bookv2)
recode test (-9/-1=0), g(cult_omni_wo_con_cine)
drop test


egen intense_v2 = anycount(balletv2 theatrev2 libraryv2 historyv2 galleryv2 tvv2 bookv2), v(3)

gen cult_prac_v2 = .
replace cult_prac_v2 = 0 if cult_omni_wo_con_cine<5 & intense_v2<1
replace cult_prac_v2 = 1 if cult_omni_wo_con_cine>4 & cult_omni_wo_con_cine<11  
replace cult_prac_v2 = 1 if intense_v2>0 & intense_v2<3
replace cult_prac_v2 = 2 if cult_omni_wo_con_cine>10 & cult_omni_wo_con_cine<14  
replace cult_prac_v2 = 2 if intense_v2>2 & intense_v2<5
replace cult_prac_v2 = 3 if cult_omni_wo_con_cine>13  & intense_v2>3
replace cult_prac_v2 = 3 if intense_v2>3


recode cult_prac_v2 (1/27=1), g(cult_prac_v2_bin)

recode cult_prac_v2 (0/1=0) (2/27=1), g(cult_prac_v2_bin2)


*** demographics

gen age = d11
gen age2 = d11*d11
gen female = d10
recode d63 (3=2) (4/7=3), g(social_class) 
tab social_class, g(social_class)


gen social_class_mc = 0 if social_class==1
replace social_class_mc = 1 if social_class==2


gen social_class_oth = 0 if social_class==1
replace social_class_oth = 1 if social_class==3


recode d63 (1=0) (2/3=1) (4/7=.), g(wc_vs_mc) 
recode d8 (0/97=0) (99=0) (98=1), g(still_in_school)
recode d8 (0/9=10) (31/98=.) (99=10), g(y_ed)
gen years_ed = y_ed-10

gen marital = d7r2
label values marital D7R2

tab marital, g(marital)

gen community=d25 if d25<4
label values community D25
tab community, g(community)


egen mean_wc = mean(wc)
gen m_wc = wc-mean_wc

recode d61r (1/2=0) (3=1), g(high_level)


egen mean_high_level = mean(high_level_avg)
gen m_high_level_avg = high_level_avg-mean_high_level


recode d15a (1=0) (2=1) (3=2) (4=3) (5 6 8=6) (7 9 10 11=8) (12=7) (13 14 15=5) (16 17 18=4), g(emp)
label define emp 0 "Household" 1 "Student" 2 "Unemployed" 3 "Retired" 4 "Manual" 5 "Routine non-manual" 6 "Self-employed" 7 "Lower professional" 8 "Professional"
label values emp emp

tab emp, g(emp)

gen class2_m_wc2 = m_wc*social_class2
gen class3_m_wc2 = m_wc*social_class3	



foreach var of varlist age age2 female years_ed emp1 emp2 emp3 emp4 emp5 emp6 emp7 emp8 emp9 social_class social_class1 ///
	social_class2 social_class3 wc m_wc cult_prac_v2 class2_m_wc2 class3_m_wc2	{
	qui summ `var'
	qui gen `var'ST = (`var'-r(mean))/(2*r(sd))
	}


xtmixed cult_prac_v2 i.social_class  age age2 female years_ed ib4.emp i.marital i.community || country: , mle variance
gen sample = e(sample)


