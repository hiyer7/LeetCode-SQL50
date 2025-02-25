# 25th Feb 2025

select product_id, first_year, 
       quantity, price
from 
(select product_id, 
       year,
       min(year) over(partition by product_id order by year) as first_year,
       quantity, price
from sql50.sales) tbl
where year = first_year