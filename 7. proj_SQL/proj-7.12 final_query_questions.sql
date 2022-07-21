
###QUESTION 1
select d.dept_name, e.gender, round(avg(s.salary), 2)
from t_dept_emp de
join t_employees e on de.emp_no = e.emp_no
join t_departments d on de.dept_no = d.dept_no
join t_salaries s on de.emp_no = s.emp_no
group by d.dept_name, e.gender
order by d.dept_name, e.gender;


###QUESTION 2
use employees;
select min(dept_no), max(dept_no) from dept_emp;


###QUESTION 3
select 
e.emp_no,
(select min(dept_no) from dept_emp de where e.emp_no= de.emp_no) as dept_no,
case when e.emp_no <= 10020 then '110022'
else '110039'
end as manager
from employees e
where e.emp_no <= 10040;

select emp_no, min(dept_no) from dept_emp
group by emp_no
limit 1000;


###QUESTION 4
select *
from employees
where year(hire_date) = 2000;


###QUESTION 5
select * from titles
where title = "Engineer";

select * from titles
where title like ('%Engineer%');

select * from titles
where title like ('%Senior Engineer%');


#####QUESTION 6
select de.emp_no,
max(de.from_date) as max_date,
(select de.dept_no from dept_emp de where de.from_date=max(de.from_date)) as dept_no
from dept_emp de
group by de.emp_no;


select de.emp_no, de.from_date, de.dept_no, d.dept_name
from dept_emp de
join departments d on de.dept_no=d.dept_no;

create table newest_dept as
select de.emp_no, de.from_date, de.dept_no, d.dept_name
from dept_emp de
join departments d on de.dept_no=d.dept_no;

select emp_no, max(from_date), dept_no, dept_name from newest_dept
group by emp_no;


drop procedure if exists info;
delimiter $$
create procedure info (in p_emp_no int)
begin
select de.emp_no, max(de.from_date), de.dept_no, d.dept_name
from dept_emp de
join departments d on de.dept_no=d.dept_no
where p_emp_no=de.emp_no and de.from_date=max(de.from_date);
end $$

delimiter $$

call info(11300);

drop procedure if exists info;
delimiter $$
create procedure info (in p_emp_no int)
begin
select de.emp_no,from_date, de.dept_no, d.dept_name
from dept_emp de
join departments d on de.dept_no=d.dept_no
where p_emp_no=de.emp_no 
and de.from_date=(select max(de.from_date) from dept_emp de where p_emp_no=de.emp_no);
end $$

delimiter $$

call info(11300);


###QUESTION 7
select count(emp_no) from salaries
where datediff(to_date, from_date) > 365 and salary >=100000;



###QUESTION 8
delimiter $$
create trigger trg_hire_date
before insert on employees
for each row
begin
if new.hire_date > date_format(sysdate(), '%y-%m-%d')
then set new.hire_date = date_format(sysdate(), '%y-%m-%d');
end if;
end $$

insert into employees
values (999998, '2000-03-01', 'Tom', 'Cruise', 'M', '2025-5-18');

select * from employees
order by hire_date desc
limit 10;

##Extra Challenge
delimiter $$
create trigger trg_hire_date
before insert on employees
for each row
begin
declare today date;
select date_format(sysdate(), '%y-%m-%d') into today;

if new.hire_date > today
then set new.hire_date = today;
end if;
end $$

insert into employees
values (999998, '2000-03-01', 'Tom', 'Cruise', 'M', '2025-5-18');

select * from employees
order by hire_date desc
limit 10;



#####QUESTION 9
drop function if exists max_salary;

delimiter $$
create function f_max_salary(p_emp_no int) returns decimal(10,2)
deterministic no SQL reads SQL data
begin
declare v_max_salary decimal(10,2);
select max(salary) into v_max_salary
from salaries s
where p_emp_no=s.emp_no;
return v_max_salary;
end $$

delimiter ;

select f_max_salary(11356);

select max(salary)
from salaries s
where s.emp_no=11356; ### 83067


####Addtional Question
drop function if exists f_min_salary;

