drop table sql50.seat;

CREATE TABLE `sql50`.`seat` (
  `id` INT,
  `student` varchar(45));

insert into sql50.seat
values
(1,"Abott"),
(2,"Dorris"),
(3,"Emerson"),
(4,"Green"),
(5,"Jeames");

with number_rows_cte as
(select *,
		count(*) over () as number_of_rows
from seat),

lead_lag_cte as(
select *,
		lead(id, 1) over () as lead_id,
        lag(id, 1) over () as lag_id
from number_rows_cte
),

id_swap_cte as(
select *,
		if( id%2 = 0, lag_id, lead_id) as new_id
from lead_lag_cte)

select if(new_id is null, id, new_id) as id,
		student
from id_swap_cte