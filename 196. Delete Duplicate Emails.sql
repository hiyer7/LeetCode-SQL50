CREATE TABLE `sql50`.`person` (
  `id` INT,
  `email` varchar(45));

insert into sql50.person
values
(1,"john@example.com "),
(2,"bob@example.com"),
(2,"john@example.com ");

use sql50;
select * from person;

with min_id_cte as
(
select id as old_id,
		min(id) over (partition by email) as id,
	   email	   
from person
),
delete_duplicate_cte as
( 
select id,
	   email 
from min_id_cte
where id != old_id)

-- delete id, email
-- from delete_duplicate_cte
-- where 
delete from min_id_cte
where id != old_id;


