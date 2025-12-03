set serveroutput on
-- variables and types
Declare
    sec_name varchar2(20) := 'Sec-A';
    course_name varchar2(20) := 'Database lab';
begin
    dbms_output.put_line('This is ' || sec_name || ' and the course is ' || course_name);
end;

declare
    a integer := 10;
    b integer := 20;
    c integer;
    f real;
begin
    c := a+b;
    dbms_output.put_line('Value of c: ' || c);
    f := 70.0/3.0;
    dbms_output.put_line('Value of f: ' || f);
end;


declare
    --global variables
    num1 number := 20;
    num2 number := 30;
begin
    dbms_output.put_line('outer variable num1: ' || num1);
    dbms_output.put_line('outer variable num2: ' || num2);
    
    declare
        --Local variables
        num3 number := 195;
        num4 number := 185;
    begin
        dbms_output.put_line('inner variable num1: ' || num3);
        dbms_output.put_line('inner variable num2: ' || num4);
        dbms_output.put_line('outer variable num1: ' || num1);
        dbms_output.put_line('outer variable num2: ' || num2);
    end;
end;


declare
    e_name employees.FIRST_NAME%type;
    e_lname employees.LAST_NAME%type;
    d_name DEPARTMENTS.DEPARTMENT_NAME%type;
begin
    select employee_id, first_name, last_name, department_name into e_id, e_name, e_lname, d_name 
    from employees inner join DEPARTMENTS on employees.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID 
    where EMPLOYEE_ID = 100;
    dbms_output.put_line('employee id: ' || e_id);
    dbms_output.put_line('employee name: ' || e_name || ' ' || e_lname);
    dbms_output.put_line('department name: ' || d_name);
end;



-- if else
declare
    e_id employees.EMPLOYEE_ID%type := 100;
    e_sal employees.SALARY%type;
begin
    select salary into e_sal from employees where EMPLOYEE_ID = e_id;
    if e_sal <= 5000
    then update employees set salary=e_sal+1000 where EMPLOYEE_ID = e_id;
    dbms_output.put_line('employee id: ' || e_id);
    dbms_output.put_line('employee salary updated: ' || e_sal);
    ELSE
        dbms_output.put_line('Salary is ' || e_sal || ' → no update performed');
    end if;
end;

-- if else
declare
    e_count number;
    e_id employees.EMPLOYEE_ID%type := 1100;
begin
    select count(1) into e_count from employees where EMPLOYEE_ID = e_id;
    if e_count > 0 then dbms_output.put_line('record already exists');
    else
    insert into employees values(e_id, 'Bruce', 'Austin', 'test@mail.com', '234-5672-89', '25-JUN-05', 'SA_MAN', 5000, 0.2, 100, 60);
    dbms_output.put_line('record added');
    end if;
end;

--switch cases
declare
    e_id employees.EMPLOYEE_ID%type := 100;
    e_sal employees.SALARY%type;
    e_did employees.DEPARTMENT_ID%type;
begin
    select salary, department_id into e_sal, e_did from employees
    where employee_id = e_id;
    case e_did
    when 80 then 
            update employees set salary = e_sal+100 where employee_id=e_id;
            dbms_output.put_line('salary updated: ' || e_sal);
    when 50 then
            update employees set salary = e_sal+200 where employee_id=e_id;
            dbms_output.put_line('salary updated: ' || e_sal);
    when 40 then
            update employees set salary=e_sal+300 where employee_id=e_id;
            dbms_output.put_line('salary updated: ' || e_sal);
    else
        dbms_output.put_line('no such record');
    end case;
end;



declare
    e_id employees.EMPLOYEE_ID%type := 100;
    e_sal employees.SALARY%type;
    e_did employees.DEPARTMENT_ID%type;
begin
    select salary, department_id into e_sal, e_did from employees
    where employee_id = e_id;
    case 
    when e_did=80 then 
            update employees set salary = e_sal+100 where employee_id=e_id;
            dbms_output.put_line('salary updated: ' || e_sal);
    when e_did=50 then
            update employees set salary = e_sal+200 where employee_id=e_id;
            dbms_output.put_line('salary updated: ' || e_sal);
    when e_did=40 then
            update employees set salary=e_sal+300 where employee_id=e_id;
            dbms_output.put_line('salary updated: ' || e_sal);
    else
        dbms_output.put_line('no such record');
    end case;
end;

--nested ifs
declare
    e_id employees.EMPLOYEE_ID%type := 101;
    e_sal employees.SALARY%type;
    e_did employees.DEPARTMENT_ID%type;
    e_com employees.commission_pct%type;
