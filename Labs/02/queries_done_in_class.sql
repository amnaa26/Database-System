-- STUDY DUAL!!!!


select count(*) as total_employee from employees;
select count(*) as total_employee, manager_id from employees group by(manager_id);
select manager_id from employees group by (manager_id);
select distinct manager_id from employees; --give the same output as above query
select avg(salary) as average_salary from employees;
select max(salary) as maximum_salary from employees;

--CONCATENATE
select first_name || salary as first_name_and_salary from employees; --|| will combine
select first_name || last_name as name from employees;

select all salary from employees;
select salary  from employees;

--order by clause asc and desc
select salary fro, employees order by (salary) asc;
select first_name, hire_date from employees order by (first_name) asc;
select first_name, hire_date from employees order by (first_name) desc;

--like and % operator
select first_name from employees where first_name like 'A__n%';
-- % is like if there are further characters then they can come, if they are not then thats fine as well. also in this query uppercase and lowercase matters in this searching


-- numeric functions:
select abs(-26) from dual; --dual gives you a dummy table to perform mathematical operations
select ceil(-90.6) from dual; -- ceil returns greater value
select floor(90.7) from dual; --returns lesser values
select trunc(26.7368234, 4) from dual;
select round(84.545) from dual;
select geatest(90, 97, 34) from dual;
select least(67, 23, 78) from dual;

-- string functions:
select lower('LAIBA') from dual;  --converts uppercase to lowercase
select upper('laiba') from dual;  -- ykr!
select initcap('the soap opera') from dual; --converts first letter to uppercase after every space
select first_name, length(first_name) from employees;
select ltrim('  laiba') from dual;  --remove space from left side
select rtrim('laiba     zia') from dual; --study rtrim cuz it didnt work
select substr('laiba binte zia', 4, 6) from dual;
select lpad('worst', '7', 't') from dual; --(word, characters total you want, char to add if your word limit < total char) --> will add char in the left side
select rpad('laiba', '2', '*') from dual;

-- date functions
select add_months('16-sep-2025', 2) from dual; --2 will add two months in 16 sept 2025
select months_between('16-dec-2024', '16-sep-2024') from dual;  --will tell you the number of months between(larger value, smaller value)
select next_day('4-nov-1999', 'friday') from dual; --will tell when next friday will come after 4-nov 1999
select last_day('25-dec-2924') from dual;
select new_time('28-aug-08', 'PST', 'MST') from dual;

--conversion functions
SELECT TO_CHAR(SYSDATE, 'DD-MM-YY') FROM DUAL; --gives you the current date through your sytem
select to_char(sysdate, 'Day') from dual;  --gives you the current day

select hire_date from employees;
select first_name, hire_date from employees where to_char(hire_date, 'Day') = 'Wednesday' ;
select count(*) from employees where to_char(hire_date, 'Day') = 'Wednesday' ;
