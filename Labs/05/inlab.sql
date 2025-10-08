create table employee (
    emp_id int PRIMARY KEY,
    emp_name varchar(50),
    dpt_id int
);

create table department(
    dpt_id int primary key,
    dpt_name varchar(20)
);

alter table employee add constraint dpt_fk foreign key (dpt_id) references department(dpt_id);

insert into department values (1, 'HR');
insert into department values (2, 'IT');
insert into department values (3, 'Sales');

insert into employee values (1, 'Alice', 1);
insert into employee values (2, 'Bob', 2);
insert into employee values (3, 'Charlie', 2);
insert into employee values (4, 'David', 2);
insert into employee values (5, 'Eve', 1);
insert into employee values (6, 'Frank', 3);
insert into employee values (7, 'George', 3);

-- Q1:
select * from employee e cross join department d;

-- Q2:
select * from department d left join employee e on d.dpt_id=e.dpt_id;

-- Q3:
alter table employee add (mngr_id int, foreign key (mngr_id) references employee (emp_id));
update employee set mngr_id = 2 where emp_id in (3, 4);
update employee set mngr_id = 1 where emp_id = 5;
update employee set mngr_id = 6 where emp_id = 7;

select e1.emp_name as emp_name, e2.emp_name as manager_name from employee e1 join employee e2 on e1.emp_id = e2.mngr_id;

-- Q4:
create table emp_project (
    proj_id int primary key,
    proj_name varchar(20)
);
alter table employee add (proj_id int, foreign key (proj_id) references emp_project (proj_id));
insert into emp_project values (1, 'Orange');
insert into emp_project values (2, 'Mango');
insert into emp_project values (3, 'Apple');
update employee set proj_id = 1 where emp_id in (1, 3, 6);
update employee set proj_id = 2 where emp_id in (2, 4, 5);

select * from employee e where proj_id is null;

-- Q5:
create table student (
  student_id int primary key,
  student_name varchar(50)
);

insert into student values (1, 'Ali');
insert into student values (2, 'Bob');
insert into student values (3, 'Charlie');
insert into student values (4, 'David');
insert into student values (5, 'Eve');
insert into student values (6, 'Frank');

create table course (
    course_id int primary key,
    course_name varchar(20)
);
alter table student add (course_id int, foreign key(course_id) references course(course_id));
insert into course values(1, 'PF');
insert into course values(2, 'Stats');
update student set course_id=2 where (student_id in (1, 3)); 
update student set course_id=1 where student_id=2;

select s.student_name, c.course_name from student s join course c using(course_id);

-- Q6:
select c.cust_name, o.order_id from customer c left join cust_order o on c.cust_id=o.cust_id;

-- Q7:
select d.dpt_name, e.emp_name from department d left join employee e on d.dpt_id=e.dpt_id;

-- Q8:
create table faculty (
  faculty_id int primary key,
  faculty_name varchar(50)
);
insert into faculty values (1, 'George');
insert into faculty values (2, 'Ali');
insert into faculty values (3, 'Kevin');
insert into faculty values (4, 'Ahmed');
insert into faculty values (5, 'Hank');
alter table faculty add (course_id int, foreign key (course_id) references course (course_id));
update faculty set course_id = 1 where faculty_id in(1, 2);
update faculty set course_id = 2 where faculty_id = 3;

select f.faculty_name, c.course_name from faculty f cross join course c;

-- Q9:
select d.dpt_name, count(e.emp_id) as total_employees from department d join employee e on d.dpt_id=e.dpt_id group by d.dpt_name;

-- Q10:
select s.student_name, c.course_name, f.faculty_name from student s join course c on s.course_id = c.course_id join faculty f on c.course_id = f.course_id;
