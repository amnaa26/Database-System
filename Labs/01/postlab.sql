-- Q11:
select * from employees where hire_date between '01-JAN-05' and '31-DEC-06';

-- Q12:
 select * from employees where manager_id is null;

-- Q13:
 select * from employees where salary < all (select salary from employees where salary > 8000);

-- Q14:
 select * from employees where salary > any (select salary from employees where department_id = 80);

-- Q15:
 select distinct department_id from employees where department_id is not null;

-- Q16:
select * from departments d where not exists(select * from employees e where e.department_id = d.department_id);

-- Q17:
 select * from employees where salary not between 5000 and 15000;

-- Q18:
 select * from employees where department_id in (10, 20, 30) and department_id != 40;

-- Q19:
 select * from employees where salary < all (select salary from employees where department_id = 50);

-- Q20:
-- Display employees whose salary is greater than the maximum salary of department 90.
 select * from employees where salary > (select max(salary) from employees where department_id = 90);
