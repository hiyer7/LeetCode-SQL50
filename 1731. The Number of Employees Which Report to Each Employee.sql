#5th March 2025

CREATE TABLE `sql50`.`Employees_reports_to` (
  `employee_id` INT,
  `name` varchar(45),
  `reports_to` int,
  `age` int);
  
insert into sql50.Employees_reports_to
values
(1,"Michael",null,45),
(2,"Alice",1,38),
(3,"Bob", 1,42),
(4,"Charlie",2,34),
(5,"David",2   ,40),
(6,"Eve",3,37),
(7,"Frank",null,50),
(8,"Grace",null,48);

select * from sql50.Employees_reports_to;

select a.reports_to, 
	   b.name,
	   count(b.employee_id) as reports_count,
       round(avg(a.age),0) as average_age
from sql50.Employees_reports_to a
join sql50.Employees_reports_to b
on a.reports_to = b.employee_id
group by 1,2
order by 1, 2;
