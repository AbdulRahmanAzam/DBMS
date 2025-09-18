```sql

create table faculty(
    id int primary key,
    name varchar(20)
);

INSERT INTO faculty (id, name) VALUES (1, 'Dr. John');
INSERT INTO faculty (id, name) VALUES (2, 'Dr. Emily');
INSERT INTO faculty (id, name) VALUES (3, 'Dr. Ahmed');


alter table students add (F_ID int, constraint fk FOREIGN KEY (F_ID) REFERENCES FACULTY(ID));

UPDATE students SET F_ID = 1 WHERE ID = 1;
UPDATE students SET F_ID = 2 WHERE ID = 2;
UPDATE students SET F_ID = 3 WHERE ID = 3;
UPDATE students SET F_ID = 1 WHERE ID = 4;
UPDATE students SET F_ID = 2 WHERE ID = 5;
UPDATE students SET F_ID = 3 WHERE ID = 6;
UPDATE students SET F_ID = 1 WHERE ID = 7;
UPDATE students SET F_ID = 2 WHERE ID = 8;
UPDATE students SET F_ID = 3 WHERE ID = 9;
UPDATE students SET F_ID = 1 WHERE ID = 10;
UPDATE students SET F_ID = 2 WHERE ID = 11;
UPDATE students SET F_ID = 3 WHERE ID = 12;
UPDATE students SET F_ID = 1 WHERE ID = 13;
UPDATE students SET F_ID = 2 WHERE ID = 14;



select * from faculty;
select * from students;

-- INNER JOIN
select s.*, f.Name from Students s INNER JOIN FACULTY f ON s.F_ID = f.ID where CITY = 'Lahore';

-- LEFT OUTER
select s.*, f.Name from students s Left Outer Join faculty f on s.f_ID = f.ID;

-- RIGHT OUTER
select s.*, f.Name from students s right outer join faculty f on s.F_ID = f.ID;

-- SELF REFERENCING
ALTER TABLE faculty add mentor_id int;
update faculty set mentor_id = 1 where id in (2,3);
select f.ID, f.Name as faculty_name, m.name as mentor_name from faculty f inner join faculty m on f.mentor_id = m.ID;

-- CROSS JOIN
select s.*, f.name as faculty_name from students s cross join faculty f;

-- FULL OUTER JOIN
select s.*, f.* from students s full outer join faculty f on s.f_id = f.id;




```
