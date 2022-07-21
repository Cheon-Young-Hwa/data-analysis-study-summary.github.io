select * from titles
limit 10;

insert into employees
values
(999903, '1977-09-14', 'Johnathan', 'Creek', 'm', '1999-1-1');
select * from employees
order by emp_no desc
limit 10;


insert into titles
(emp_no, from_date, title)
values
(999903, '1997-10-01', 'Senior Engineer');

select * from titles
order by emp_no desc
limit 10;

select * from dept_emp
limit 10;


insert into dept_emp
values
(999903, 'd005', '1997-10-01', '9999-01-01');
select * from dept_emp
order by emp_no desc
limit 10;


select * from departments
limit 10;

insert into departments
values
('d010', 'Business Analysis');

select * from departments
limit 10;

alter table departments






