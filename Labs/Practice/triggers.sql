-------------- TRIGGERS --------------------------

create table students(
    student_id int primary key,
    student_name varchar2(200),
    h_pay int,
    y_pay int
);
select * from students;
insert into students(student_id, student_name) values(1, 'sana');
insert into students(student_id, student_name) values(2, 'ali');
insert into students(student_id) values(3);

--- DML TRIGGERS ---
--before insert data
create or replace trigger insert_data
before insert on students
for each row
begin
    if :new.h_pay is null
    then :new.h_pay := 250;
    end if;
end;

create or replace trigger before_insert
before insert on students
for each row
enable
declare v_user varchar2(20);
begin
    select user into v_user from dual;
    dbms_output.put_line('you just inserted a row Mr ' || v_user);
end;

--before update trigger
create or replace trigger update_salary
before update on students
for each row
declare
begin 
    :new.y_pay := :new.h_pay * 1920;
end;

create or replace trigger before_update
before update on students
for each row
enable
declare v_user varchar2(20);
begin
    select user into v_user from dual;
    dbms_output.put_line('you just updated a row Mr ' || v_user);
end;

--before delete trigger
create or replace trigger prevent_record
before delete on students
for each row
begin
    if :old.student_name = 'sana'
    then raise_application_error(-20001, 'Cannot delete record: student_name is sana!');
    end if;
end;

--combined all before triggers
create or replace trigger before_all_combine
before insert or update or delete on students
for each row
enable
declare v_user varchar2(20);
begin
    select user into v_user from dual;
    if inserting then dbms_output.put_line('one line inserted by ' || v_user);
    elsif updating then dbms_output.put_line('one line updated by ' || v_user);
    elsif deleting then dbms_output.put_line('one line deleted by ' || v_user);
    end if;
end;

--just change before with after, the rest syntax is same

--- DDL TRIGGERS ---
