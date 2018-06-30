cls
log close


// Building a .do file...
// Change the working directory to where your Git repo is

cd "D:\Documents\GitHub\ra-boot-camp-stata"

// Start a log file, specifiying "replace" if you want it to be overwritten every time
log using Intro_to_Stata, replace

/* You can pause logging with "log off", restart with "log on", and 
end logging with "log close" */

// Import the Pakistan Suicide Attacks file
import delimited "D:\Documents\GitHub\ra-boot-camp-stata\PakistanSuicideAttacks Ver 11 (30-November-2017).csv", delimiter(comma) bindquote(strict) clear 


// Watch how fast the Yellow Tripdata file loads
save Pakistan_SA.dta, replace
import delimited yellow_tripdata_2017-06.csv, clear
save Yellow_Tripdata_2017_06.dta, replace
use Pakistan_SA.dta, clear 

// List the deuplicates on date, time, lat and long
duplicates list date time latitude longitude

// Drop duplicates
duplicates drop date time latitude longitude, force

// Find and replace "NA" or "N/A" for time, "shiite" or "sunni" for Target Sect
replace time = "" if time =="N/A"
replace time = "" if time =="NA"
replace targetedsectifany = "Sunni" if targetedsectifany =="sunni"
replace targetedsectifany = "Shiite" if targetedsectifany =="shiite" 

// Tabulate targetedsectifany
tabulate targetedsectifany

// Replace the other obvious typos
replace targetedsectifany = "" if targetedsectifany =="NA"
replace targetedsectifany = "Shiite/Sunni" if targetedsectifany =="Shiite/sunni"
tabulate targetedsectifany

// Change city to proper case
replace city = proper(city)
tabulate city

// Remove leading and trailing blanks from city
replace city = trim(city)
tabulate city

// Convert strings to numeric
destring noofsuicideblasts injuredmax longitude, replace force float

// For correct date, it is easiest to use some copy and paste in Data Editor
split date, parse(-) limit(4)
sort date4

// *(1 variable, 16 observations pasted into data editor)

// *(1 variable, 450 observations pasted into data editor)

split date2, limit(2)

// *(2 variables, 466 observations pasted into data editor)

drop date21 date22

rename date3 Day
rename date4 Year

// Create new variable for numeric month
generate int Month=1 if date2 == "January"
replace Month = 2 if date2 == "February"
replace Month = 3 if date2 == "March"
replace Month = 4 if date2 == "April"
replace Month = 5 if date2 == "May"
replace Month = 6 if date2 == "June"
replace Month = 7 if date2 == "July"
replace Month = 8 if date2 == "August"
replace Month = 9 if date2 == "September"
replace Month = 10 if date2 == "October"
replace Month = 11 if date2 == "November"
replace Month = 12 if date2 == "December"
replace Month = 1 if date2 == "Jan"
replace Month = 2 if date2 == "Feb"
replace Month = 3 if date2 == "Mar"
replace Month = 4 if date2 == "Apr"
replace Month = 5 if date2 == "May"
replace Month = 6 if date2 == "Jun"
replace Month = 7 if date2 == "Jul"
replace Month = 8 if date2 == "Aug"
replace Month = 9 if date2 == "Sep"
replace Month = 10 if date2 == "Oct"
replace Month = 11 if date2 == "Nov"
replace Month = 12 if date2 == "Dec"

// Convert Day and Year to numeric
destring Day Year, replace force float

gen DateFixed = mdy(Month,Day,Year)
format DateFixed %d 
format DateFixed %dM_d,_CY 






