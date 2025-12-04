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

CREATE TABLE sh_audit(
new_name varchar2(30),
old_name varchar2(30),
user_name varchar2(30),
entry_date varchar2(30),
operation varchar2(30)
);
CREATE OR REPLACE trigger superheroes_audit
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
v_user varchar2 (30);
v_date varchar2(30);
BEGIN
SELECT user, TO_CHAR(sysdate, &#39;DD/MON/YYYY HH24:MI:SS&#39;) INTO v_user, v_date
FROM dual;
IF INSERTING THEN
INSERT INTO sh_audit (new_name,old_name, user_name, entry_date, operation)
VALUES(:NEW.SH_NAME, Null , v_user, v_date, &#39;Insert&#39;);
ELSIF DELETING THEN
INSERT INTO sh_audit (new_name,old_name, user_name, entry_date, operation)
VALUES(NULL,:OLD.SH_NAME, v_user, v_date, &#39;Delete&#39;);
ELSIF UPDATING THEN
INSERT INTO sh_audit (new_name,old_name, user_name, entry_date, operation)
VALUES(:NEW.SH_NAME, :OLD.SH_NAME, v_user, v_date,&#39;Update&#39;); END IF;
END;
/

--- DDL TRIGGERS ---
CREATE TABLE superheroes_backup AS SELECT * FROM superheroes WHERE 1=2;

CREATE or REPLACE trigger Sh_Backup
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
BEGIN
IF INSERTING THEN
INSERT INTO superheroes_backup (SH_NAME) VALUES (:NEW.SH_NAME);
ELSIF DELETING THEN
DELETE FROM superheroes_backup WHERE SH_NAME =:old.sh_name;
ELSIF UPDATING THEN
UPDATE superheroes_backup
SET SH_NAME =:new.sh_name WHERE SH_NAME =:old.sh_name;
END IF;
END;

/*
DDL triggers are the triggers which are created over DDL statements such as CREATE, DROP
or ALTER. Using this type of trigger you can monitor the behavior and force rules on your
DDL statements.
*/
CREATE TABLE schema_audit
( ddl_date DATE, ddl_user VARCHAR2(15), object_created VARCHAR2(15),
object_name VARCHAR2(15), ddl_operation VARCHAR2(15)
);
CREATE OR REPLACE TRIGGER hr_audit_tr
AFTER DDL ON SCHEMA
BEGIN
INSERT INTO schema_audit VALUES ( sysdate,
sys_context(&#39;USERENV&#39;,&#39;CURRENT_USER&#39;), ora_dict_obj_type, ora_dict_obj_name,
ora_sysevent);
END;
/

    CREATE OR REPLACE TRIGGER db_audit_tr
AFTER DDL ON DATABASE
BEGIN
INSERT INTO schema_audit VALUES (sysdate,
sys_context(&#39;USERENV&#39;,&#39;CURRENT_USER&#39;), ora_dict_obj_type,
ora_dict_obj_name, ora_sysevent); END;/


---- TRANSACTIONS-------
select * from students;
delete from students where student_id=3;
commit;
set transaction name 'student_t';
insert into students values (5, 'test3', 120, 234);
savepoint before_test;
insert into students values (6, 'test4', 120, 234);
rollback to savepoint before_test;
rollback;
