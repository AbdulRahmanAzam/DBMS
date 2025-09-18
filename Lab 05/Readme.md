```sql
# in lab task
-- Q 1
select e.*, d.* from employees e, departments d;


-- Q 2
select d.*, e.* from departments d left join employees e on d.department_id = e.department_id;

-- Q3
select e.first_name as Employee, m.first_name as manager from employees e left join employees m on e.manager_id = m.employee_Id;

-- Q4
select e.* from employees e left join projects p on e.employee_Id = p.employee_Id where p.project_id is NULL;
```
