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
