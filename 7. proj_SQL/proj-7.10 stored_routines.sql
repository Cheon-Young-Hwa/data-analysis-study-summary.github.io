
drop procedure if exists select_employees;

use employees;

delimiter $$	
create procedure select_employees()
begin
select * from employees
limit 1000;
end$$

delimiter ;

call employees.select_employees();
call select_employees();
call select_employees;


delimiter $$
create procedure emp_average_salary()
begin
select avg(salary) from salaries;
end $$

delimiter ;

call employees.emp_average_salary();
call emp_average_salary;


drop procedure select_employees;


drop procedure if exists emp_salary;
delimiter $$
create procedure emp_salary(in p_emp_no int)
begin
select e.first_name, e.last_name, s.salary, s.from_date, s.to_date
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end $$

delimiter $$

call emp_salary();


delimiter $$
create procedure avg_salary(in p_emp_no int)
begin
select avg(s.salary)
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end $$

delimiter ;

call avg_salary(11300);

drop procedure if exists emp_avg_salary_out;
delimiter $$
create procedure emp_avg_salary_out(in p_emp_no int, out p_avg_salary decimal(10,2))
begin
select avg(s.salary) into p_avg_salary 
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end $$

delimiter ;


delimiter $$
create procedure emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no int)
begin
select e.emp_no into p_emp_no
from employees e
where e.first_name = p_first_name and e.last_name = p_last_name;
end $$

delimiter ;


set @v_emp_no = 0;
call employees.emp_info('Aruna', 'Journel', @v_emp_no);
select @v_emp_no;


delimiter $$
create function f_emp_avg_salary(emp_no int) returns decimal(10,2)
deterministic no SQL reads sql data
begin
declare v_avg_salary decimal(10,2);
select avg(s.salary) into v_avg_salary 
from salary s
join employees e on e.emp = s.emp_no
where e.emp_no = p_emp_no;
return v_avg_salary;
end $$

delimiter ;


delimiter $$
create function f_latest_salary(p_first_name varchar(255), p_last_name varchar(255)) returns decimal(10,2)
deterministic no SQL reads sql data
begin
declare v_max_from_date date;
declare v_salary decimal(10,2);
select max(s.from_date)
into v_max_from_date
from employees e 
join salaries s on s.emp_no = e.emp_no
where e.first_name = p_first_name and e.last_name = p_last_name;

select s.salary into v_salary 
from employees e
join salaries s on e.emp_no = s.emp_no
where e.first_name = p_first_name and e.last_name = p_last_name and s.from_date = v_max_from_date;
return v_salary;
end $$

delimiter ;

select f_latest_salary('Aruna', 'Journel')


