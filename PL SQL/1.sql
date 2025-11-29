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

set SERVEROUTPUT on;

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

