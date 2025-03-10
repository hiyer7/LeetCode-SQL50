use sql50;
truncate sql50.movies;
truncate sql50.users;
truncate sql50.MovieRating;

CREATE TABLE `sql50`.`movies` (
  `movie_id` INT,
  `title` varchar(45));

insert into sql50.movies
values
(1,"Avengers"),
(2,"Frozen 2"),
(2,"Joker");

CREATE TABLE `sql50`.`users` (
  `user_id` INT,
  `name` varchar(45));

insert into sql50.users
values
(1,"Daniel"),
(2,"Monica"),
(3,"Maria"),
(4,"James");

CREATE TABLE `sql50`.`MovieRating` (
  `movie_id` INT,
  `user_id` INT,
  `rating` INT,
  `created_at` date);

insert into sql50.MovieRating
values
(1, 1, 3, "2020-01-12"),
(1, 2, 4, "2020-02-11"),
(1, 3, 2, "2020-02-12"),
(1, 4, 1, "2020-01-01"),
(2, 1, 5, "2020-02-17"),
(2, 2, 2, "2020-02-01"),
(2, 3, 2, "2020-03-01"),
(3, 1, 3, "2020-02-22"),
(3, 2, 4, "2020-02-25");

#----------------Test Case 2
insert into sql50.movies
values
(1,"Rebecca");

insert into sql50.users
values
(1,"Rebecca");

insert into sql50.MovieRating
values
(1, 1, 5, "2020-02-12");


with user_rating_cte as (
    select distinct name as user_name,
    count(name) over(partition by name) as review_count
    #dense_rank() over (order by review_count) as user_rank
from MovieRating
left join users
using (user_id)
),

movie_rating_cte as (
    select title as movie_title,
    rating,
	extract(year from created_at) as year,
	extract(month from created_at) as month
    #count(title)    #dense_rank() over (order by (movie_count) desc) as movie_rank
from movies m 
join MovieRating mr
using (movie_id)
),

-- movie_rank_cte as
-- (
--     select *,
--             row_number() over (order by (movie_count) desc) as movie_rank
--     from movie_rating_cte
-- ),

user_rank_cte as
(
    select *,
            row_number() over (order by (review_count) desc) as user_rank
    from user_rating_cte
),

sum_rating_cte as
(
select distinct movie_title,
		avg(rating) over (partition by movie_title,year,month) as sum_rating
        from movie_rating_cte
where year=2020
and month=2),

movie_rank_cte as
(select *,
		row_number() over (order by sum_rating desc) as movie_rank
 from sum_rating_cte)
 
 
select user_name as results
from user_rank_cte
where user_rank = 1
union all
select movie_title as results
from movie_rank_cte
where movie_rank = 1;