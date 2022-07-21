select * from dept_emp;

select count(distinct dept_no)
from dept_emp;


select * from salaries
limit 10;

select sum(salary)
from salaries
where from_date > '1997-01-01';


select min(emp_no) from employees;


select max(emp_no) from employees;

select avg(salary) from salaries
where from_date > '1997-01-01';


select dept_no, dept_name, coalesce(dept_no, dept_name) as dept_info
from departments
order by dept_no; 

select * from departments;


select 
ifnull(dept_no, "N/A") as dept_no, 
ifnull(dept_name,"Department name not provided") as dept_name,
coalesce(dept_no, dept_name) as dept_info
from departments
order by dept_no; 

select * from departments
order by dept_no;

create table departments_dup (dept_no char(4), dept_name varchar(40));

insert into departments_dup (dept_no, dept_name)
values("d001", " Marketing");


select * from departments_dup
order by dept_no;

delete from departments_dup
where dept_no = "d001";


insert into departments_dup (dept_no, dept_name)
select * from departments;

alter table departments_dup
change column dept_no dept_no char(4) null; # dept_name varchar(40) dept_name varchar(40) null;

alter table departments_dup
change column dept_name dept_name varchar(40) null;

insert into departments_dup (dept_name)
values ("Public Relationship");

delete from departments_dup
where dept_no = "d002";

insert into departments_dup (dept_no)
values ("d010");
insert into departments_dup (dept_no)
values ("d011");



delete from departments_dup
where dept_no = 'd010' or dept_no = 'd011'; # The operation should be or not and.
insert into departments_dup (dept_no)
values ("d010"), ("d011");


drop table if exists dept_manager_dup;
create table dept_manager_dup
(emp_no int(11) not null, 
dept_no int(4) null,
from_date date not null,
to_date date null);
alter table dept_manager_dup
modify dept_no char(4) null;

insert into dept_manager_dup
select * from dept_manager;
select * from dept_manager_dup;

insert into dept_manager_dup (emp_no, from_date)
values ('999904', '2017-01-01'), ('999905', '2017-01-01'),
('999906', '2017-01-01'), ('999907', '2017-01-01');
select * from dept_manager_dup;

delete from dept_manager_dup
where dept_no = 'd001';
insert into dept_manager_dup (dept_name)
values ('Republic Relationship');
select * from departments_dup;
