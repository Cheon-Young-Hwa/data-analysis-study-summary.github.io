
### Task 1
select year((de.from_date)) as start_year,
e.gender as gender,
count(e.emp_no) as no_of_employees
from t_employees e
join t_dept_emp de on e.emp_no = de.emp_no
group by start_year, gender
having start_year >= 1990
order by start_year;


### Task 2
use employees_mod;
select 
d.dept_name,
ee.gender,
dm.emp_no,
dm.from_date,
dm.to_date,
e.calendar_year,
case
when year(dm.to_date) >= e.calendar_year and year(dm.from_date) <= e.calendar_year then 1
else 0
end as active
from
(select year(hire_date) as calendar_year
from t_employees
group by calendar_year) e
cross join t_dept_manager dm 
join t_departments d on dm.dept_no = d.dept_no
join t_employees ee on dm.emp_no = ee.emp_no
order by dm.emp_no, calendar_year;

select *
from
(select year(hire_date) as calendar_year
from t_employees
group by calendar_year) e
cross join t_dept_manager dm 
join t_departments d on dm.dept_no = d.dept_no
join t_employees ee on dm.emp_no = ee.emp_no
order by dm.emp_no, calendar_year;



### Task 3
select 
ee.gender,
d.dept_name,
e.calendar_year,
avg(case
when year(de.to_date) >= e.calendar_year and year(de.from_date) <= e.calendar_year then s.salary
else 0
end, 2) as avg_salary
from
(select year(hire_date) as calendar_year
from t_employees
group by calendar_year) e
cross join t_salaries s
join t_employees ee on s.emp_no = ee.emp_no
join t_dept_emp de on ee.emp_no = de.emp_no
join t_departments d on de.dept_no = d.dept_no
group by e.calendar_year, ee.gender, d.dept_name
having calendar_year <= 2002
order by d.dept_name, calendar_year;

select *
from
(select year(hire_date) as calendar_year
from t_employees
group by calendar_year) e
cross join t_salaries s
join t_employees ee on s.emp_no = ee.emp_no
join t_dept_emp de on ee.emp_no = de.emp_no
join t_departments d on de.dept_no = d.dept_no
order by d.dept_name, calendar_year;

#ANSWER to Task 2
SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender , calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;

select * 
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender , year(s.from_date) as calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;


select * from t_salaries;



### Task 4

drop procedure if exists avg_salary;

delimiter $$
create procedure avg_salary(in p_min_salary int(7), in p_max_salary int(7))
begin
select e.gender, d.dept_name, avg(s.salary), (year(s.from_date)) as calendar_year
from t_salaries s
join t_employees e on s.emp_no = e.emp_no
join t_dept_emp de on e.emp_no = de.emp_no
join t_departments d on de.dept_no = d.dept_no
where s.salary between p_min_salary and p_max_salary
group by e.gender, d.dept_name, calendar_year;
end $$	

delimiter ;


### ANSWER to Task 4
DROP PROCEDURE IF EXISTS filter_salary;
DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
    e.gender, d.dept_name, AVG(s.salary) as avg_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END$$

DELIMITER ;

CALL filter_salary(50000, 90000);
