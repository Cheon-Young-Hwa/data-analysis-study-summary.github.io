select * from departments
order by dept_no;

update departments
set dept_no = 'd010'
where dept_no = 'd01';


update departments
set dept_name = 'Data Analysis'
where dept_no = 'd010';



commit;

select * from employees
where emp_no = 999903;

delete from employees
where emp_no = 999903;

rollback;

select * from departments;

delete from departments;

rollback;





