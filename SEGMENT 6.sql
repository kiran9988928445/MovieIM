SELECT * FROM imbd_movie.`role mapping`;
 
  SEGMENT  6 --Broader Understanding of Data 
--  classify thriller movies based on average rating into different catagories.
--  Analysis the genre-wise running total(CUMSUM) and moving average of the average movie duration
--  identify the five highest grossing movies of each year that belong to top three 
-- Determin the Top two Production house that have produced highest number of hit 
-- Identify the top three actoress based on the number of Super hit movies (average rating
-- Retrieve the details of top  nine directors bases on the number of movies,including 
​
QUESTION 1) --  classify thriller movies based on average rating into different catagories.
ANSWER 1)
​
​
SELECT m.id,r.AVG_RATING ,
CASE
        WHEN r.avg_rating >= 8.0 THEN 'Hit'
        WHEN r.avg_rating >= 6.0 THEN 'Average'
        ELSE 'Flop' end as Movie_catagory
FROM MOVIE M
LEFT JOIN GENRE G ON M.ID=G.MOVIE_ID
LEFT JOIN RATING R ON M.ID=R.MOVIE_ID
WHERE G.GENRE='Thriller' 
​
QUESTION 2)  Analysis the genre-wise running total(CUMSUM) and moving average of the average movie duration
ANSWER 2)
​
SELECT id ,genre,duration,
sum(duration) over (partition by genre  order by id) cum_sum, 
avg(duration) over (partition by genre  order by id) moving_Average
from movie
left join genre on (movie.id=genre.movie_id) 
​
​
​
QUESTION 3) identify the five highest grossing movies of each year that belong to top three GENRE
​
ANSWER3)SELF
WITH CTE AS (SELECT m.id, g.genre, m.title, m.worlwide_gross_income,m.year,
        RANK() OVER (PARTITION BY m.year, g.genre ORDER BY m.worlwide_gross_income DESC) AS ranking
    FROM movie m
    LEFT JOIN genre g ON m.id = g.movie_id
),
CTE_GenreRank AS (SELECT DISTINCT genre,
        RANK() OVER (ORDER BY movies DESC) AS genre_rank
    FROM (
        SELECT  genre,COUNT(id) AS movies
        FROM CTE
        GROUP BY genre LIMIT 3
    ) genre_count
    LIMIT 3
)
SELECT cte.title, cte.worlwide_gross_income, cte.year, cte.genre
FROM CTE cte
JOIN CTE_GenreRank genre_rank ON cte.genre = genre_rank.genre
WHERE cte.ranking <= 5
ORDER BY cte.year, genre_rank.genre_rank, cte.ranking;
​
QUESTION 4)  Determin the Top two Production house that have produced highest number of hits among multilingual movies.
ANSWER 4)SELF
​
SELECT m.production_company,languages, count(id) as Total_movies
FROM movie m
LEFT JOIN rating r ON m.id = r.movie_id
WHERE  languages like '%,%'  AND r.avg_rating > 8
GROUP BY m.production_company,languages
order by total_movies desc limit 2 
​
QUESTION 5)Identify the top three actoress based on the number of Super hit movies (average rating>8) IN THE DRAMA  GENRE
ANSWER 5)  SELF
​
SELECT id,g.genre,count( m.id) as movie_produced
FROM movie m
left join rating r on m.id=r.movie_id
left join role_mapping ro on m.id=ro.movie_id
left join genre g on m.id=g.movie_id
where ro.category='actress' and r.avg_rating>8 and g.genre='Drama'
group by id,g.genre order by movie_produced desc  limit 3
​
QUESTION 6)  Retrieve the details of top  nine directors bases on the number of movies,including average inter movie duration,rating,more
ANSWER 6)
​
WRITTEN BY ME BUT CONFUSION AT ONLY ONE PLACE OUTPUT IS CORRECT
select 
 d.name_id as director_id,
 n.name as director_name,
 count(m.id)as num_Movies_produced,
 avg(m.duration)as average_duration,
 avg(r.avg_rating) from movie m
 left join genre g on m.id=g.movie_id
left join director_mapping d on m.id=d.movie_id
left join rating r on m.id=r.movie_id
LEFT join names n on d.name_id=n.id
where d.name_id is not null
group by d.name_id,n.name order by num_Movies_produced desc
​
​