begin
    select salary, department_id, commission_pct into e_sal, e_did, e_com 
    from employees 
    where employee_id = e_id;
    
    if e_did=90 then
        if e_sal >= 20000 and e_sal <= 25000 then
            update employees set salary = (e_sal+100) * (1+e_com) -- (e_sal+100) + (1+NVL(e_com, 0)) -->nvl replaces e_com value with 0 if e_com value is null --> NVL(expr1, expr2) returns expr1 if it is not null else expr2 if expr1 is null
            where employee_id=e_id;
            
            dbms_output.put_line('Salary updated: ' || (e_sal+100)* (1+e_com) );
        elsif e_sal >= 15000 and e_sal < 20000 then
            update employees set salary = (e_sal+200) * (1+e_com)
            where employee_id=e_id;
            
            dbms_output.put_line('Salary updated: ' || (e_sal+200)* (1+e_com) );
        end if;
    end if;
end;

--loops
declare
begin
    for c in (
    select employee_id, first_name, salary
    from employees
    where department_id=90
    )
    loop
        dbms_output.put_line('Salary for the employee ' || c.first_name || ' is: ' || c.salary);
    end loop;
end;
/

--VIEWS
--updatable view
/*
An updatable view must follow these rules:
    -Based on ONE base table
    -No JOIN
    -No GROUP BY, DISTINCT, UNION
    -No aggregate functions
    -Selects direct columns
    
you can update the view like this:
UPDATE emp_basic_view
SET salary = 8000
WHERE employee_id = 105;
*/
create or replace view simple_employee_view as
select employee_id, first_name, last_name, email, salary 
from HR.employees where department_id = 60;

select * from simple_employee_view;

--read-only view (cuz you have used a join, now sql cannot infer which table to update)
create or replace view complex_emp_dpt_view as
select e.employee_id, e.first_name, e.last_name, d.department_name, e.salary
from HR.employees e
join HR.departments d on e.department_id=d.department_id
where e.salary > 5000;

select * from complex_emp_dpt_view;

-- materialized views
 create materialized view mat_emp_dept2 as
 select distinct e.employee_id, e.first_name, e.email, d.department_name
 from HR.employees e
 join HR.departments d on e.department_id=e.department_id
 where e.department_id=80;
 
 select * from mat_emp_dept;
update mat_emp_dept2 set first_name='Fatima' where employee_id=150;
select * from HR.employees where employee_id=150;
select * from mat_emp_dept where employee_id=150;

--it can not update the base table but will update the view
create materialized view check_mv for update as select * from HR.employees;
update check_mv set first_name='Fatima' where employee_id=150;
select * from check_mv where employee_id=150;

-- FUNCTIONS ---
-- scalar function
create or replace function calculateSalary(dept_id in number)
return number is total_salary number;
begin
    select sum(salary) into total_salary from HR.employees where department_id=dept_id;
    return total_salary;
end;
select calculateSalary(80) as total_salary from dual;

create or replace function calSalary
return number is total_salary number;
begin
    select sum(salary) into total_salary from HR.employees;
    return total_salary;
end;
select calSalary as total from dual;

--creating multistatement type-valued function
create or replace type emp_obj_type as object(
    employee_id number(6, 0),
    fisrt_name varchar2(30),
    last_name varchar2(30),
    department_id number(4, 0)
);

create type emp_table_type as table of emp_obj_type;

create or replace function getDetail
return emp_table_type is
    employee_id number(6, 0);
    fisrt_name varchar2(30);
    last_name varchar2(30);
    department_id number(4, 0);
    emp_details emp_table_type := emp_table_type();
begin
    emp_details.extend;
    select employee_id, first_name, last_name, department_id into
    employee_id, fisrt_name, last_name, department_id from HR.employees 
    where employee_id=100;
    emp_details(1) := emp_obj_type(employee_id, fisrt_name, last_name, department_id);
    return emp_details;
end;
select * from table(getDetail());

create or replace function getAll
return emp_table_type is 
    employee_id number(6, 0);
    first_name varchar2(30);
    last_name varchar2(30);
    department_id number(4, 0);
    emp_details emp_table_type := emp_table_type(); --nested table variable declaration and initialization
begin
    emp_details.extend; --extending the nested table
    --getting required data into variables
    select emp_obj_type(employee_id, first_name, last_name, department_id)
    bulk collect into emp_details from HR.employees; --this fills the nested table automatically
    return emp_details;
end;
select * from table(getAll);

--- PROCEDURES ---
create or replace procedure insert_data(
            street_address in varchar2,
            postal_code in varchar2 default null,
            city in varchar2,
            state_province in varchar2,
            country_id in char
            )
is total_record number;
   location_id number;
begin
    select count(*) into location_id from HR.locations;
    location_id := location_id+1;
    total_record := location_id;
    
    insert into HR.locations
        (location_id, street_address, postal_code, city, state_province, country_id)
    values
        (location_id, street_address, postal_code, city, state_province, country_id);
    dbms_output.put_line('new record inserted with id: ' || location_id);
    dbms_output.put_line('total number of records: ' || total_record);
end;
exec insert_data('DHA', '1234', 'karachi', 'sindh', 'US');pl
