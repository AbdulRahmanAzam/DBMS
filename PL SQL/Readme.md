
<img width="782" height="536" alt="image" src="https://github.com/user-attachments/assets/081354c9-9fe2-438d-8ce5-5ea90184500b" />

<img width="796" height="460" alt="image" src="https://github.com/user-attachments/assets/c6d399a9-9c61-4a6c-b34f-0caa02372200" />



# ALL THE PLSQL TASKS ARE BELOW   

## Q1
```sql
CREATE TABLE Employee(
    empno number primary key,
    ename varchar2(50),
    salary number
);

insert into Employee values (1,'Ali', 5000);
insert into Employee values (2,'Basit', 2000);
insert into Employee values (3, 'Anas', 4000);
insert into Employee values (4, 'Anashehe', 4500);
commit;
set SERVEROUTPUT on
DECLARE
    vempno number := &empno;
    vsalary number;
    vbonus number;

begin 
    select salary 
    into vsalary
    from Employee
    where empno = vempno;

    if vsalary is null then 
        vbonus := 0;
    elsif vsalary < 1000 then
        vbonus := vsalary * 0.10;
    elsif vsalary between 1000 and 5000 then
        vbonus := vsalary * 0.15;
    else 
        vbonus := vsalary * 0.20;
    end if;

    -- print results
    DBMS_OUTPUT.PUT_LINE('Emp no: ' || vempno);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || NVL(vsalary, 0));
    DBMS_OUTPUT.PUT_LINE('Bonus: ' || vbonus);

END;
/
```

## Q2
```sql
-- Drop the table if it already exists (optional)
DROP TABLE employee PURGE;

-- Create the employee table
CREATE TABLE employee (
    empno      NUMBER PRIMARY KEY,
    ename      VARCHAR2(50),
    ecommission NUMBER,
    salary     NUMBER
);

-- Insert sample data
INSERT INTO employee VALUES (101, 'Ali', 20, 800);
INSERT INTO employee VALUES (102, 'Sara', NULL, 1200);
INSERT INTO employee VALUES (103, 'John', 50, 1600);
INSERT INTO employee VALUES (104, 'Mary', NULL, 500);

COMMIT;

-- Enable DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- PL/SQL block
DECLARE
    vempno      NUMBER := 102;       -- employee number to look up
    vname       VARCHAR2(50);
    vcommission NUMBER;
    vsalary     NUMBER;
BEGIN
    -- Fetch commission, salary, and name for the employee
    SELECT ecommission, salary, ename
    INTO vcommission, vsalary, vname
    FROM employee
    WHERE empno = vempno;

    -- If commission is NULL, calculate 10% of salary
    IF vcommission IS NULL THEN
        vcommission := vsalary * 0.10;
    END IF;
    
    -- Add commission to salary
    vsalary := vsalary + vcommission;

    -- Print results
    DBMS_OUTPUT.PUT_LINE('Empno     : ' || vempno);
    DBMS_OUTPUT.PUT_LINE('Name      : ' || vname);
    DBMS_OUTPUT.PUT_LINE('Salary    : ' || vsalary);
    DBMS_OUTPUT.PUT_LINE('Commission: ' || vcommission);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with Empno ' || vempno);
END;
/
```


## Q3
```sql
-- dept name of emp whose deptno is 30
set serveroutput on;
declare
    vdeptno number := 30;
    vdeptname varchar2(50);
begin
    select d.dname
    into vdeptname
    from scott.dept d
    where d.deptno = vdeptno;

    DBMS_OUTPUT.PUT_LINE('DEPT NAME: ' || vdeptname);
    DBMS_OUTPUT.PUT_LINE('DEPT NO: ' || vdeptno);

END;
/
```

## Q5
```sql
set serveroutput on;
declare
    vdeptno number := 20;
begin
    -- select sal 
    -- into vsalary
    -- from scott.emp
    -- where DEPTNO = vdeptno;
    -- DBMS_OUTPUT.PUT_LINE('salary: ' || vsalary);

    -- since there are more than 1 emp in 1 dept
    for rec in (select sal from scott.emp where deptno = vdeptno) loop
        DBMS_OUTPUT.PUT_LINE('salary: ' || rec.sal);
    END LOOP;
end;
/
```


## Q6
```sql
set serveroutput on;
declare
    vempno number := 7369;
    oldsalary number;
    newsalary number;
begin
    select sal
    into oldsalary
    from scott.emp
    where empno = vempno;

    update scott.emp
    set sal = sal + sal 1.10
    where empno = vempno;

    select sal
    into newsalary
    from scott.emp
    where empno = vempno;

    dbms_output.put_line('old salary: ' || oldsalary);
    dbms_output.put_line('new salary: ' || newsalary);
end;
/
```


## Q7
```sql
set serveroutput on;
declare
    vdeptno number := &deptno;
begin
    for rec in (select sal, empno from scott.emp where sal > 1000 and deptno = vdeptno) loop
        dbms_output.put_line('empno: ' || rec.empno);
        dbms_output.put_line('salary: ' || rec.sal);
        dbms_output.put_line('');
    end loop;
end;
/
```


## Q9
```sql
set serverouput on;
declare
    num1 number := &num1;
    num2 number := &num2;
    vsum number;
begin   
    vsum := num1 + num2;
    dbms_output.put_line('the sum of ' || num1 || ' and ' || num2 || ' is ' || vsum);
end;
/
```


## Q10
```sql
set serverouput on;
declare
    vlower number := &lowernumber;
    vupper number := &uppernumber;
    betweensum number := 0;
begin   
    for i in vlower .. vupper loop
        betweensum := betweensum + i;
    end loop;

    dbms_output.put_line('the sum of number from ' || vlower || ' to ' || vupper || ' is ' || betweensum);

end;
/
```

## Q11
```sql
set serveroutput on;
declare
    vempno number := &empno;
    vname varchar2(50);
    vhiredate date;
    vdeptname varchar2(50);

begin
    select e.empno, e.ename, e.hiredate, d.dname
    into vempno, vname, vhiredate, vdeptname
    from scott.emp e
    join scott.dept d on e.deptno = d.DEPTNO
    where e.empno = vempno;

    dbms_output.put_line('empno: ' || vempno);
    dbms_output.put_line('deptname: ' || vdeptname);
    dbms_output.put_line('hiredate: ' || vhiredate);
    dbms_output.put_line('name: ' || vname);
end;
/
```

## Q12
```sql
set serveroutput on;
DECLARE
    vnum number := &num;
    voriginal number;
    vreversed number := 0;
    vdigit number;

BEGIN
    voriginal := vnum;

    while vnum > 0 LOOP
        vdigit := mod(vnum, 10); -- get last digit
        vreversed := vreversed * 10 + vdigit; -- build reverse number
        vnum := trunc(vnum / 10);  -- remove last digit
    end loop;

    if voriginal = vreversed then
        dbms_output.put_line(voriginal || ' is a palindormo');
    else
        dbms_output.put_line(voriginal || ' is NOT a palindormo');
    end if;
end;
/
```
