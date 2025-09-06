
```sql
--IN LAB TASKS
-- Q1
create table employees (
    empId int,
    empName varchar(20),
    salary int constraint chk_salary check (salary > 20000),
    deptId int references departments(deptId)
);
drop table employees;
truncate table employees;
DESC employees;
select * from departments;


-- Q2
alter table employees rename column empName to fullName;


-- Q3 
--SELECT constraint_name, constraint_type, search_condition FROM user_constraints WHERE table_name = 'EMPLOYEES' AND constraint_type = 'C';
--alter table employees drop constraint SYS_C007045;

alter table employees drop constraint chk_salary;

insert into employees (empId, fullName, salary) values (1, 'Abdul Rahman Azam', 5000);
select * from employees;


-- Q4
create table departments (
    deptId int primary key,
    deptName varchar(20) unique
);
drop table departments;
alter table departments drop column location;

insert into departments values (1, 'HR');
insert into departments values (2, 'CEO');
insert into departments values (3, 'CTO');

select * from departments;


-- Q5
alter table employees 
add constraint fkDept FOREIGN key (deptId) 
references departments(deptId);


-- Q6 
alter table employees
add bonus number(6,2) default 1000;


-- Q7
alter table employees
add city varchar(20) default 'Karachi';

alter table employees
add age number check(age > 18);


-- Q8
delete from employees where empId IN (1,3);
select * from employees;


-- Q9
alter table employees modify (fullName varchar(20));
alter table employees modify (city varchar(20));


-- Q10
alter table employee
add email varchar(20) unique;


-- POST LAB TASKS
-- Q11
alter table employees
add constraint uq_bonus unique (bonus);
desc employees;

insert into employees(empId, fullName, salary, deptId, bonus, city, age) 
values (5, 'rahman', 5000, 1,1000, 'karachi',19);

insert into employees(empId, fullName, salary, deptId, bonus, city, age) 
values (6, 'azam', 6000, 3,1000, 'lahore',20); -- unique constraint (SYSTEM.UQ_BONUS) violated


-- Q12
alter table employees
add dob DATE;

alter table employees
add age as (trunc(months_between(sysdate, dob) / 12));

alter table employees
add constraint chkAge check(age >= 18);


-- Q13
insert into employees(empId, fullName, salary, deptId, bonus, city, age) values (7, 'rahman', 8000, 1,3000, 'karachi',17);
--Error report - ORA-02290:check constraint (SYSTEM.CHKAGE) violated


-- Q14
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'departments'; -- finding the relevant constraint

alter table employees
drop constraint SYS_C007053; -- deleting using its code

insert into employees(empId, fullName, salary, deptId, bonus, city, age) values (88, 'rahman', 5000, 59,5000, 'karachi',19); -- working

alter table departments
add deptId int;

alter table employees
add constraint fkDept FOREIGN KEY (deptId) references departments(deptId) novalidate;

insert into employees(empId, fullName, salary, deptId, bonus, city, age) values (99, 'rahman', 5000, 59,6000, 'karachi',19); -- not working

-- Q 15
alter table employees
drop (age, city);

desc employees;

-- Q 16
select d.deptName, e.fullName, e.salary
from departments d
left join employees e on d.deptId = e.deptId;

-- Q17
alter table employees rename column salary to monthlySalary;

-- Q18
select d.deptId, e.empId
from departments d
left join employees e on d.deptId = e.deptId
where e.empId is null;


-- Q19
truncate table students;

-- Q20
select deptId, totalEmployees
from (
    select deptId, count(*) as totalEmployees
    from employees
    group by deptId
    order by totalEmployees desc
) where rownum = 1;


```



