
```sql
-- Q1
select d.dept_id,d.dept_name,(select count(*) from student s where s.dept_id = d.dept_id) as Student_Count from department d;

--Q2
select s.dept_id, avg(s.gpa) as avg_gpa from student s group by s.dept_id having avg(s.gpa) > 3.0;

-- Q3

select c.course_name, AVG(s.fee_paid) as average_fee from  Student s, Enrollment e, Course c where s.student_id = e.student_id and e.course_id = c.course_id group by c.course_name;

select c.course_name,AVG(s.fee_Paid) as average_fee from Course c inner join enrollment e on c.course_id = e.course_id inner join Student s on e.student_id = s.Student_ID group by c.course_name;

-- Q4
select d.dept_id,d.dept_name,(select count(*) from faculty s where s.dept_id = d.dept_id) as Student_Count from department d;

-- Q5 
select * from faculty where salary > (select avg(salary) from FACULTY);

-- Q6
select * from student where gpa > ANY (select gpa from student where dept_id = 1);

-- Q7
select * from (select * from student order by GPA DESC) where rownum <4;

-- Q8
SELECT s.student_id, s.student_name
FROM Student s WHERE NOT EXISTS ( SELECT c.course_id FROM Student a, Enrollment ea, Course c
WHERE a.student_name = 'Ali' AND a.student_id = ea.student_id AND ea.course_id = c.course_id
AND NOT EXISTS ( SELECT 1 FROM Enrollment e WHERE e.student_id = s.student_id AND e.course_id = c.course_id ));


-- Q9
select d.dept_id,d.dept_name,(select SUM(s.FEE_PAID) from student s where s.dept_id = d.dept_id) as Student_Count from department d;

-- Q10
select e.student_id, (select c.course_name from COURSE c where e.course_id = course_id) as Courses from enrollment e where e.student_id in ( select s.student_id from student s where s.gpa > 3.5);


-- Q11
select dept_id from student s where 1000000 <  (select SUM(s.FEE_PAID) from student s1 group by s1.dept_id having s.dept_id = s1.dept_id );

-- Q12

select f.dept_id from faculty f where f.salary>100000 group by f.dept_id having count(f.faculty_id) >5;

-- Q13
delete from student where GPA < (select AVG(s.GPA) from student s);

-- Q14
delete from course c where c.COURSE_ID not in (select e.course_id from ENROLLMENT e );

-- Q15
insert into HighFee_Students (Student_ID, Student_Name, Dept_ID, GPA, Fee_Paid)  select Student_ID, Student_Name, Dept_ID, GPA, Fee_Paid  from student where fee_paid >(select AVG(fee_paid) from student);

-- Q16
insert into Retired_Faculty (Faculty_ID, Faculty_Name, Dept_ID, Salary, Joining_Date) select Faculty_ID, Faculty_Name, Dept_ID, Salary, Joining_Date from Faculty where Joining_Date < TO_DATE('1985,01,01','YYYY,MM,DD');

 -- Q17
select d.dept_id,d.dept_name from department d where d.DEPT_ID =(select max_id from(select s.dept_id as max_id from student s group by s.dept_id order by max_id desc ) where rownum <2);

-- Q18
select course_id from 
(select count(*) as cnt ,e.course_id from  ENROLLMENT e group by e.COURSE_ID order by cnt desc) 
where rownum <4;

-- Q19
select s.student_id from student s inner join enrollment e on e.student_id = s.student_id where s.gpa > (select AVG(gpa) from student )
group by s.student_id having  count(course_id) > 3;

select s.student_id from student s, enrollment e where e.student_id = s.student_id and  s.gpa > (select AVG(gpa) from student )
group by s.student_id having  count(course_id) > 3;

-- Q20

insert into Unassigned_Faculty (Faculty_ID, Faculty_Name, Dept_ID, Salary, Joining_Date)
select f.Faculty_ID, f.Faculty_Name, f.Dept_ID, f.Salary, f.Joining_Date
from faculty f where f.faculty_id not in (select fc.faculty_id from facultycourse fc );

```
