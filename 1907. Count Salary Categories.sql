drop table accounts;

CREATE TABLE `sql50`.`accounts` (
  account_id int,
	income int);

insert into sql50.accounts
values
(3, 108939),
(2, 12747),
(8, 87709),
(6, 91796);

select * from accounts;

#8th March 2025
with salary_buckets_cte as
(
    select
			account_id,
           case
                when income < 20000 then "Low Salary"
                when income between 20000 and 50000 then "Average Salary"
                when income > 50000 then "High Salary"
            end
                as category
    from accounts
)

select "Low Salary" as category, (select count(*) from salary_buckets_cte where category = "Low Salary") as accounts_count
union
select "High Salary" as category, (select count(*) from salary_buckets_cte where category = "High Salary") as accounts_count
union
select "Average Salary" as category, (select count(*) from salary_buckets_cte where category = "Average Salary") as accounts_count;
