Create table If Not Exists Products (product_id int, product_name varchar(40), product_category varchar(40));
Create table If Not Exists Orders1 (product_id int, order_date date, unit int);
Truncate table Products;

insert into Products values 
('1', 'Leetcode Solutions', 'Book'),
('2', 'Jewels of Stringology', 'Book'),
('3', 'HP', 'Laptop'),
('4', 'Lenovo', 'Laptop'),
('5', 'Leetcode Kit', 'T-shirt');

Truncate table Orders1;
insert into Orders1 values 
('1', '2020-02-05', '60'),
('1', '2020-02-10', '70'),
('2', '2020-01-18', '30'),
('2', '2020-02-11', '80'),
('3', '2020-02-17', '2'),
('3', '2020-02-24', '3'),
('4', '2020-03-01', '20'),
('4', '2020-03-04', '30'),
('4', '2020-03-04', '60'),
('5', '2020-02-25', '50'),
('5', '2020-02-27', '50'),
('5', '2020-03-01', '50');

select * from orders1;
select * from products;


select product_name,
		sum(unit) as unit
from products
join orders1
using (product_id)
where extract(month from order_date) = '2'
and extract(year from order_date) = '2020'
group by 1
having sum(unit) >= 100