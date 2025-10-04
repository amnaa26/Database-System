-- Q11:
alter table employess add constraint unique_bonus unique(bonus);
insert into employees values ( 3, 'alice', 6000, 2, 1011, 'New York', 20, 'abc@mail.com' );
-- this will fail as bonus of 1011 already exists
insert into employees values ( 4, 'bob', 6000, 2, 1011, 'New York', 21, 'xyz@mail.com' );

-- Q12:
alter table employees add dob date;
alter table employees add constraint dob_constraint check(dob <= add_months(current_date, -12*18));

-- Q13:
insert into employees values ( 1, 'test', 6000, 1, 102, 'karachi', 19, 'test@mail.com', '6-JULY-2010' );

-- Q14:
alter table employees drop constraint dept_foreignkey;
insert into employees values ( 1, 'test', 6000, 30, 102, 'karachi', 19, 'test@mail.com', '6-JULY-2005' );
alter table employees add constraint dept_foreignkey foreign key (dept_id) references departments(dept_id);

-- Q15:
alter table employees drop column age;
alter table employees drop column city;

-- Q16:
select d.dept_name, e.full_name from departments d join employees e on e.dept_id = d.dept_id;

-- Q17:
alter table employees rename column salary to monthly_salary;

-- Q18:
select * from departments d where not exists (select 1 from employees e where e.dept_id = d.dept_id);

-- Q19:
truncate table students;

-- Q20:
select * from departments where dept_id in (select dept_id from employees where dept_id is not null group by dept_id order by count(*) desc fetch first 1 row only);
