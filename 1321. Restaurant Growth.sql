truncate Customer;
CREATE TABLE `sql50`.`Customer` (
  `customer_id` INT,
  `name` varchar(40),
  `visited_on` DATE,
  `amount` INT);

insert into sql50.Customer
values
(1,"Jhon","2019-01-01",100),
(2,"Daniel","2019-01-02",110),
(3,"Jade","2019-01-03",120),
(4,"Khaled","2019-01-04",130),
(5,"Winston","2019-01-05",110),
(6,"Elvis","2019-01-06",140),
(7,"Anna","2019-01-07",150),
(8,"Maria","2019-01-08",80),
(9,"Jaze","2019-01-09",110),
(1,"Jhon","2019-01-10",130),
(3,"Jade","2019-01-10",150);
with consolidated_amount_cte as
(
select visited_on,
		sum(amount) as amount
from sql50.customer
group by 1),


#select * from sql50.Customer;
visited_on_cte as
(select visited_on, date_sub(visited_on, interval 6 day) as six_day_before,
		min(visited_on) over () as min_date,
        round(sum(amount) over (order by visited_on rows between 6 preceding and current row),2) as amount,
		round(avg(amount) over (order by visited_on rows between 6 preceding and current row),2) as average_amount
from consolidated_amount_cte)

select visited_on, amount, average_amount from visited_on_cte
where six_day_before >= min_date