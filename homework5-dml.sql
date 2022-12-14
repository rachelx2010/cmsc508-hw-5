-- homework5-ddl.sql

-- task 1
-- How many records were loaded into the RAW_COUNTRY table?
-- (skills: select, aggregate)
select count(*) from raw_country;

select sum(country_count) FROM raw_country;
-- task 2
-- write out the first 10 records and look at their columns
-- Do you see any blanks or missing data?
-- (skills: select, limit)
select * from raw_country limit 10;

-- task 3
-- How many records are NOT for countries, that is
-- they're for regions or groups of countries.
-- How can you tell?  Then write a query to list all
-- the non-countries
-- (skills: select, where)
select
    country_short_name,
    country_full_name,
    country_region
FROM
    raw_country
WHERE
    country_region ='';

-- task 4
-- Now, go back to your DDL file (Task 4) and create a new table
-- using CREATE TABLE ... SELECT from WHERE syntax.
-- Finally, below write a query to return the number
-- of records in the new table.
-- "According to the World Bank, how many countries are in the world?"
-- (skills: select, aggregate)
SELECT SUM(country_count) FROM COUNTRY;

-- task 5
-- Let's investigate the country_region field.
-- What is the domain of the country_region field? That is,
-- what are the unique values found there?
-- (there are several possible ways to code this in SQL)
-- (skills: select, aggregate, order by)
SELECT country_region FROM COUNTRY GROUP BY country_region;

-- task 6
-- How many countries are in each region?
-- (skills: select, aggregate, group by, order by)
SELECT 
    country_region,
    sum(country_count)
FROM
    COUNTRY
GROUP BY
    country_region
ORDER BY
    sum(country_count) DESC;

-- task 7
-- List the country full names and regions for all countries in north america
-- (skills: select, where, order by)
SELECT
    country_full_name,
    country_region
FROM
    COUNTRY
WHERE
    country_region='North America';

-- task 8
-- The World Cup soccer tournament starts November 20.  The host country is Qatar.
-- What region contains Qatar?  List the region, country short name and full name
-- (skills: select, where)
SELECT
    country_region,
    country_short_name,
    country_full_name
FROM
    COUNTRY
WHERE
    country_short_name = 'Qatar';

-- task 9
-- There are two abbreviation fields in the data country_abbr and country_wb_abbr.
-- List the country code, short name, abbr, wb_abbr and region for all the countries
-- where the abbr and wb_abbr are different.
-- (skills: select, where, order by)
SELECT
    country_code,
    country_short_name,
    country_abbr,
    country_wb_abbr,
    country_region
FROM
    COUNTRY
WHERE
    country_abbr<>country_wb_abbr;

-- task 10
-- Now, let's investigate the "income category" field.
-- List the income categories and the number of countries in each in 
-- descending order of most countries to least.
-- (skills: select, aggregate, group by, order by)
SELECT 
    country_income_category,
    sum(country_count)
FROM
    COUNTRY
GROUP BY
    country_income_category
ORDER BY
    sum(country_count) DESC;

-- task 11
-- mystery task.  Looking at the table from Task 10, write the
-- next obvious query based on the results in the table.
-- At a minimum, your query should put country short name in the first column.
-- you will be scored on the number of records returned and the value(s) 
-- in the first column.
SELECT 
    country_short_name,
    country_region,
    country_income_category
FROM
    COUNTRY
WHERE
    country_income_category='';

-- task 12
-- OK, this HAS to be an error. Let's make a assumption that the country 
-- in question, because they are oil-rich, are "high income".  
-- Write an update comment to correct the issue.
-- NOTE - if you get this wrong, all subsequent tables will be wrong!
UPDATE 
    COUNTRY 
SET 
    country_income_category='High income' 
WHERE
    country_income_category = '';


-- task 13
-- Write a single query that shows each region and the number of countries in each
-- income category within the country.  Rather than use COUNT, use GROUP BY and SUM.
-- (skills: select, aggregate, group by, order by)
SELECT
    country_region,
    country_income_category,
    sum(country_count)
FROM
    COUNTRY
GROUP BY
    country_region,
    country_income_category
ORDER BY
    1,2,3 DESC;

