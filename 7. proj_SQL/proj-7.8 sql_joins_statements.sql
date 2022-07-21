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


select round(avg(salary), 2) from salaries
where from_date > '1997-01-01';


create table departments_dup (dept_no char(4), dept_name varchar(40))
primary key (dept_no);


create table if not exists departments_dup
(dept_no char(4) null, dept_name varchar(40) null);


INSERT INTO `departments` VALUES 
('d001','Marketing'),
('d002','Finance'),
('d003','Human Resources'),
('d004','Production'),
('d005','Development'),
('d006','Quality Management'),
('d007','Sales'),
('d008','Research'),
('d009','Customer Service');

select * from departments
order by dept_no;

insert into departments_dup (dept_no, dept_name)
select * from departments;

select * from departments_dup
order by dept_no;

insert into departments_dup (dept_name)
values ('Public Relationship');

delete from departments_dup
where dept_no = 'd002';
insert into departments_dup (dept_no)
values ('d010'), ('d011');




create table if not exists dept_manager_dup (
emp_no int(11) not null,
dept_no char(4) null,
from_date date not null,
to_date date null
);
alter table dept_manager_dup
modify dept_no char(4) null;

insert into dept_manager_dup 
select * from dept_manager;

select * from dept_manager_dup;


INSERT INTO dept_manager_dup (emp_no, from_date)

VALUES               (999904, '2017-01-01'),

                                (999905, '2017-01-01'),

                               (999906, '2017-01-01'),

                               (999907, '2017-01-01');

 

DELETE FROM dept_manager_dup

WHERE

    dept_no = 'd001';

DELETE FROM departments_dup

WHERE

    dept_no = 'd002'; 

INSERT INTO departments_dup (dept_name)

VALUES                ('Public Relations');

select * from departments_dup;
select * from dept_manager_dup;



select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
inner join departments_dup d 
on m.dept_no = d.dept_no
order by m.dept_no;


select e.emp_no, e.first_name, e.last_name, dept_no, e.hire_date 
from employees e
inner join dept_manager m
on e.emp_no = m.emp_no;

select * from dept_manager;

select e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
from employees e
left join dept_manager m
on e.emp_no = m.emp_no
where e.last_name = 'Markovitch';


select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m, departments_dup d
where m.dept_no = d.dept_no;


select m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date 
from dept_manager m, employees e
where m.emp_no = e.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '')


SELECT
    e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch';

SELECT

    e.first_name, e.last_name, e.hire_date, t.title

FROM

    employees e

        JOIN

    titles t ON e.emp_no = t.emp_no

WHERE

    first_name = 'Margareta'

        AND last_name = 'Markovitch'

ORDER BY e.emp_no

;

select e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
from employees e
join titles t on e.emp_no = t.emp_no
where first_name = 'Margareta' and last_name = 'Markovitch'
order by emp_no;


select m.*, d.* 
from dept_manager m 
cross join departments d
where d.dept_no = 'd009'
order by m.dept_no;


SELECT

    dm.*, d.*  

FROM  

    departments d  

        CROSS JOIN  

    dept_manager dm  

WHERE  

    d.dept_no = 'd009'  

ORDER BY d.dept_no;


SELECT

    e.*, d.*

FROM

    employees e

        CROSS JOIN

    departments d

WHERE

    e.emp_no < 10011

ORDER BY e.emp_no, d.dept_name;



select e.gender, avg(s.salary)
from employees e
join salaries s on e.emp_no = s.emp_no
group by e.gender;


select e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
from employees e
join dept_manager m on e.emp_no = m.emp_no
join departments  d on m.dept_no = d.dept_no;


select e.first_name, e.last_name, e.hire_date,t.title, m.from_date, d.dept_name
from employees e
left join dept_manager m on m.emp_no = e.emp_no
join departments d on m.dept_no = d.dept_no
join titles t on e.emp_no = t.emp_no;

select d.dept_name, avg(s.salary) as avg_salary
from departments d
join dept_manager m on d.dept_no = m.dept_no
join salaries s on m.emp_no = s.emp_no
group by d.dept_name
having avg_salary > 60000
order by avg_salary desc;


select gender, count(gender) as gender_count
from employees e
join dept_manager m on e.emp_no = m.emp_no
group by gender;


select * from 
(select e.emp_no, e.first_name, e.last_name, null as dept_no, null as from_date
from employees e
where last_name = 'Denis'
union select dm.emp_no, null as first_name, null as last_name, dm.dept_no, dm.from_date
from dept_manager dm) as a
order by -a.emp_no desc;


