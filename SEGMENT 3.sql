
​
​
 
                              segment 3 : Production statistics  and genre analysis
 --Retrieve the unique list of genre present in the database
 --identify the unique list of  genre with highest number of movie produced overall
 --Determin the count of movie that belong to only one genre
 --calculate the average duration of the movie in each genre
 --Find the rank of the thriller genre among all genres in terms of number of movies produced
 
​
 question 1 ) Retrieve the unique list of genre present in the database
 ANSWER 1)
 CAN BE DONE IN TWO WAYS  -----
 1ST WAY 
 select Distinct genre from genre
      OR 
 2ND WAY     
 select distinct genre from movie m left join genre g on m.id=g.movie_id
​
question 2) identify the unique list of  genre with highest number of movie produced overall
ANSWER 2)
 select distinct genre,count(id)as movie_produced from movie m
 left join genre g on m.id=g.movie_id
 group by genre
order by count(id) desc 
​
question 3) --Determin the count of movie that belong to only one genre
​
written by self (no doubt to ask)
with cte as
 (SELECT id, g.genre,count(distinct genre)as genre_name FROM movie m
left join genre g on m.id=g.movie_id
group by id,g.genre
having count(id)<=1)
select genre,count(id) as movies from cte
group by genre
​
question 4) calculate the average duration of the movie in each genre
​
answer 4)
select genre,avg(duration)as avg_duration from movie 
left join genre on movie.id=genre.movie_id
group by genre
order by avg_duration desc
​
question 5) Find the rank of the thriller genre among all genres in terms of number of movies produced
with cte as
(select genre,count(id)as movies from movie 
left join genre on movie.id=genre.movie_id
group by genre order by  movies )
select *,
rank() over(order by movies desc ) as_rank
from cte