-- task 14
-- Examine the result from task 12. It would be really cool to
-- present the results of this table in a 2-D form, with 
-- columns for each income category (high, upper middle, lower middle, low, other)
-- regions down the side, and the pair-wise count inside each cell.
-- Using CASE statements, DO IT!  BE SURE to include the countries without
-- an income category.
-- HINT - your query should return 6 columns: the region name, one
-- column for each of the income categories (e.g., High, Upper middle, etc.)
-- and a column for the row totals.
-- (skills: select, aggregate, group by, nested query)
SELECT
    country_region,
    sum( case when country_income_category='High income' then country_count else 0 end ) as col_high_income,
    sum( case when country_income_category='Upper middle income' then country_count else 0 end ) as col_upper_middle_income,
    sum( case when country_income_category='Lower middle income' then country_count else 0 end ) as col_lower_middle_income,
    sum( case when country_income_category='Lower income' then country_count else 0 end ) as col_lower_income,
    sum(country_count) as "Row Total"
FROM
    COUNTRY
GROUP BY
    country_region
ORDER BY
    1,2,3 DESC;

-- task 15
-- Wow! what a cool table!  It is very interesting to see where the money
-- sits around the world.  Using the general approach from Task 13 above
-- and write a query to return the single region with the most lower-income countries.
-- Your query should return 2 columns, the region name and the number of low-income countries
-- PUT THE NUMBER FIRST!
-- (skills: select, aggregate, group by, nested query, order by, limit)
SELECT
    sum(country_count),
    country_region
FROM
    COUNTRY
WHERE
    country_income_category='Low income'
GROUP BY
    country_region
ORDER BY
    2 DESC
Limit 1;

-- task 16
-- Are you getting the hand of this? Good! We need to take a look at all
-- the countries in the same region and with the same income category as the Marshall Islands.
-- For each country that matches, print their country code, short name, region and 
-- income category, by order of their short name.  As a hint, the
-- country code for the Marshall Islands is MHL
-- (skills: select, where, subquery)
with micte as (
SELECT
    country_region,
    country_income_category
FROM
    COUNTRY
WHERE
    country_short_name='Marshall Islands'
)
SELECT
    country_code,
    country_region,
    country_income_category,
    country_short_name
FROM
    COUNTRY
WHERE
    1=1
    And country_region in (select country_region from micte)
    and country_income_category in (select country_income_category from micte);

-- task 17
-- OK - let's raise the heat in the kitchen! Review the output from task 13.  You'll see
-- that some of the regions do not contain all of the income levels.  For example,
-- the Europe & Central Asia region does not have any low income countries.
--
-- If I need to compute the average number of countries in each region-income pair,
-- I need to make sure that I include the missing pairs, otherwise my denominator will 
-- be wrong and my average won't be accurate.
--
-- CHALLENGE - using a SINGLE SQL statement, write a table that contains every
-- combination of region and income category (including the missing '') value!
--
-- THEN add a WHERE clause to only show the values that were missing from the original pairings!
--
-- HINT - there should be AT MOST [# of regions]x[# of income cats] = 28 rows in your final table!
-- Review that Task 13 found all the non-zero pairs, and the answer is 22.  SO - this table result should have 6 rows!
-- (skills: select, where, subqueries, joins)
WITH REGION_CTE AS (
SELECT DISTINCT country_region as CTE_REGION FROM COUNTRY
),
INCOME_CTE AS (
SELECT DISTINCT COUNTRY_INCOME_CATEGORY as CTE_INCOME_CATEGORY FROM COUNTRY
),
DATA_CTE AS (
SELECT
    country_region,
    country_income_category,
    sum(country_count) as cte_count
FROM
    COUNTRY
GROUP BY
    country_region,
    country_income_category
)
SELECT
    CTE_REGION,
    CTE_INCOME_CATEGORY,
    cte_count
FROM
    (REGION_CTE,INCOME_CTE) LEFT JOIN DATA_CTE on 
    (cte_region = country_region and CTE_INCOME_CATEGORY = country_income_category)
ORDER BY
    1,2

-- task 18
-- Hot enough, yet?  Let's go for ghost-pepper HOT!  Now let's build some
-- percentage tables.  For example, across the entire sample, what
-- is the percentage of total countries in each income category?
-- As a first step, build off the result from task 17 and create a table with
-- six columns (region, income cat, country count, sum of countries in region, sum of countries by income and total sum countries)
-- actually calculating percentages and print out a table will be a slam dunk after this!
-- (skills: select, where, subqueries, joins, aggregate functions)


-- task 19 
-- SLAM DUNK TIME!  Using the resulting table CTEs from Task 18, print out a table listing
-- the number, totals and percentage of countries by region.



-- task 20
-- SLAM DUNK TIME!  Using the resulting table CTEs from Task 18, print out a table listing
-- the number, totals and percentage of countries by income category


