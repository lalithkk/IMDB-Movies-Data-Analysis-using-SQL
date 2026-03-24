use project_movie_database;
show tables;
desc movies;
desc directors;

-- a)Can you get all data about movies?
select * from movies;

-- c)Check how many movies are present in IMDB
select count(*) as Total_movies from movies;
 
-- Total distinct rows in moives table &  checking a null vaules in movies
select count(distinct id,original_title,budget,popularity,release_date,revenue,title,vote_average,vote_count,overview,tagline,uid,director_id)
as unique_count,
sum(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_id,
sum(CASE WHEN original_title IS NULL THEN 1 ELSE 0 END) AS null_original_title,
sum(CASE WHEN budget IS NULL THEN 1 ELSE 0 END) AS null_budget,
sum(CASE WHEN popularity IS NULL THEN 1 ELSE 0 END) AS null_popularity,
sum(CASE WHEN release_date IS NULL THEN 1 ELSE 0 END) AS null_release_date,
sum(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS null_revenue,
sum(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS null_title,
sum(CASE WHEN vote_average IS NULL THEN 1 ELSE 0 END) AS null_vote_average,
sum(CASE WHEN vote_count IS NULL THEN 1 ELSE 0 END) AS null_vote_count,
sum(CASE WHEN overview IS NULL THEN 1 ELSE 0 END) AS null_overview,
sum(CASE WHEN tagline IS NULL THEN 1 ELSE 0 END) AS null_tagline,
sum(CASE WHEN uid IS NULL THEN 1 ELSE 0 END) AS null_uid,
sum(CASE WHEN director_id IS NULL THEN 1 ELSE 0 END) AS null_director_id
from movies;

-- To find rows where a column is NULL in movies table
select * from movies  where  tagline is null;
	
-- a)How do you get all data about directors 
select * from directors; 

-- Total row in directors table
select count(*) from directors;

-- Total distinct rows  &  checking a null vaules in directors
select count(distinct name,id,gender,uid,department) as unique_count,
sum(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS null_name,
sum(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_id,
sum(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
sum(CASE WHEN uid IS NULL THEN 1 ELSE 0 END) AS null_uid,
sum(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS null_department
from directors;

--  Find these 3 directors: James Cameron ; Luc Besson ; John Woo
select * from directors 
where name in('James Cameron','Luc Besson','John Woo');

-- Find all directors with name starting with S
select * from directors 
where name like 's%';

-- Count female directors 
select count(name) as Female_directors from directors
where gender = 1;

-- Find the name of the 10th first women directors
select name from directors 
where gender =1 
limit  1 offset 9;

-- What are the 3 most popular movies
select original_title,popularity
from movies
order by popularity desc
limit 3;

-- What are the 3 most bankable movies
select original_title,revenue
from movies
order by revenue desc
limit 3; 

--  What is the most awarded average vote since the January 1st, 2000
select * from movies
where  date_format(release_date,'%m %d %y') >='01-01-2000'
order by vote_average desc
limit 1;

-- Which movie(s) were directed by Brenda Chapman
SELECT m.original_title,d.name
FROM movies m
JOIN directors d
ON m.director_id = d.id
WHERE d.name = 'Brenda Chapman';


-- Which director made the most movies?
SELECT d.name, COUNT(*) AS total_movies
FROM movies m
JOIN directors d
ON m.director_id = d.id
GROUP BY d.name
ORDER BY total_movies DESC
LIMIT 1;

-- Which director is the most bankable
select d.name,sum(m.revenue) as Highest_revenue
from movies m
join directors d
on m.director_id = d.id
group by d.name
order by Highest_revenue desc
limit 1;