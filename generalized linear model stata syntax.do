Stata syntax and output
rename H3TO130 suicide
rename IYEAR3 int_year
rename H3OD1Y birth_year
rename H3ED5 bachelor
rename H3ID15 depression
rename H3HS7G stress
rename H3TO133 friend_sui
rename H3TO135 family_sui
rename H3SP3 life_satis
rename H3ID26H heart_problem
rename H3HS3 insurance
rename H3EC12 computer

drop if suicide == .
drop if int_year == .
drop if birth_year == .
drop if bachelor == .
drop if depression == .
drop if friend_sui == .
drop if life_satis == .
drop if insurance == .

ta suicide
sum age if suicide==0
sum age if suicide==1

ttest age, by(suicide)
ta bachelor suicide, column chi2
ta depress suicide, column chi2
ta friend_sui suicide, column chi2
ta family_sui suicide, column chi2
ta insurance suicide, column chi2

ta bachelor suicide, column chi2
gen age=int_year-birth_year
probit suicide age i.bachelor i.depression i.friend_sui i.family_sui i.insurance
fitstat

logit suicide age i.bachelor i.depression i.friend_sui i.family_sui i.insurance

margins, at(age=(18(1)28)) atmeans noatlegend
marginsplot
margins i.depression, at(c.age=(18(1)28)) atmeans noatlegend
marginsplot
margins i.insurance, at(c.age=(18(1)28)) atmeans noatlegend
marginsplot

mchange, atmeans

mtable, ci clear at(age=18 depression=1 friend_sui=1) atmeans
mtable, ci clear at(age=18 depression=0 friend_sui=1) atmeans
mtable, ci clear at(age=18 depression=1 friend_sui=0) atmeans
mtable, ci clear at(age=28 depression=1 friend_sui=0) atmeans
