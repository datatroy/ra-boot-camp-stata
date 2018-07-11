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
odbc insert, table("yt_validated_5pct") dsn("MariaDB") create
regress tip_amount mins

twoway scatter tip_amount mins || lfit tip_amount mins

list mins if mins<0
drop if mins<0
regress tip_amount mins

twoway scatter tip_amount mins || lfit tip_amount mins
predict residuals, residuals
predict fittedvalues, xb
rvfplot, yline(0)
estat hettest
acprplot min

regress tip_amount mins trip_distance

correlate mins trip_distance
vif

estat ovtest

predict r, residuals
kdensity r, normal

testparm mins
test (trip_distance)

test (mins trip_distance) 

test (mins=trip_distance)



