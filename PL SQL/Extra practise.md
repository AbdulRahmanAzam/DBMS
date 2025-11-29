-- find the deptname, from the empno
-- emptable: empno -> deptno, depttable: deptno -> deptname
```sql
set serveroutput on;

DECLARE
    vempno number := 7839;
    vdeptname varchar2(50);
    vname varchar2(50);

begin
    select d.dname, e.ename
    into vdeptname, vname
    from scott.emp e
    join scott.dept d on e.deptno = d.DEPTNO
    where e.empno = vempno;

    DBMS_OUTPUT.PUT_LINE('Employee No' || vempno);
    DBMS_OUTPUT.PUT_LINE('EMP Name: ' || vname);
    DBMS_OUTPUT.PUT_LINE('Dept Name: ' || vdeptname);

END;
/

```
