
                            segment 2 MOVIE RELEASED TREND
	--Determine the total number of movies released each year and analyse the month wise trend
    --calculate the number of  movies produced  in the USA  OR INDIA in the year 2017
​
quest 1)--Determine the total number of movies released each year and analyse the month wise trend
ANSWER 1)
	select year,substr(date_published,4,2),count(title) as movie_released 
    from movie
    group by year ,substr(date_published,4,2)
    order by year 
quest 2) --calculate the number of  movies produced  in the USA  OR INDIA in the year 2019
  ANSWER 2) 
   select count(id) as movie_produced_in_2019 from movie
    where country ='USA' or country='INDIA' and year =2019
   
   -- assignment movie released in 2017 movie released in 2018 movie released in 2019
SELECT
 
    SUM(CASE WHEN (country = 'USA' OR country = 'INDIA') AND year = 2017 THEN 1 ELSE 0 END) AS movie_produced_in_2017,
    SUM(CASE WHEN (country = 'USA' OR country = 'INDIA') AND year = 2018 THEN 1 ELSE 0 END) AS movie_produced_in_2018,
    SUM(CASE WHEN (country = 'USA' OR country = 'INDIA') AND year = 2019 THEN 1 ELSE 0 END) AS movie_produced_in_2019
FROM movie
WHERE country IN ('USA', 'INDIA') AND year IN (2017, 2018, 2019)