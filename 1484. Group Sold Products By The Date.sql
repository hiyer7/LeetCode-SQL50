#16th March 2025

Create table If Not Exists sql50.Activities (sell_date date, product varchar(20));
Truncate table Activities;


insert into Activities values ('2020-05-30', 'Headphone');
insert into Activities values ('2020-06-01', 'Pencil');
insert into Activities values ('2020-06-02', 'Mask');
insert into Activities values ('2020-05-30', 'Basketball');
insert into Activities values ('2020-06-01', 'Bible');
insert into Activities values ('2020-06-02', 'Mask');
insert into Activities values ('2020-05-30', 'T-Shirt');

select * from activities;

select sell_date,
		count(distinct product) as num_sold,
        group_concat(distinct product order by product asc separator ',') as products
from activities

group by 1
order by 1
###order by inside group concat is for the order in which the concated column is arranged.