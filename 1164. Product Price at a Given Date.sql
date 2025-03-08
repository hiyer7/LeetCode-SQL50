CREATE TABLE `sql50`.`products_1164` (
  `product_id` INT,
  `new_price` INT,
  `change_date` DATE);

insert into sql50.products_1164
values
(1,20, "2019-08-14"),
(2,50, "2019-08-14"),
(1,30, "2019-08-15"),
(1,35, "2019-08-16"),
(2,65, "2019-08-17"),
(3,20, "2019-08-18");

select * from products_1164;

-- with rolling_price_cte as (
-- select change_date,
-- 		product_id,
-- 		new_price,
--         sum(new_price) over(partition by product_id order by change_date) as price
-- from products_1164),

-- sixteen_08_cte as(
-- select product_id,
-- 	   max(price) over (partition by product_id) as max_new_price
-- from rolling_price_cte
-- where change_date <= '2019-08-16')


-- select distinct p.product_id,
-- 	  if (max_new_price is null, 10, max_new_price) as price
-- from products_1164 p
-- left join
-- sixteen_08_cte
-- using (product_id)





with rolling_price_cte as (
select change_date,
		product_id,
		new_price,
        last_value(new_price) over(partition by product_id order by change_date) as price
from products_1164),

sixteen_08_cte as(
select product_id,
	   last_value(price) over (partition by product_id) as max_new_price
from rolling_price_cte
where change_date <= '2019-08-16')

select distinct p.product_id,
	  if (max_new_price is null, 10, max_new_price) as price
from products_1164 p
left join
sixteen_08_cte
using (product_id)

-- select distinct p.product_id,
-- 	  if (price is null, 10, price) as price
-- from products_1164 p
-- left join
-- rolling_price_cte
-- using (product_id)