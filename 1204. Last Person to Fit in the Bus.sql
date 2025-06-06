drop table queue;

CREATE TABLE `sql50`.`queue` (
  person_id int,
  `p_name` varchar(40),
	weight int,
	turn int);

insert into sql50.queue
values
(5,"Alice", 250, 1),
(4, "Bob", 175, 5),
(3,"Alex", 350, 2),
(6,"John Cena", 400, 3),
(1,"Winston", 500, 6),
(2,"Marie", 200, 4);

select * from queue;

with running_weight_cte as(
select p_name,
       weight,
       turn,
       sum(weight) over (order by turn) as running_weight
from queue)

select distinct last_value(p_name) over () as person_name
from running_weight_cte
where running_weight <=1000

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select person_name
from
(select person_name,
       sum(weight) over (order by turn) as rolling_sum
from queue) tbl
where rolling_sum <=1000
order by rolling_sum desc
limit 1;
