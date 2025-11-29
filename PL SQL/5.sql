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
