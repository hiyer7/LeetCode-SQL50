Create table If Not Exists Users1 (user_id int, name varchar(30), mail varchar(50));
Truncate table Users1;
insert into Users1 values 
('1', 'Winston', 'winston@leetcode.com'),
('2', 'Jonathan', 'jonathanisgreat'),
('3', 'Annabelle', 'bella-@leetcode.com'),
('4', 'Sally', 'sally.come@leetcode.com'),
('5', 'Marwan', 'quarz#2020@leetcode.com'),
('6', 'David', 'david69@gmail.com'),
('7', 'Shapiro', '.shapo@leetcode.com');

select * from Users1;

select *
from users1
where mail regexp
'^[A-Za-z][A-Za-z0-9_.-]*@leetcode[\.].com$';

SELECT *
FROM Users1
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode.com$';

select * from users1
where lower(name) like lower(substring(mail));

select * from users1
where locate(name, mail) > 0