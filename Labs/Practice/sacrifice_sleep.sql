select * from employees;
select e.first_name || ' ' || e.last_name as full_name, j.job_title, d.department_name, l.city 
from employees e join jobs j on e.job_id=j.job_id join departments d on e.department_id=d.department_id join locations l on d.location_id=l.location_id;
select * from departments;

select e1.employee_id, e1.first_name || ' ' || e1.last_name as full_name, e1.salary, e1.department_id from employees e1 
where e1.salary > (select avg(salary) from employees e where department_id=e1.department_id) ;

select e1.employee_id, e1.first_name || ' ' || e1.last_name as full_name, e1.salary, d.department_name from employees e1 
join departments d on e1.department_id= d.department_id 
where e1.department_id in (select e2.department_id from employees e2 where e2.first_name='Steven' and e2.last_name='King')
and e1.first_name != 'Steven' and e1.last_name != 'King';

select e1.first_name || ' ' || e1.last_name as full_name, e1.salary, d.department_name from employees e1 
join departments d on e1.department_id= d.department_id 
where e1.salary = (select max(salary) from employees e where department_id=e1.department_id);

select l.city, count(e.employee_id) as total_employees from employees e join departments d on e.department_id=d.department_id join locations l on d.location_id=l.location_id group by l.city order by total_employees desc fetch first 1 row only;

select m.first_name || ' ' || m.last_name as full_name, d.department_name, count(e.employee_id) as total_employees from employees e
join employees m on e.manager_id=m.employee_id 
join departments d on m.department_id=d.department_id group by m.first_name, m.last_name, d.department_name;

select e1.first_name || ' ' || e1.last_name as emp_name, m.first_name || ' ' || m.last_name as manager_name, e1.hire_date as emp_hiredate, m.hire_date as manager_hiredate from employees e1
join employees m on e1.manager_id=m.employee_id
where e1.hire_date < m.hire_date;


select e1.first_name || ' ' || e1.last_name, e1.salary, e1.commission_pct from employees e1 where e1.commission_pct = (select max(commission_pct) from employees);

select e1.first_name || ' ' || e1.last_name as emp_name, m.first_name || ' ' || m.last_name as manager_name, e1.hire_date as emp_hiredate, m.hire_date as manager_hiredate, e1.salary as emp_salary, m.salary as manager_salary 
from employees e1
join employees m on e1.manager_id=m.employee_id
where to_char(e1.hire_date, 'YY') = to_char(m.hire_date, 'YY')
and e1.salary < m.salary;

select * from job_history;
select distinct e1.first_name || ' ' || e1.last_name as emp_name from employees e1
join job_history j on e1.employee_id=j.employee_id ;

---i think it is enough for query practice given what time is right now (2:02 am cooked)

-- ddl practice
create table customers(
    cust_id int primary key,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    email varchar(50) unique not null,
    phone varchar(50)
);

insert into customers values(1, 'Ali', 'Raza', 'aliraza@gmail.com', '03345678123');

create table product(
    product_id int primary key,
    product_name varchar(20) not null,
    price int check(price > 0),
    stock_quantity int check(stock_quantity >= 0)
);
insert into product values(1, 'Laptop', 100000, 10);

create table custorder(
    order_id int primary key,
    cust_id int,
    order_date date not null,
    status varchar(10) check(status in ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
alter table custorder add constraint fk_cust foreign key(cust_id) references customers(cust_id);
insert into custorder values(1, 1, TO_DATE('09-10-2025', 'DD-MM-YYYY'), 'Pending');
update custorder set status='Shipped';

create table order_items(
    order_tem_id int primary key,
    order_id int,
    product_id int,
    quantity int check(quantity >= 1),
    subtotal int,
    foreign key(order_id) references custorder(order_id),
    foreign key(product_id) references product(product_id)
);
insert into order_items values(1, 1, 1, 2, 200000);

select * from customers;
select * from order_items;
select c.fisrt_name || ' ' || c.last_name as full_name from customers c
join cust_order corder on c.cust_id=corder.cust_id
join order_times otime on c.order_id=otime.order_id
where subtotal > 50000;

--now will do erd thingy
