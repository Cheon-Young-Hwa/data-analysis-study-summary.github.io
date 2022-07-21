use employees;

select * from salaries
limit 100;

select emp_no, count(emp_no)
from salaries
group by emp_no;

select distinct count(emp_no)
from salaries;

select distinct emp_no
from salaries;

select count(emp_no)


from salaries;

#############################################
#gender dept_no dept_name salaries
#Q1
select * from employees
limit 100;
select * from dept_emp
limit 100;
select * from departments
limit 100;
select * from salaries
limit 100;

select d.dept_name, e.gender, round(avg(s.salary),2) as salary
from employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
join salaries s on e.emp_no = s.emp_no
group by d.dept_name,e.gender;


#Q2
select min(dept_no), max(dept_no)
from dept_emp;


#Q3
# emp_no dept_no manager
#Solution_1
select e.emp_no, 
(select min(de.dept_no) from dept_emp de
where de.emp_no = e.emp_no) as dept_no,
case 
when e.emp_no <= 10020 then '110022'
else 110039 
end as 'manager'
from employees e
where e.emp_no <= 10040;

#Solution_2
############ Be ware that the below code does not work!!!! 
select e.emp_no, 
de.dept_no,
case 
when e.emp_no <= 10020 then '110022'
else 110039 
end as 'manager'
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no <= 10040 and de.dept_no = min(de.dept_no);

############ Be ware that the below chunks of code does not work!!!! 
############ REASON: You can't use subqueries in where statments
select emp_no, dept_no as dept_num
from dept_emp
where dept_num = min(dept_no);


select e.emp_no, 
de.dept_no,
case 
when e.emp_no <= 10020 then '110022'
else 110039 
end as 'manager'
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no <= 10040 and (select min(de.dept_no) from dept_emp de where e.emp_no = de.emp_no);


select e.emp_no, 
dept_no,
case 
when e.emp_no <= 10020 then '110022'
else 110039 
end as 'manager'
from employees e
where e.emp_no <= 10040 and (select min(de.dept_no) dept_no from dept_emp de where e.emp_no = de.emp_no);
##################################################################


#Q4
select * from employees
where year(hire_date) = 2000;

select count(*) from employees
where year(hire_date) = 2000;


#Q5
