```sql

-- IN lab tasks
-- Q1. Find the total salary of all employees.
select sum(salary) from employees ;

-- Q2. Find the average salary of employees.
select round(avg(salary),2) from employees;

-- Q3. Count the number of employees reporting to each manager.
select count(*) manager_id from employees group by (manager_id);

-- Q4. Select * employees who has lowest salary.
select * from employees where salary = (select min(salary) from employees);

-- Q5. Display the current system date in the format DD-MM-YYYY.
select to_char(sysdate, 'SS:MI:HH24 DD-MM-YYYY') from dual; -- with time included

-- Q6. Display the current system date with full day, month, and year (e.g., MONDAY AUGUST 2025).
select to_char(sysdate, 'Day Month YYYY') from dual;

-- Q7. Find all employees hired on a Wednesday.
select * from employees where to_char(hire_date, 'day')= 'wednesday';

-- Q8. Calculate months between 01-JAN-2025 and 01-OCT-2024.
select months_between('01-jan-2025','01-oct-2024') from dual;

-- Q9. Find how many months each employee has worked in the company (using hire_date).
select floor(months_between(sysdate, hire_date)) as worked_months from employees;

-- Q10.Extract the first 5 characters from each employee’s last name.
select substr(last_name,  1, 5) from employees;


-- POST LAB TASKS
-- Q11. Pad employee first names with * on the left side to make them 15 characters wide.
select lpad(first_name, 15,'*') from employees;

-- Q12. Remove leading spaces from &#39; Oracle&#39;.
select ltrim('    Oracle', ' ') from dual;

-- Q13. Display each employee’s name with the first letter capitalized.
select INITCAP(first_name || ' ' || last_name) from employees;

-- Q14. Find the next Monday after 20-AUG-2022.
select next_day('20-aug-2022', 'monday') from dual;

-- Q15. Convert &#39;25-DEC-2023&#39; (string) to a date and display it in MM-YYYY format.
select to_char(to_date('25-dec-2023', 'DD-MON-YYYY'), 'MM-YYYY') from dual;

-- Q16. Display all distinct salaries in ascending order.
select distinct salary from employees order by salary asc;

-- Q17. Display the salary of each employee rounded to the nearest hundred.
select trunc(salary, -2) from employees;

-- Q18. Find the department that has the maximum number of employees.
select department_id, count(*) from employees group by department_id order by count(*) desc; -- all department in descending order
select * from (select department_id, count(*) from employees group by department_id order by count(*) desc) where rownum = 1; 

-- Q19. Find the top 3 highest-paid departments by total salary expense.
select * from (select department_id, sum(salary) from employees group by department_id order by sum(salary) desc) where rownum <= 3;

-- Q20. Find the department that has the maximum number of employees.
select * from (select department_id, count(*) from employees group by department_id order by count(*) desc) where rownum = 1;
```

