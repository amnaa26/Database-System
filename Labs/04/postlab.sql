-- Q11:
select d.dept_name from department d where (select sum(s.fee_paid) from student s where s.dept_id=d.dept_id) > 1000000;

-- Q12:
select d.dept_name, f.faculty_name from department d, faculty f where (select count(*) from faculty f where f.dept_id=d.dept_id and salary > 100000) > 5;

-- Q13:
delete from student where gpa < (select avg(gpa) from student);

-- Q14:
delete from course where course_id not in (select distinct course_id from enrollment);

-- Q15:
create table Highfee_students as
select * from student where fee_paid > (select avg(fee_paid) from student);

-- Q16:
create table Retired_Faculty as
select * from faculty where joining_date < (select min(joining_date) from faculty); 

-- Q17:
select d.dept_name, (select sum(s.fee_paid) from student s where s.dept_id=d.dept_id) as total_fee from department d order by total_fee desc fetch first row only;
--solving it using max function:
select dept_name
from department d
where (
    select sum(s.fee_paid)
    from student s
    where s.dept_id = d.dept_id
  ) =
  (
    select max(total_fees)
    from (
      select sum(s2.fee_paid) as total_fees
      from student s2 group by s2.dept_id
    )
  );

-- Q18:
select c.course_name, (select count(*) from enrollment e where e.course_id = c.course_id)as total_enrollments from course c where rownum <=3;

-- Q19:
select s.student_name from student s where s.student_id in (select e.student_id from enrollment e group by e.student_id having count(e.course_id) > 3) and s.gpa > (select avg(s3.gpa) from student s3);

-- Q20:
create table Unassigned_Facuty as
select * from faculty f where f.dept_id not in (select dept_id from course);
