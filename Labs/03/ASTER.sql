-- THESE ARE THE QUERIES DONE IN LAB
-- LAB 3
create user aster IDENTIFIED by aster;

-- table-schema
-- rows -> tuple
-- columns --> attributes
-- primary key is a constraint(validation) of table. It is unique and not a null value. 
-- 2 types of constrants : table-level and column-level

create table students(
    id int primary key,
    std_name varchar(30),
    email varchar(20),
    age int,
    check(age >= 18) --age will be checked. this is also a table-level constraint
);

select * from students;

--adding columns i.e performing alteration in the structure
alter table students add salary int;
alter table students add (city varchar(20) default 'Karachi', dept_id int);
select * from students;

--keeping email unique and not null
alter table students add constraint unique_email unique(email); --add single constraint
--modify multiple columns
alter table students modify(std_name varchar(20) not null, email varchar(20) not null);

alter table students add (constraint check_age check(age between 18 and 30), constraint unique_email unique(email));

create table departments(
    id int primary key,
    dept_name varchar(20) not null
);

select * from departments;
insert into departments(id, dept_name) values(4, 'AI');
insert into departments(id, dept_name) values(6, 'CS');
insert into departments(id, dept_name) values(7, 'SE');
select * from departments;

alter table students drop column dept_id;
alter table students add (dept_id int  , foreign key(dept_id) references departments(id));
insert into students(id, std_name, email, age,city, salary, dept_id) values(102, 'Mr.Wow', 'wow@wow.com', 20, 'Kiranchi', 500000, 5);
select * from students;

delete from students where id in (1, 102);
select * from students;

insert into students(id, std_name, email, age,city, salary, dept_id) values(102, 'Mr.Wow', 'wow@wow.com', 20, 'Kiranchi', 500000, 5);

-- diff between truncate and delete?


