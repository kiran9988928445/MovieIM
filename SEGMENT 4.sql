 segment 4 Rating analysis and crew members
 -- Retrieve the minimum and maximum value in each column of the rating  table(except movie_id)
 --Identify the top 10 movies based on the average rating
 -- Summarise the Rating table based on movie count by median rating.
 --identify the production house that has produced the most number of hit movies (average rating>0),
 -- Determin the number of movies released in each genre during  March 2017  in the USA  with more  than 1000 votes
 -- Retrieve movie of each genre starting  with the word 'The' and having  and average rating >8
 
 question 1)-- Retrieve the minimum and maximum value in each column of the rating  table(except movie_id)
answer 1)
 
select max(avg_rating) as  maximum_average_rating,
min(avg_rating) as  minimum_average_rating,
max(total_votes) as maximum_total_votes,
min(total_votes) as minimu_total_votes,
max(total_votes) as maximum_median_votes,
min(total_votes) as minimum_median_votes
 from rating
 
 
 question 2) --Identify the top 10 movies based on the average rating
  answer 2) 
  select id,title,r.avg_rating from movie m
  left join rating r on m.id=r.movie_id
  order by r.avg_rating desc limit 10
​
     
       OR   
       
             ASSIGNMENT--      If i want movie Title along with the top 10 average based movies
​
WITH cte AS (
    SELECT m.title as Movie_Name, r.avg_rating
    FROM movie m
    LEFT JOIN rating r ON m.id = r.movie_id
    ORDER BY avg_rating DESC
)
SELECT *, dense_RANK() OVER(ORDER BY avg_rating DESC) AS Rank_of_Movie
FROM cte;
​
QUESTION 3) -- Summarise the Rating table based on movie count by median rating.
ANSWER 3)
​
select median_rating,count(movie_id)as Num_of_Movies from rating
group by median_rating
order by median_rating desc
​
QUESTION 4) --identify the production house that has produced the most number of hit movies (average rating>0),
ANSWER--4)
 
SELECT production_company,count(id)as movies from movie m
left join rating r on  m.id=r.movie_id
where r.avg_rating>8 
group by production_company 
order by count(id) desc	
​
​
QUESTION 5) Determin the number of movies released in each genre during  March 2017  in the USA  with more  than 1000 votes
​
ANSWER 5--)
​
SELECT g.genre,count(id) from movie m
left join genre g on m.id=g.movie_id
left join rating r on m.id=r.movie_id
where year='2017' and country='USA' AND total_votes>1000
group by genre
​
​
QUESTION 6) -- Retrieve movie of each genre starting  with the word 'The' and having  and average rating >8
answer 6) 
SELECT g.genre,m.title from movie m
join genre g on m.id=g.movie_id
join rating r on m.id=r.movie_id
where m.title  like 'The%' and r.avg_rating>8