delimiter $$
create function f_min_salary(p_emp_no int) returns decimal(10,2)
deterministic no SQL reads SQL data
begin
declare v_min_salary decimal(10,2);
select min(salary) into v_min_salary
from salaries s
where p_emp_no=s.emp_no;
return v_min_salary;
end $$

delimiter ;

select f_min_salary(11356);



#####QUESTION 10

####This code is my incorrect answer##### max and min should be in a case statement!!!!! 
drop function if exists f_salary_info;

delimiter $$
create function f_salary_info(p_emp_no int, p_char_seq char(5)) returns decimal(10,2)
deterministic no SQL reads SQL data
begin
declare v_max_salary decimal(10,2);
declare v_min_salary decimal(10,2);

select max(salary) into v_max_salary
from salaries s
where p_emp_no=s.emp_no and p_char_seq='max';
return v_max_salary;

select min(salary) into v_min_salary
from salaries s
where p_emp_no=s.emp_no and p_char_seq='min';
return v_min_salary;
end $$

delimiter ;

select f_salary_info(11356, 'min');


######My Second Answer
drop function if exists f_salary_info;

delimiter $$
create function f_salary_info(p_emp_no int, p_char varchar(10)) returns decimal(10,2)
deterministic no SQL reads SQL data
begin
declare v_salary decimal(10,2);

select 
case 
when p_char='max' then max(salary) 
when p_char='min' then min(salary)
else max(salary) - min(salary)
end as salary_info #### Don't forget to add this clause at the end of a case statement!!!!!!
into v_salary
from salaries s
where p_emp_no=s.emp_no;

return v_salary;
end $$

delimiter ;

select f_salary_info(11356, 'min');



##############################################
#######Revisiting Exercise Questions 3-10#####

###Question 3
select 
e.emp_no,
(select min(de.dept_no) from dept_emp de where e.emp_no=de.emp_no) lowest_dept_no, ##### Add an aliase for a subquery!!!
case
when e.emp_no<=10020 then '110022' 
else 110039 ##### The limit of emp_nos should be notated in a where clause!!!!
end as manager
from employees e
join dept_emp de on e.emp_no=de.emp_no
where e.emp_no<=10040; ### no need for a 'limit=40' clause


#####Table dept_emp has duplicate rows under 4 emp_nos as seen in the result of the below code
select emp_no, count(emp_no) from dept_emp
where emp_no<=10040
group by emp_no;


#####Question 4
select * from employees
where year(hire_date)=2000;



#####Question 5
select * from titles
where title like ('%Engineer%'); ###wild card '%'for string with a sequence of characters

select * from titles
where title like ('%Senior Engineer%');



#####Question 6
drop procedure if exists latest_dept;

delimiter $$
create procedure latest_dept(in p_emp_no int)
begin
select
e.emp_no,
de.dept_no,
d.dept_name
from employees e
join dept_emp de on e.emp_no=de.emp_no
join departments d on de.dept_no=d.dept_no
where
p_emp_no=e.emp_no and 
de.from_date=(select max(from_date) from dept_emp where p_emp_no=emp_no) ######Corrected from "de.from_date=max(de.from_date)"
;
end $$

delimiter ;

call latest_dept(10010);



######Question 7
###datediff( , )>365

select count(salary)
from salaries
where
datediff(to_date, from_date) > 365 and
salary >=100000;

select *
from salaries
where
datediff(to_date, from_date) > 365 and
salary >=100000;


#######Question 8
drop trigger if exists t_hire_date

delimiter $$
create trigger t_hire_date
before insert on employees
for each row
begin
if new.hire_date > date_format(sydate(), '%y-%m-%d') then ####ADD if + Then + end if
set new.hire_date = date_format(sydate(), '%y-%m-%d');
end if;
end $$

delimiter ;
 
####Second Answer
drop trigger if exists t_hire_date

delimiter $$
create trigger t_hire_date
before insert on employees
for each row
begin
declare today date;
select date_format(sydate(), '%y-%m-%d') into today;
if new.hire_date > today then
set new.hire_date = today;
end if;
end $$

delimiter ;
