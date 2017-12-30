ta clinic
ta prison 
sum dose

sum dose if clinic==1
sum dose if clinic==2

stset survt, failure(status==1)
stdescribe
sts list

sts graph
sts graph, by (clinic) 
sts graph, by (prison) 
sts graph, by (dose_cat) 

sts test clinic
sts test prison
sts test dose

stcox clinic prison dose, efron

gen censor=1
replace censor=0 if status==1
gen los=ceil(survt/91.3125)
prsnperd id los censor
logistic _Y clinic prison dose _d1-_d12

gen clinicprison=clinic*prison
gen clinicdose=clinic*dose
gen prisondose=prison*dose
stcox clinic prison dose clinicprison, efron
stcox clinic prison dose clinicdose, efron
stcox clinic prison dose prisondose, efron

stcox clinic prison dose, basesurv(s) efron nohr
stcurve, survival at1(clinic=1 prison=0) at2(clinic=2 prison=0) at3(clinic=1 prison=1) at4(clinic=2 prison=1) 

