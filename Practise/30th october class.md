```sql

create table students (
    stdIdint primary key,
    stdName varchar(255) not null,
    h_pay int,
    y_pay int
);

insert into students (stdInt, stdName) values(3, 'Sana');

set serveroutput on;

-- DML TRIGGER
-- BEFORE INSERT
create or replace trigger insert_data
before insert on students
for each row
begin
    if :new.h_pay is null then
        :new.h_pay := 250;
    end if;
end;
/

-- before update
create or replace trigger update_salary
before update on students
for each row
begin
    :new.h_pay := new.h_pay * 1920;
end;
/

update students set h_pay = 200;

--Delete
create or replace trigger prevent_admin
before delete on students
for each row
begin
    if :old.stdName = 'admin' then
        raise_application_error(-20000, 'you cannot delete admin record');
    end if;
end;
/

delete from students where name = 'admin';

-- //              LOGS
create table student_logs(
    studId int,
    studName varchar(20),
    inserted_by varchar(20),
    inserted_on date
);

create or replace trigger after_inserted
after insert on students
for each row
begin
    insert into student_logs(studId, studName, inserted_by, inserted_on) values 
    (:NEW.studId, :NEW.studName, sys_context('userenv', 'session_user'),sysdate);
end;
/

insert into students(studId, studName, h_pay) values(2, 'Rahman', 300);

-- Q1 Class Activity
create table deleted_logs(
    sid int,
    sname varchar(20),
    h_pay int,
    y_pay int,
    deleted_by varchar(20),
    deleted_on date
);

create or replace trigger after_del
after delete on students
for each row
begin
    insert into deleted_logs VALUES (:OLD.studId, :OLD.studName,:OLD.h_pay, :OLD.y_pay, sys_context('userenv', 'session_user'), sysdate);
end;
/

delete from students where studId = 3;

select * from students;
select * from student_logs;
select * from deleted_logs;

-- DDL TRIGGERS
-- PREVENT TABLE TO DROP
create or replace trigger drop_table
before drop on DATABASE
begin
    raise_application_error(
        num => -20000,
        msg => 'cannot drop object'
    );
    

```
