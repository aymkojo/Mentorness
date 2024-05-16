
-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
SELECT *
FROM `corona virus dataset` 
WHERE Province IS NULL 
OR `Country/Region` IS NULL 
OR Latitude IS NULL 
OR Longitude IS NULL 
OR `Date` IS NULL 
OR Confirmed IS NULL 
OR Deaths IS NULL 
OR Recovered IS NULL;


-- Q2. If NULL values are present, update them with zeros for all columns. 
# no null values present


-- Q3. check total number of rows
SELECT COUNT(*) FROM `corona virus dataset`;


-- Q4. Check what is start_date and end_date
DESCRIBE `corona virus dataset`;
#This DESCRIBE function outputs the datatypes of each field

SET SQL_SAFE_UPDATES = 0;

UPDATE `corona virus dataset`
SET `Date` = str_to_date(`Date`, '%d-%m-%Y');
/*default date format in mysql is YYYY-MM-DD, so when our date values doesn't correspond with that, we use the
 str_to_date function to convert date values from any other format to YYYY_MM_DD to avoid getting errors in our queries*/

ALTER TABLE `corona virus dataset`
MODIFY COLUMN `Date` DATE;
# this query will change the current data type of the `Date` column into DATE data type

SELECT MIN(`Date`) AS StartDate, MAX(`Date`) AS EndDate FROM `corona virus dataset`;
# This query will return the earliest (MIN) and latest (MAX) dates in the Date column of the table

SET SQL_SAFE_UPDATES = 1;


-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT MONTH(`Date`)) AS NumberOfMonths
FROM `corona virus dataset`;


-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT
	DISTINCT(MONTH(`Date`)) AS Month,
	AVG(Confirmed) AS AvgConfirmed,
	AVG(Deaths) AS AvgDeaths,
	AVG(Recovered) AS AvgRecovered
FROM `corona virus dataset`
GROUP BY MONTH(`Date`);


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT 
    MONTH(`Date`) AS Month,
    Confirmed,
    Deaths,
    Recovered,
    COUNT(*) as Frequency
FROM `corona virus dataset`
GROUP BY MONTH(`Date`), Confirmed, Deaths, Recovered
ORDER BY Frequency DESC
LIMIT 12;


-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    YEAR(`Date`) AS Year,
    MIN(Confirmed) AS MinConfirmed,
    MIN(Deaths) AS MinDeaths,
    MIN(Recovered) AS MinRecovered
FROM `corona virus dataset`
GROUP BY YEAR(`Date`);


-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(`Date`) AS Year,
    MAX(Confirmed) AS MaxConfirmed,
    MAX(Deaths) AS MaxDeaths,
    MAX(Recovered) AS MaxRecovered
FROM `corona virus dataset`
GROUP BY YEAR(`Date`);


-- Q10. The total number of case of confirmed, deaths, recovered each month
Select 
	DISTINCT(MONTH(`Date`)) as Months,
	SUM(Confirmed) as Total_confirmed_cases,
    SUM(Deaths) as Total_death_cases,
    SUM(Recovered) as Total_recovered_cases
FROM `corona virus dataset`
GROUP BY Months;


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
    SUM(Confirmed) as TotalConfirmedCases,
    AVG(Confirmed) as AverageConfirmedCases,
    VARIANCE(Confirmed) as VarianceCases,
    STDDEV(Confirmed) as StdDevCases
FROM `corona virus dataset`;


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
	DISTINCT(MONTH(`Date`)) as Months,
    SUM(Deaths) as TotalDeathCases,
    AVG(Deaths) as AverageDeathCases,
    VARIANCE(Deaths) as VarianceCases,
    STDDEV(Deaths) as StdDevCases
FROM `corona virus dataset`
GROUP BY Months;


-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
    SUM(Recovered) as TotalRecoveredCases,
    AVG(Recovered) as AverageRecoveredCases,
    VARIANCE(Recovered) as VarianceCases,
    STDDEV(Recovered) as StdDevCases
FROM `corona virus dataset`;


-- Q14. Find Country having highest number of the Confirmed case
SELECT 
	`Country/Region`,
    SUM(Confirmed) as HighestConfirmedCases
FROM `corona virus dataset`
GROUP BY `Country/Region`
ORDER BY  HighestConfirmedCases 
DESC 
LIMIT 1;



-- Q15. Find Country having lowest number of the death case
SELECT 
	`Country/Region`,
    SUM(Deaths) as LowestDeathCases
FROM `corona virus dataset`
GROUP BY `Country/Region`
ORDER BY  LowestDeathCases  
LIMIT 1;


-- Q16. Find top 5 countries having highest recovered case
SELECT 
	`Country/Region`,
    SUM(Recovered) as HighestRecoveredCases
FROM `corona virus dataset`
GROUP BY `Country/Region`
ORDER BY  HighestRecoveredCases 
DESC 
LIMIT 5;