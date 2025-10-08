-- Q11:
alter table student add city varchar(50);
update student set city = 'Karachi' where student_id in (1, 3);
update student set city = 'Lahore' where student_id in (4, 6);
update student set city = 'Islamabad' where student_id=2;
update student set city='Islamabad' where student_id=5;
alter table faculty add city varchar(50);
update faculty set city='Islamabad' where faculty_id in (2, 5);
update faculty set city='Quetta' where faculty_id=3;
update faculty set city='Karachi' where faculty_id in (1, 4);

select s.student_name, s.city, f.faculty_name from student s join faculty f on s.city=f.city;

-- Q12:
select e1.emp_name as employee_name, e2.emp_name as manager_name from employee e1 left join employee e2 on e2.emp_id=e1.mngr_id;

-- Q13:
select e.emp_name from employee e where e.dpt_id is null;

-- Q14:
alter table employee add (salary int);
update employee set salary = 50000 where dpt_id = 1;
update employee set salary = 60000 where dpt_id = 2;
update employee set salary = 40000 where dpt_id = 3;

select d.dpt_name, avg(e.salary) as avg_salary from department d join employee e on d.dpt_id=e.dpt_id group by d.dpt_name having avg(e.salary) > 50000;

-- Q15:
select e.emp_name from employee e where e.salary > (select avg(salary) from employee where dpt_id=e.dpt_id);

-- Q16:
select d.dpt_name from department d join employee e on d.dpt_id=e.dpt_id group by d.dpt_name having min(e.salary) >= 30000;

-- Q17:
select s.student_name, c.course_name from student s join course c on s.course_id=c.course_id where s.city='Lahore';

-- Q18:
select e.emp_name as emp_name, m.emp_name as manager_name, d.dpt_name from employee e join employee m on e.mngr_id=m.emp_id join department d on e.dpt_id=d.dpt_id where e.hire_date between to_date('01-01-2020', 'DD-MM-YYYY') and to_date('01-01-2023', 'DD-MM-YYYY');

-- Q19:
select s.student_name, f.faculty_name from student s join faculty f on s.course_id=f.course_id where f.faculty_name='Ali';

-- Q20:
select e.emp_name, m.emp_name as manager_name, d.dpt_name from employee e join employee m on e.mngr_id=m.emp_id join department d on e.dpt_id = d.dpt_id where e.dpt_id=m.dpt_id;
