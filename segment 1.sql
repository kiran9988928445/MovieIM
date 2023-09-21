QUESTION 1)-- Find the total number of rows in each table of schema
ANSWER 1)
​
select COUNT(*) from movie;
select COUNT(*) from genre;
select COUNT(*) from names;
select COUNT(*) from project;
select Count(*) from ratting;
select COUNT(*) from role_mapping;


quest 2)-- identify which column have null value in movies table
ANSWER 2)
part 1 by using simple count

 
 SELECT
    COUNT(country) AS country_null,
    (SELECT COUNT(languages) FROM movie WHERE languages='') AS language_null
FROM movie
WHERE  country='';
 
 
 part 2 by using switch statement
select sum(case when country= '' then 1 else 0 end) as country_nulls,
 sum(case when languages= '' then 1 else 0 end) as language_null
from movie 
​

​
​
​
