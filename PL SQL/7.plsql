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
