SELECT * FROM imbd_movie.ratting;
-    CREW ANALYSIS
1).Identify the columns in names table that have null values.
2) Determin the top 3 directors in the top three genre with movies having an average rating> 8
3) Find the top two actors whose movies have a median rating>=8
4) Identify the top 3 production houses based on the  number of  votes received by their movies
5) Rank actors based on their average rating  in Indian  movies released  in India
6) Identify the Top  five actress IN Hindi movies released in India based on their average rating
​
​
QUESTION 1) Identify the columns in names table that have null values.
​
select 
   sum(case when id='' then 1 else 0 end) as Null_for_id,
    sum(case when name='' then 1 else 0 end) as Null_for_Name,
   sum(case when date_of_birth='' then 1 else 0 end) as Null_for_DOB,
   sum(case when known_for_movies='' then 1 else 0 end) as known_for_movies,
   sum(case when height='' then 1 else 0 end) as Null_for_height
from names
   
QUESTION 2)Determin the top 3 directors in the top three genre with movies having an average rating> 8
answer 2)
​
              how to extract top 3 genre
SELECT g.genre ,count(m.id)as movies from movie m
left join genre g on m.id=g.movie_id 
group by genre order by  movies desc limit 3
​
​
given below code is for full concept-------
WITH cte AS (
    SELECT  d.name_id, g.genre, n.name,COUNT(*) AS movie_count,
        ROW_NUMBER() OVER (PARTITION BY g.genre ORDER BY COUNT(*) DESC) AS director_rank
    FROM director_mapping d
    LEFT JOIN names n ON d.name_id = n.id
    LEFT JOIN movie m ON d.movie_id = m.id
    LEFT JOIN genre g ON m.id = g.movie_id
    LEFT JOIN rating r ON m.id = r.movie_id
    WHERE  r.avg_rating > 8
    GROUP BY d.name_id, g.genre, n.name order by movie_count desc)
SELECT genre, name,SUM(movie_count) AS total_movie_count, director_rank FROM cte 
WHERE  director_rank <= 3
GROUP BY genre, name, director_rank;
​
​
​
​
​
​
​
​
QUESTION 3) Find the top two actors whose movies have a median rating>=8
answer 3)
select movie_id from role_mapping where category='actor'
​
--This one i think is accurate 
SELECT ro.name_id,COUNT(r.movie_id) AS movies 
FROM role_mapping ro
LEFT JOIN rating r ON  ro.movie_id=r.movie_id 
WHERE ro.category = 'actor' AND r.median_rating > 8
GROUP BY ro.name_id LIMIT 2;
​
​
-- This one told by instructor but i dont think its right to use movie table when we dont have need
select r.name_id,count(m.id) as movies from movie m
left join role_mapping r on m.id=r.movie_id
left join rating s on m.id=s.movie_id
where r.category ='actor' and s.median_rating>8
group by r.name_id limit 2	
​
​
​
QUESTION 4) Identify the top 3 production houses based on the  number of  votes received by their movies
answer 4)
SELECT DISTINCT PRODUCTION_COMPANY as Production_House ,SUM(TOTAL_VOTES)AS VOTES FROM MOVIE M
LEFT JOIN RATING R ON R.MOVIE_ID=M.ID
GROUP BY PRODUCTION_COMPANY
ORDER BY VOTES DESC LIMIT 3
​
​
​
QUESTION 5) Rank actors based on their average rating  in Indian  movies released  in India
​
ANSWER 5)
​
WITH CTE AS (
    SELECT DISTINCT  R.NAME_ID, AVG(S.AVG_RATING) AS AVERAGE
    FROM MOVIE M
    LEFT JOIN ROLE_MAPPING R ON M.ID = R.MOVIE_ID
    LEFT JOIN RATING S ON M.ID = S.MOVIE_ID
    LEFT JOIN PROJECT P ON M.ID = P.ï»¿id
    WHERE P.COUNTRY = 'INDIA' and r .category='actor'
    GROUP BY R.NAME_ID
    ORDER  BY AVERAGE DESC
)
SELECT *, ROW_NUMBER() OVER (ORDER BY AVERAGE DESC) AS RANKING
FROM CTE
​
QUESTION 6)
​
​
ANSWER 6)Identify the Top  five actress IN Hindi movies released in India based on their average rating
WITH CTE AS (
    SELECT DISTINCT  R.NAME_ID, AVG(S.AVG_RATING) AS AVERAGE
    FROM MOVIE M
    LEFT JOIN ROLE_MAPPING R ON M.ID = R.MOVIE_ID
    LEFT JOIN RATING S ON M.ID = S.MOVIE_ID
    LEFT JOIN PROJECT P ON M.ID = P.ï»¿id
    WHERE P.COUNTRY = 'INDIA' AND R.CATEGORY='actress' AND M.LANGUAGES='Hindi'
    GROUP BY R.NAME_ID
    ORDER  BY AVERAGE DESC limit 5
)
SELECT *, ROW_NUMBER() OVER (ORDER BY AVERAGE DESC) AS RANKING
FROM CTE;