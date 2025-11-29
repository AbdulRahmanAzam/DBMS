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
