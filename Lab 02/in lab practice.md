``` sql

SELECT count(*) as total_employees FROM EMPLOYEES;
select count(*) as total_employees, manager_id from EMPLOYEES group by (manager_id);
SELECT distinct manager_id from employees;
select sum(salary) as TOTAL_SALARY from employees;
select sum(salary) as TOTAL_SALARY, min(salary) as MINIMUM_SALARY, max(salary) as MAXIMUM_SALARY, ROUND(avg(salary), 2) as AVERAGE_SALARY from employees;
--select count(*) max(salary) from employees;
select * from employees where salary = (select max(salary) from employees);
select count(*) as SAME_SALARY, salary from employees where salary < 10000 group by (salary);
select count(*) salary from employees where salary < 10000;
select first_name, hire_date from employees order by(first_name);

select * from employees where first_name like 'A%'; -- first alphabet A
select * from employees where substr(first_name, 1,1) = 'a'; -- first alphabet A
select * from employees where first_name like '___a%'; -- forth alphabet is A
select * from employees where substr(first_name, 4,1) = 'a'; -- forth alphabet is A

-- Numeric Function
select * from DUAL;
select abs(-95.34) from dual;
select ceil(90.01),ceil(-90.99) from dual;
select floor (90.9999999999999999999) from dual;
select trunc(90.232435), trunc(90.232435,2), trunc(925,-2) from dual;
select greatest(23,54,23) from dual;
select least(234,265,239) from dual;


-- String Functions
select lower('Abdul Rahman Azam') from dual;
select first_name, upper(first_name) from employees;
select first_name, INITCAP(first_name) from employees;
select first_name, length(first_name) from employees;
select ltrim('AAAAAAAAAAAbdul Rahman Azam', 'A') from dual; -- removing all the A from start
select rtrim ('Abdul Rahman Azammmmmmmmmmmmmm', 'm') from dual; -- removing all m from end;
select trim('m' from 'mmmmmmmmmmAbdul Rahman Azammmmmmmmmmmmmm') from dual; -- remove m from both ends;
select substr('Abdul Rahman Azam', 14, 4) from dual; -- Azam (string, start, how many)
select lpad('good', 7, '*') from dual; -- lpad(string, total characters with addition, character to add) at left;
select rpad('good', 9, '*') from dual;

-- data function
select ADD_MONTHs('16-sep-2005', 2) from dual;
SELECT months_between('16-oct-2005', '16-sep-2005') from dual; -- first large then small
select next_day('4-nov-1999', 'wednesday') from dual;

-- conversion functions
select * from employees where to_char(hire_date,'day') = 'saturday ';
select to_char(hire_date, 'day') from employees;
```
