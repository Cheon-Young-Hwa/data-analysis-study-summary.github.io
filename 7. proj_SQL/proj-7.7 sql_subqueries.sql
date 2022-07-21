select e.first_name, e.last_name
from employees e
where e.emp_no in (select dm.emp_no from dept_manager dm);


select * from dept_manager m
where m.emp_no in (select e.emp_no from employees e where
 e.hire_date between '1990-01-01' and '1995-01-01');


select e.* from employees e
where exists (select * from titles t where e.emp_no = t.emp_no and t.title = 'Assistant Engineer');


select * from (select e.emp_no as employee_ID,
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110022) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no <= 10020
group by e.emp_no
order by e.emp_no) as A
union 
select * from (select e.emp_no as employee_ID,
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110039) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no between 10021 and 10040
group by e.emp_no
order by e.emp_no) as B
;


drop table if exists emp_manager;

create table emp_manager
(emp_no int(11) not null, dept_no char(4) null, manager_no int(11) not null);


insert into emp_manager
select * from (select * from (select e.emp_no as employee_ID, 
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110022) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no <= 10020
group by e.emp_no
order by e.emp_no) as A
union 
select * from (select e.emp_no as employee_ID, 
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110039) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no between 10021 and 10040
group by e.emp_no
order by e.emp_no) as B
union
select * from (select e.emp_no as employee_ID, 
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110022) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no = 110039
group by e.emp_no
order by e.emp_no) as C
union
select * from (select e.emp_no as employee_ID, 
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110039) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no = 110022
group by e.emp_no
order by e.emp_no) as D) as U
;

select * from emp_manager;

drop view v_manager_avg_salary;
create or replace view v_manager_avg_salary as
select round(avg(s.salary),2) 
from dept_manager m
join salaries s on m.emp_no = s.emp_no; 

select * from v_manager_avg_salary;

select avg(s.salary) from
dept_manager m
join salaries s on m.emp_no = s.emp_no; 
