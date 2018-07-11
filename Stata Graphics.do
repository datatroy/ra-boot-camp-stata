// Building a .do file...
// Change the working directory to where your Git repo is

cd "D:\Documents\GitHub\ra-boot-camp-stata"

// Start a log file, specifiying "replace" if you want it to be overwritten every time
log using Graphics_with_Stata, replace

/* You can pause logging with "log off", restart with "log on", and 
end logging with "log close" */

odbc list

odbc query "MariaDB", dialog(complete)

odbc desc "yt_validated_5pct"
odbc load, table("yt_validated_5pct") clear noquote

graph twoway scatter tip_amount mins

twoway (scatter tip_amount trip_distance if trip_distance<200&mins<200, ///
mcolor(red) msymbol(smplus)), ytitle(Tip Amount) ylabel(#5) ymtick(##5) ///
xtitle(Trip Length in Minutes) xlabel(#5) xmtick(##5) title(Tip Amount vs. Trip Length) legend(off) scheme(s2color)


egen mins_cat = cut(min), group(10)
list mins mins_cat if mins>100
tabulate mins
tabulate mins_cat
gen pickuphour = hh(tpep_pickup_datetime)
describe pickuphour
tabulate pickuphour


gen shift="01 Morning" if pickuphour>=4&pickuphour<12
replace shift="02 Afternoon" if pickuphour>=12&pickuphour<18
replace shift="03 Evening" if pickuphour>=18&pickuphour<=23
replace shift="04 Late Night" if pickuphour>=0&pickuphour<4
tabulate mins_cat shift
tabulate mins_cat shift, column
tabulate mins_cat shift, column nofreq
tabulate mins_cat shift, chi2
