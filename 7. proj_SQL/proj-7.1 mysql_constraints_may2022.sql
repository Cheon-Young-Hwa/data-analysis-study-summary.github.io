create database if not exists Sales;

create table Sales.Sales
(
	purchase_number int not null primary key auto_increment,
    data_of_purchase date not null,
    customer_id int,
    item_code varchar(10) not null
);

create table Sales.customers
	(customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int
);

use Sales;

select * from Sales.Sales;

use Sales;
select * from Sales;

drop table Sales;

create table sales
(
	purchase_id int auto_increment,
    date_of_purchase date,
    customer_id int,
    item_code varchar(10),
primary key (purchase_id)
);

drop table customers;
create table customers
(
	customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_conplaints int,
primary key(customer_id)
);

alter table sales
add foreign key(customer_id) references customers(customer_id) on delete cascade;

alter table sales
drop foreign key sales_ibfk_1;


drop table sales;
drop table customers;


CREATE TABLE sales (
    purchase_id INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
    PRIMARY KEY (purchase_id)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_conplaints INT,
    PRIMARY KEY (customer_id)
);

alter table sales
add foreign key(customer_id) references customers(customer_id) on delete cascade;

alter table customers
add unique key (email_address);

alter table customers
drop index email_address;

alter table customers
add column gender enum("M", "F") after last_name;



### Defalut Constraints – 3 May 2022
use Sales;

alter table sales
drop foreign key sales_ibfk_1;

alter table customers
change column customer_id customer_id int auto_increment;

alter table sales
add foreign key(customer_id) references customers(customer_id) on delete cascade;

insert into customers (first_name, last_name, gender, email_address, number_of_conplaints)
values('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);

alter table customers
change column number_of_conplaints number_of_complaints int default 0;

insert into customers (first_name, last_name, gender)
values ('Peter', 'Figaro', 'M');

select * from customers;

select first_name from customers;

select * from customers
where gender = 'M';

alter table customers
alter column number_of_complaints drop default; ####### a new type of sytax for alerting##############

create table companies
(
	company_id varchar(255),
    company_name varchar(255),
    headquaters_phone_number varchar(255),
primary key(company_id),
unique key(headquaters_phone_number)
);

select * from companies;
drop table companies;



### NOT NULL Constraints

drop table companies;
CREATE TABLE companies (
    company_id INT AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    headquaters_phone_number VARCHAR(255),
    PRIMARY KEY (company_id),
    UNIQUE KEY (headquaters_phone_number)
);

alter table companies
change column company_name company_name varchar(255) null;

alter table companies
modify company_name varchar(255) not null;


alter table companies
modify company_id int auto_increment;

alter table companies
change column company_id company_id varchar(255) auto_increment;

insert into companies (company_name, headquaters_phone_number)
values ('comapny A', '+1 (202) 555-0196');
SELECT 
    *
FROM
    companies;

alter table companies
modify headquaters_phone_number varchar(255) null;

alter table companies
modify headquaters_phone_number varchar(255) not null;

