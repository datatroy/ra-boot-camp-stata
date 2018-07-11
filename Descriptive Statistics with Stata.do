// Building a .do file...
// Change the working directory to where your Git repo is

cd "D:\Documents\GitHub\ra-boot-camp-stata"

// Start a log file, specifiying "replace" if you want it to be overwritten every time
log using Stats_with_Stata, replace

/* You can pause logging with "log off", restart with "log on", and 
end logging with "log close" */

odbc list

odbc query "MariaDB", dialog(complete)

odbc desc "yt_validated_master"
odbc load, table("yt_validated_master") clear noquote
sample 5

cls
describe
describe mins
cls
codebook
codebook mins
cls
inspect
inspect mins
cls
list
list mins if mins>1200
egen mins_cat = cut(mins), at(0,10,20,30,40,50,60,70,80,90,100)
list mins mins_cat if mins>100
drop mins_cat
egen mins_cat = cut(min), group(10)
list mins mins_cat if mins>100
cls
tabulate mins
tabulate mins_cat
tabulate mins_cat, plot
tabulate mins mins_cat
gen pickuphour = hh(tpep_pickup_datetime)
describe pickuphour
tabulate pickuphour

tabulate mins_cat pickuphour
gen shift="01 Morning" if pickuphour>=4&pickuphour<12
replace shift="02 Afternoon" if pickuphour>=12&pickuphour<18
replace shift="03 Evening" if pickuphour>=18&pickuphour<=23
replace shift="04 Late Night" if pickuphour>=0&pickuphour<4
tabulate mins_cat shift
tabulate mins_cat shift, column
tabulate mins_cat shift, column nofreq
tabulate mins_cat shift, chi2
cls
summarize
cls
