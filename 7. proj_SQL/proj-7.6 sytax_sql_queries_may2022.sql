delete from departments_dup # Do not put in colums between delete and from
where dept_no = "d001"; 


insert into departments_dup (dept_no, dept_name)
select * from departments; # Instead of values, a select clause can be used

INSERT INTO dept_manager_dup # no need for specifying columns 
select * from dept_manager;


alter table departments_dup
change column dept_no dept_no char(4) null; # Only a column can be allowed after a change column clause


insert into departments_dup (dept_no)
values ("d010"), ("d011"); # This format allows to put in multiple records in the same column at a time together


delete from departments_dup
where dept_no = 'd010' or dept_no = 'd011'; # The operation should be or not and.

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '') ### 185. Error Code `1055!







