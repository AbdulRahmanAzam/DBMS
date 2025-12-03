# SQL
### Q1: Employees who earn more than the average salary of all employees hired in the same year
```sql
create table emp (
    empid number primary key,
    ename varchar2(50),
    salary number,
    hireDate date
);

select e.empid, e.ename, e.salary, e.hireDate
from emp e
join (
    select to_char(hireDate, 'yyyy') as hireYear,
    avg(salary) as avgSalary
    from emp
    group by to_char(hireDate, 'yyyy')
) a
    on to_char(e.hireDate, 'yyyy') = a.hireYear
where e.salary > a.avgSalary;

select * from emp;
```

### Q2: Employees who have no job history and whose salary is less than the minimum salary of any employee who does have job history
```sql

select e.empid, e.ename, e.salary
from emp e
where e.empid not in (select empid from job_history)
 and e.salary < (
    select min(salary)
    from emp
    where empid in (select empid from job_history)
  );

```

### Q3: Employees whose commission is greater than the average commission for their job — show employee, job, salary, commission, and job average commission
```sql
select e.empid, e.ename, e.salary, e.job_id, e.commission_pct
from emp e
join (
  select job_id,
  avg(commission_pct) as avg_commission
  from emp
  where commission_pct is not null
  group by job_id
) j
 on e.job_id = j.job_id
 where e.commission_pct > j.avg_commission;
```

### Q4
```sql
select e.ename, e.salary, e.hire_date, d.dep_name, y.hiresThatYear
from emp e
join departments d on e.depid = d.depid
join (
  select depid, to_char(hireDate, 'yyyy') as hireYear, count(*) as hiresThatYear
  rank() over (
    partition by depid
    order by count(*) desc
  ) as rnk
  from emp
  group by depid, to_char(hireDate, 'yyyy')
) y
on d.depid = y.depid
and to_char(e.hireDate, 'yyyy') = y.hireDate
where y.rnk = 1;
```

### Q5
```sql
select d.depid, d.dep_name, count(*) as numEmployeesAbove5000
from emp e
join departments d on e.depid = d.depid
where e.salary > 5000
group by d.depid,d.dep_name
having count(*) > 3;
```
