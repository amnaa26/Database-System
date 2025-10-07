-- https://github.com/MuxammilSidd/FAST-KHI-Semester-5/blob/main/Database%20Systems%20(LAB)/Past%20Papers/Mid-Terms/DBS%20Lab%20Mid%20Fall'23%20B.pdf
-- Q1:
select d.dept_name, (select count(*) from student s where s.dept_id = d.dept_id) as student_count from department d;

-- Q2:
select d.dept_name from department d where 3.0 < (select avg(s.gpa) from student s group by d.dept_id);

-- Q3:
select c.course_name, avg(s.fee_paid) as avg_fee from student s join enrollment e on s.student_id = e.student_id join course c on e.course_id=c.course_id group by c.course_name;

-- Q4:
select d.dept_name, count(*)as faculty_count from faculty f join department d on f.dept_id = d.dept_id group by d.dept_name;

-- Q5:
select f.faculty_name from faculty f where f.salary > all (select avg(f.salary) from faculty f);

-- Q6:
select s.student_name, s.gpa from student s where s.gpa > any(select s2.gpa from student s2 join department d on s2.dept_id=d.dept_id where d.dept_name = 'CS');

-- Q7:
select s.student_name, s.gpa from student s order by s.gpa desc fetch first 3 rows only;

-- Q8:
select distinct s.student_name from student s, course c where c.course_name in (select c.course_name from course c join enrollment e on c.course_id = e.course_id join student s on e.student_id=s.student_id and s.student_name='Ali') and s.student_name != 'Ali'

-- Q9:
select d.dept_name, (select sum(s.fee_paid) from student s where s.dept_id=d.dept_id) as total_fees from department d;

-- Q10:
select distinct c.course_name from course c join enrollment e on c.course_id=e.course_id join student s on e.student_id=s.student_id where s.gpa > 3.5;
