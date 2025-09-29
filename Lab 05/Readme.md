```sql
# IN LAB TASKS

-- Q 1
select e.*, d.* from employees e, departments d;


-- Q 2
select d.*, e.* from departments d left join employees e on d.department_id = e.department_id;

-- Q3
select e.first_name as Employee, m.first_name as manager from employees e left join employees m on e.manager_id = m.employee_Id;

-- Q4   GENERATE ITS TABLE
select e.* from employees e left join manager_Id p on e.employee_Id = p.employee_Id where p.project_id is NULL;

-- Q5
 select s.student_name,c.COURSE_NAME from students s inner join ENROLLMENTS e on s.student_id = e.student_id inner join courses c on c.COURSE_ID = e.COURSE_ID;

-- Q6
select c.*,o.* from customers c left join orders o on c.CUSTOMER_ID = o.CUSTOMER_ID;
 
 -- Q7
 select d.department_name, e.first_name from departments d left join employees e on d.department_id = e.department_id;

-- Q8
select t.*,s.* from teachers t cross join subjects s;

-- Q9
select d.department_name, count(e.employee_id) as total_employees from departments d left join employees e on d.department_id = e.department_id group by department_name;


## POST LAB TASKS

-- Q11;
select s.STUDENT_NAME,t.TEACHER_NAME from students s inner join teachers t on s.city = t.city;

-- Q12
select e.emp_name,m.emp_name from employees e left join employees m on e.MANAGER_ID = m.EMP_ID;

-- Q13
select * from employees where dept_id is NULL;

-- Q14
select d.DEPT_NAME,AVG(e.salary) as Average_Emp_salary from employees e inner join DEPARTMENTS d
on e.DEPT_ID = d.DEPT_ID group by (e.dept_id,d.dept_name) having AVG(e.salary) > 50000;

-- Q15

select e.emp_name, e.salary, d.dept_name
from Employees e join Departments d ON e.dept_id = d.dept_id
where e.salary > ( select AVG(salary) from Employees
where dept_id = e.dept_id);

-- Q16
select distinct d.dept_name from DEPARTMENTS d inner join employees e
on e.dept_id = d.DEPT_ID where d.DEPT_ID Not In 
(select distinct e1.dept_id from employees e1 where e1.salary < 30000);

-- Q17
select s.student_name, s.city,c.course_name from students s
inner join courses c on s.COURSE_ID = c.COURSE_ID where s.city like'%Lahore%';

-- Q18
select e.emp_name,m.emp_name as Manager ,d.dept_name from employees e inner join DEPARTMENTS d
on e.dept_id = d.dept_id inner join employees m on m.manager_id = e.emp_id
where e.hire_date between to_date('01-01-2020','MM-DD-YYYY') and 
to_date('01-01-2023','MM-DD-YYYY');

-- Q19
select s.student_name from students s inner join courses c on
s.course_id = c.course_id inner join TEACHERS t on c.course_id = t.course_id
where t.TEACHER_NAME  like '%Sir Ali%';

-- Q20

select e.emp_name, m.emp_name AS Manager, d.dept_name from employees e
inner join departments d ON e.dept_id = d.dept_id
inner join employees m ON e.manager_id = m.emp_id
where e.dept_id = m.dept_id;

```
