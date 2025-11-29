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
