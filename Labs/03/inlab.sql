-- Q1:
 create table employees(
    emp_id int,
    emp_name varchar(20),
    salary int,
    dept_id int
 );
 alter table employees add constraint salary_constraint check (salary > 20000);
 alter table employees add constraint dept_foreignkey foreign key (dept_id) references departments(dept_id);

-- Q2:
 alter table employees rename column emp_name to full_name;

-- Q3:
 alter table employees drop constraint salary_constraint;
 insert into employees values(01, 'aster', 1500, 01);

-- Q4:
 create table departments(
    dept_id int PRIMARY KEY,
    dept_name varchar(50) UNIQUE
 );
 insert into departments values(1, 'cs');
 insert into departments values(2, 'ai');
 insert into departments values(3, 'marketing');

-- Q5:
 alter table employees add constraint dept_foreignkey foreign key (dept_id) references departments(dept_id);

-- Q6:
 alter table employees add bonus number(6, 2) default 1000;

-- Q7:
alter table employees add city varchar(50) default 'Karachi';
alter table employees add age nuber check (age > 18);

-- Q8:
 delete from departments where dept_id = 1 or dept_id=3;

-- Q9:
 alter table employees modify full_name varchar(20);
 alter tale employees modify city varchar(20);

-- Q10:
 alter table employees add email varchar(20);
 alter table employees add constraint unique_mail unique(email);
