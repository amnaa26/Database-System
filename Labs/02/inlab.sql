-- Q1:
select sum(salary) as total_salary from employees;

-- Q2:
select avg(salary) as average_salary from employees;

-- Q3:
select manager_id, count(*) as num_employee from employees where manager_id is not null group by manager_id;

-- Q4:
select * from  employees where salary = (select min(salary) from employees);

-- Q5:
select to_char(sysdate, 'DD-MM-YY') as "System Date" from dual;

-- Q6:
select to_char(sysdate, 'Day Month YYYY') as "System Date" from dual;

-- Q7:
select * from employees where to_char(hire_date, 'Day') = 'Wednesday';

-- Q8:
select  months_between('01-JAN-25','01-OCT-24') from dual;

-- Q9:
select first_name || ' ' || last_name as name, round(months_between(current_date, hire_date)) as MONTHS_WORKED from employees;

-- Q10:
select substr(last_name, 0, 5) as name from employees;
