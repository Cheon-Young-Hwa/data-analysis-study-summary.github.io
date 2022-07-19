delimiter $$

create trigger before_salaires_insert
before insert on salaries
for each row
begin
if new.salary < 0
then set new.salary = 0;
end if;
end $$

delimiter ;


select sysdate();

select date_format(sysdate(), '%y-%m-%d') as today;



delimiter $$

create trigger trig_hire_date 
before insert on employees
for each row
begin
if new.hire_date > date_format(sysdate(), '%y-%m-%d')
then set new.hire_date = date_format(sysdate(), '%y-%m-%d');
end if;
end $$
delimiter $$

insert into employees 
values (999999, '1989-10-11', 'Henry', 'Lau', 'M', '2025-05-10');
select * from employees
where emp_no = 999999;


create index i_hire_date on employees(hire_date);
show index from employees;

alter table employees
drop index i_hire_date;


select * from salaries
where salary > 89000;


create index i_salary on salaries(salary);

select m.emp_no, e.first_name, e.last_name, max(s.salary)-min(s.salary) as salary_dif,
case
when salary_dif > 30,000 then 'Salary was raised by more than $30,000'
else 'Salary was NOT raised by more than $30,000'
end as salary_raise
from dept_manager m
join employees e on m.emp_no = e.emp_no
join salaries s on m.emp_no = s.emp_no
group by m.emp_no
;


select e.emp_no, e.first_name, e.last_name,
case 
when m.emp_no is not null then "Manager"
else "Enployee"
end as is_mananger
from employees e
left join dept_manager m on e.emp_no = m.emp_no
where e.emp_no > 109990; 


SELECT

    dm.emp_no,  

    e.first_name,  

    e.last_name,  

    MAX(s.salary) - MIN(s.salary) AS salary_difference,  

    CASE  

        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'  

        ELSE 'Salary was NOT raised by more then $30,000'  

    END AS salary_raise  

FROM  

    dept_manager dm  

        JOIN  

    employees e ON e.emp_no = dm.emp_no  

        JOIN  

    salaries s ON s.emp_no = dm.emp_no  

GROUP BY s.emp_no;  


select e.emp_no, e.first_name, e.last_name, 
case
when max(to_date) > sysdate() then 'Is still employeed'
else 'Not an employee anymore'
end as current_employee
from employees e
join dept_emp dm on e.emp_no = dm.emp_no
group by e.emp_no
limit 1000;
