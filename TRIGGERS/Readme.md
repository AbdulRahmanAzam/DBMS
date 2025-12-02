<img width="758" height="639" alt="image" src="https://github.com/user-attachments/assets/0c9ec957-3889-46ab-a695-30054c583e4f" />

# DML TRIGGERS TASK
## Q1: Create a DML trigger that logs changes to a specific table when records are inserted, updated, or deleted.
```sql

CREATE TABLE emp (
  empno      NUMBER PRIMARY KEY,
  ename      VARCHAR2(50),
  job        VARCHAR2(30),
  deptno     NUMBER,
  sal        NUMBER
);


-- change log table
create table empChangeLog(
  log_id number generated always as identity primary key,
  operation varchar2(10),
  empno number,
  ename_old varchar2(50),
  ename_new varchar2(50),
  sal_old number,
  sal_new number,
  deptno_old number,
  deptno_new number,
  changedby varchar2(100),
  changedate TIMESTAMP
);


create or replace TRIGGER trgEmpChangeLog
after insert or update or delete on emp
for each row
begin
  if inserting then 
    insert into empChangeLog (
      operation, empno, ename_old, ename_new, sal_old, sal_new, 
      deptno_old, deptno_new, changedby, changedate
    )
    values (
      'INSERT', :NEW.empno, NULL, :NEW.ename, NULL, :NEW.sal,
      NULL, :NEW.deptno, SYS_CONTEXT('USERENV', 'session_user'), SYSTIMESTAMP
    );
  
  elsif updating then
    insert into empChangeLog (
      operation, empno, ename_old, ename_new, sal_old, sal_new, 
      deptno_old, deptno_new, changedby, changedate
    )
    values (
      'UPDATE', :NEW.empno, :OLD.ename, :NEW.ename, :OLD.sal, :NEW.sal,
      :OLD.deptno, :NEW.deptno, SYS_CONTEXT('userenv', 'session_user'), SYSTIMESTAMP
    );
  elsif deleting then
    insert into empChangeLog (
      operation, empno, ename_old, ename_new, sal_old, sal_new, 
      deptno_old, deptno_new, changedby, changedate
    )
    values (
      'DELETE', :OLD.empno, :OLD.ename, NULL, :OLD.sal, NULL,
      :OLD.deptno, NULL, sys_context('userenv','session_user'), SYSTIMESTAMP
    );
  end if;
end;
/

INSERT INTO emp VALUES (1, 'ALI', 'CLERK', 10, 3000);
UPDATE emp SET sal=500, deptno=20 where empno=1;
DELETE from emp where empno=1;

select * from emp;
```

## Q2: Create a DML trigger that enforces a referential integrity constraint between two tables when inserting or updating records.
```sql

CREATE TABLE emp (
  empno      NUMBER PRIMARY KEY,
  ename      VARCHAR2(50),
  job        VARCHAR2(30),
  deptno     NUMBER,
  sal        NUMBER
);

CREATE TABLE dept (
  deptno   NUMBER PRIMARY KEY,
  dname    VARCHAR2(50)
);

INSERT INTO dept VALUES (10, 'ACCOUNTING');
INSERT INTO dept VALUES (20, 'RESEARCH');
INSERT INTO dept VALUES (30, 'SALES');

create or replace trigger trgEmpCheckDeptFk
before insert or update of deptno on emp
for each row
declare
  v_exists number;
  
begin
  if :NEW.deptno is not null then
    select Count(*)
    into v_exists
    from dept
    where deptno = :NEW.deptno;
    
    IF v_exists = 0 then
      raise_application_error(-20001, 'MANUALLY DID, HEHE, DEPT NOT EXIST');
    end if;
  end if;
end;
/

-- Valid insert
INSERT INTO emp VALUES (2, 'SARA', 'ANALYST', 20, 6000);

-- Invalid insert (dept 99 not in DEPT) - should raise error
INSERT INTO emp VALUES (3, 'BILAL', 'CLERK', 99, 2500);

```

## Q3: Create a DML trigger that automatically updates a &quot;last_modified&quot; timestamp when a record is updated in a table.
```sql

CREATE TABLE emp (
  empno      NUMBER PRIMARY KEY,
  ename      VARCHAR2(50),
  job        VARCHAR2(30),
  deptno     NUMBER,
  sal        NUMBER
);

CREATE TABLE dept (
  deptno   NUMBER PRIMARY KEY,
  dname    VARCHAR2(50)
);

INSERT INTO dept VALUES (10, 'ACCOUNTING');
INSERT INTO dept VALUES (20, 'RESEARCH');
INSERT INTO dept VALUES (30, 'SALES');

alter table emp add last_modified TIMESTAMP;


create or replace trigger trgEmpLastModified
before update on emp
for each row
begin
  :NEW.last_modified := SYSTIMESTAMP;
end;
/

INSERT INTO emp (empno, ename, job, deptno, sal) VALUES (4, 'AYESHA', 'SALESMAN', 30, 5000);
UPDATE emp SET sal = 5200 WHERE empno = 4;

SELECT empno, ename, sal, last_modified FROM emp WHERE empno = 4;

```


# DDL TRIGGER TASKS
## Q1: Create a DDL trigger that logs all schema changes (e.g., table creations, modifications, and drops) in a dedicated audit table.
```sql

create table ddlAudit(
  auditId number generated always as identity primary key,
  eventDate timestamp default systimestamp,
  username varchar2(128),
  object_owner varchar2(128),
  object_name varchar2(128),
  object_type varchar2(128),
  ddlOperation varchar2(50),
  ddlStatement CLOB
);


create or replace trigger trgddlaudit 
after DDL on database
begin
  insert into ddlAudit(
    username, object_owner, object_name, object_type, ddlOperation, ddlStatement
  )
  values (
    sys_context('userenv', 'session_user'),
    ora_dict_obj_owner,
    ora_dict_obj_name,
    ora_dict_obj_type,
    ora_sysevent,
    dbms_standard.current_sql
  );
end;
/

create table t_test (id NUMBER);
alter table t_test add (created_at timestamp);
drop table t_test purge;

SELECT eventDate, username, object_owner, object_name, object_type, ddlOperation
FROM ddlAudit
ORDER BY auditId;

```


## Q2: Create a DDL trigger that prohibits any user from altering or dropping a specific critical table.
```sql

create or replace trigger trgprotectcriticaltable
before ddl on database
declare
  vowner varchar2(128) := ora_dict_obj_owner;
  vname varchar2(128) := ora_dict_obj_name;
  vevent varchar2(128) := ora_dict_obj_type;
begin
  if vevent in ('ALTER', 'DROP')
    and upper(vname) = 'CRITICAL_TABLE'
    --- lock to a specific owner if needed
    
  then 
    raise_application_error(-23452, 'OPeration blocked');
  end if;
end;
/
  
ALTER TABLE critical_table ADD (note VARCHAR2(50));  -- should error
DROP TABLE critical_table;                           -- should error

```

## Q3: Create a DDL trigger that prevents the creation of new tables with a specific naming pattern.
```sql

```
