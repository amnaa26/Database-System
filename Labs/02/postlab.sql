-- Q11:
select lpad(first_name, 15, '*') as name from employees;

-- Q12:
select ltrim(' Oracle') from dual;

-- Q13:
select initcap(first_name) as name from employees;

-- Q14:
select next_day(to_date('20-AUG-2022'), 'Monday') as "Next Monday" from dual; 

-- Q15:
select to_char(to_date('25-DEC-2023'), 'MM-YYYY') as "Date" from dual;

-- Q16:
select distinct salary from employees order by salary asc;

-- Q17:
select first_name, last_name, round(salary, -2) from employees;

-- Q18:
select * from departments where department_id = (select department_id from employees where department_id is not null group by department_id order by count(*) desc fetch first 1 row only)

-- Q19:
select * from departments where department_id in (select department_id from employees where department_id is not null group by department_id order by sum(salary) desc fetch first 3 rows only);

-- Q20:
select * from departments where department_id = (select department_id from employees where department_id is not null group by department_id order by count(*) desc fetch first 1 row only)
