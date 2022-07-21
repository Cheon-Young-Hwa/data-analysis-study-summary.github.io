/* SQL SELECT statement
*/

-- Basics Sytax --
use employees;
SELECT 
    dept_no
FROM
    departments;
    
SELECT 
    *
FROM
    departments;
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
    
### OR statment
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' OR gender = 'M';
    
use employees;
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna';


SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Chathie'
        OR first_name = 'Mark'
        OR first_name = 'Nathan';

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Chathie' , 'Mark', 'Nathan');
    
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Chathie' , 'Mark', 'Nathan');


SELECT 
    *
FROM
    employees
WHERE
    first_name not IN ('John' , 'Mark', 'Jacob')
    

SELECT 
    *
FROM
    employees
WHERE
    first_name like ('Mar_');
    
select * from employees
where first_name like ('Mark%');

select * from employees
where hire_date like ('20%');

select * from employees
where emp_no like('1000_');

select * from employees
where first_name = "Jack";

select * from employees
where first_name not in("Jack");

select * from salaries
where salary between 66000 and 70000;

select * from employees
where emp_no not between 10004 and 10012;

select * from departments
where dept_no between "d003" and "d006";


select * from departments
where dept_no is null;

select * from employees
where first_name <> "Mark";

select * from employees
where hire_date > "2000-01-01";

select * from employees
where hire_date >= "2000-01-01" and gender ="F";

select * from salaries
where salary > 150000;

select distinct hire_date from employees;


select count(salary) from salaries
where salary >= 100000;

select count(*) from dept_manager;

select * from employees
order by hire_date desc;

select salary, count(emp_no) as emps_with_same_salary 
from salaries
where salary >80000
group by salary
order by salary;


select * from salaries
where salary > 120000;

select emp_no, salary from salaries
where salary > 120000;

select emp_no, salary,avg(salary) from salaries
where salary > 120000
group by emp_no, salary
order by emp_no;

select emp_no, avg(salary) from salaries
group by emp_no
having avg(salary) > 120000;


select emp_no, count(emp_no) as contracts_count
from dept_emp
where from_date > '2000-01-01'
group by emp_no
having contracts_count >= 1;

select * from dept_emp
limit 100;

