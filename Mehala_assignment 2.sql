--TASK 1

--1.Create the database named "SISDB".

CREATE DATABASE SISDB;

--2.Define the schema.

CREATE SCHEMA SIS;

--4.Create appropriate Primary Key and Foreign Key constraints for referential integrity.

CREATE TABLE SIS.Students(
student_id INT PRIMARY KEY,
first_name VARCHAR(10),
last_name VARCHAR(10),
date_of_birth DATE,
email VARCHAR(20),
phone_number INT
);

CREATE TABLE SIS.Courses(
course_id INT PRIMARY KEY,
course_name VARCHAR(10),
credits INT,
teacher_id INT REFERENCES SIS.Teacher(teacher_id)
);

CREATE TABLE SIS.Enrollments(
enrollment_id INT PRIMARY KEY,
student_id INT REFERENCES SIS.Students(student_id) ON DELETE CASCADE,
course_id INT REFERENCES SIS.Courses(course_id),
enrollment_date DATE
);

CREATE TABLE SIS.Teacher(
teacher_id INT PRIMARY KEY,
first_name VARCHAR(10),
last_name VARCHAR(10),
email VARCHAR(20)
);

CREATE TABLE SIS.Payments(
payment_id INT PRIMARY KEY,
student_id INT REFERENCES SIS.Students(student_id) ON DELETE CASCADE,
amount INT,
payment_date DATE
);


--5.Insert at least 10 sample records.

INSERT INTO SIS.Students VALUES
(2,'Benny','George','1999-09-04','benny@gmail.com',1456327241),
(3,'John','Davis','2000-02-21','john@gmail.com',1246787466),
(4,'Caren','David','1997-09-17','caren@gmail.com',1332642756),
(5,'Henry','Jones','2001-12-06','henry@gmail.com',1286653326),
(6,'Harry','Potter','2003-02-19','harry@gmail.com',1545443253),
(7,'Charlie','Lewis','1998-03-31','charlie@gmail.com',1423535675),
(8,'Marry','Willams','1997-06-10','marry@gmail.com',1237654686),
(9,'Jenny','Dooms','1998-02-15','jenny@gmail.com',1753442544),
(10,'Sara','Diana','2000-02-18','sara@gmail.com',1433562354)


INSERT INTO SIS.Courses VALUES
(101,'CS',3,1201),
(102,'Math',4,1209),
(103,'Java',3,1206),
(104,'Python',4,1208),
(105,'C#',3,1203),
(106,'JS',3,1202),
(107,'SQL',2,1210),
(108,'ReactJS',4,1207),
(109,'Angular',4,1205),
(110,'Power BI',3,1204)

INSERT INTO SIS.Enrollments VALUES
(1101,5,107,'2023-12-06'),
(1102,2,105,'2024-01-09'),
(1103,1,103,'2024-03-06'),
(1104,10,102,'2024-04-03'),
(1105,8,109,'2024-02-17'),
(1106,3,110,'2023-11-03'),
(1107,7,101,'2024-02-25'),
(1108,9,104,'2023-11-23'),
(1109,6,106,'2024-01-22'),
(1110,4,108,'2024-03-21')

INSERT INTO SIS.Teacher VALUES
(1201,'James','Smith','james@gmail.com'),
(1202,'Jane','Lawra','jane@gmail.com'),
(1203,'Kevin','Catter','kevin@gmail.com'),
(1204,'Maria','Sen','maria@gmail.com'),
(1205,'Candy','Roop','candy@gmail.com'),
(1206,'Albert','Vein','albert@gmail.com'),
(1207,'Mart','Columbus','mart@gmail.com'),
(1208,'Mark','Antony','mark@gmail.com'),
(1209,'Sara','Wilson','sara@gmail.com'),
(1210,'Diana','James','diana@gmail.com')

INSERT INTO SIS.Payments VALUES
(1001,2,20000,'2024-01-09'),
(1002,1,35000,'2024-03-06'),
(1003,5,15000,'2023-12-06'),
(1004,8,40000,'2024-02-17'),
(1005,9,12000,'2023-11-23'),
(1006,4,23000,'2024-03-21'),
(1007,3,34000,'2023-11-03'),
(1008,10,28000,'2024-04-03'),
(1009,7,17000,'2024-02-25'),
(1010,6,27000,'2024-01-22')

--TASK 2

--1.Write an SQL query to insert a new student into the "Students" table.

INSERT INTO SIS.Students VALUES
(1,'John','Doe',' 1995-08-15','john.doe@example.com', 1234567890);

--2.Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.

INSERT INTO SIS.Enrollments VALUES
(1111,2,109,'2023-09-12');

--3.Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.

UPDATE SIS.Teacher 
SET email='janela@gmail.com'
WHERE teacher_id=1202;

--4.Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course.

DELETE FROM SIS.Enrollments
WHERE student_id=2 AND course_id=105;

--5.Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.

UPDATE SIS.Courses
SET teacher_id=1202
WHERE course_name='Python';

--6.Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.

DELETE FROM SIS.Students
WHERE student_id=5;

--7.Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.

UPDATE SIS.Payments
SET amount=50000
WHERE payment_id=1006;


--TASK 3

--1.Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID.

SELECT first_name,SUM(amount) AS total_payments
FROM SIS.Students 
JOIN SIS.Payments  ON SIS.Students.student_id =SIS.Payments.student_id
WHERE first_name='Caren'
GROUP BY first_name;

--2.Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.

SELECT course_name ,COUNT(student_id) AS count_of_students
FROM SIS.Courses 
JOIN SIS.Enrollments ON SIS.Enrollments.course_id =SIS.Courses.course_id
GROUP BY course_name;

--3.Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.

INSERT INTO SIS.Students VALUES
(11,'Sun','Shine','2002-01-28','sun@gmail.com',1433234354);

SELECT CONCAT(first_name,' ',last_name) AS Not_Enrolled FROM SIS.Students S 
LEFT JOIN 
    SIS.Enrollments E ON S.student_id=E.student_id
WHERE E.student_id IS NULL;

--4.Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.

SELECT first_name,last_name,course_name from SIS.Students s 
INNER JOIN 
   SIS.Enrollments e ON s.student_id=e.student_id
INNER JOIN
   SIS.Courses c ON c.course_id = e.course_id
GROUP BY first_name,last_name,course_name;

--5.Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

SELECT first_name,last_name,course_name from SIS.Teacher t 
INNER JOIN 
   SIS.Courses c ON c.teacher_id=t.teacher_id;

--6.Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables.

SELECT first_name,last_name,enrollment_date,course_name from SIS.Students s 
INNER JOIN 
   SIS.Enrollments e ON s.student_id=e.student_id
INNER JOIN
   SIS.Courses c ON c.course_id = e.course_id;

--7.Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.

SELECT CONCAT(first_name,' ',last_name) AS No_Payment FROM SIS.Students S 
LEFT JOIN 
    SIS.Payments P ON S.student_id=P.student_id
WHERE P.student_id IS NULL;

--8.Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.

SELECT course_name AS No_enrollment FROM SIS.Courses c
LEFT JOIN
    SIS.Enrollments e ON c.course_id=e.course_id
WHERE e.course_id IS NULL;

--9.Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records.


INSERT INTO SIS.Enrollments VALUES
(1012,6,101,'2023-12-03')

SELECT s.first_name, s.last_name
FROM SIS.Enrollments e1
JOIN SIS.Enrollments e2 ON e1.student_id = e2.student_id AND e1.course_id <> e2.course_id
JOIN SIS.Students s ON e1.student_id = s.student_id
GROUP BY s.first_name,s.last_name;

--10.Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.

SELECT CONCAT(first_name,' ',last_name) AS Not_assigned FROM SIS.Teacher t
LEFT JOIN
    SIS.Courses c ON c.teacher_id=t.teacher_id
WHERE c.teacher_id IS NULL;



--TASK 4


--1.Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.

SELECT course_id, AVG(course_count) AS average_count
FROM (
    SELECT course_id, COUNT(*) AS course_count
    FROM SIS.Enrollments
    GROUP BY course_id
) AS course_counts
GROUP BY course_id;

--2.Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.

SELECT * FROM SIS.Students WHERE student_id=
(SELECT student_id FROM SIS.Payments WHERE amount=
(SELECT MAX(amount) FROM SIS.Payments));

--3.Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count.

SELECT course_id, course_name, enrollment_count FROM (
SELECT course_id, course_name, 
(SELECT COUNT(*) FROM SIS.Enrollments WHERE 
SIS.Enrollments.course_id = SIS.Courses.course_id) AS enrollment_count
FROM SIS.Courses
) AS course_enrollments
WHERE enrollment_count = (
SELECT MAX(cnt) FROM (
SELECT COUNT(*) AS cnt FROM SIS.Enrollments GROUP BY course_id
    ) AS enrollment_counts
);
	

--4.Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses.

SELECT teacher_id,SUM(amount) AS total_amount FROM
(SELECT teacher_id,p.amount FROM SIS.Courses c
INNER JOIN 
   SIS.Enrollments e ON c.course_id=e.course_id
INNER JOIN 
   SIS.Payments p ON e.student_id=p.student_id) AS amount
GROUP BY teacher_id;



--5.Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses.

INSERT INTO SIS.Enrollments VALUES
(1112,6,103,'2024-02-16'),
(1113,6,104,'2024-02-16'),
(1114,6,102,'2024-02-16'),
(1115,6,105,'2024-02-16'),
(1117,6,107,'2024-02-16'),
(1118,6,108,'2024-02-16'),
(1119,6,109,'2024-02-16'),
(1120,6,110,'2024-02-16')


SELECT s.student_id,s.first_name,s.last_name FROM SIS.Students s WHERE 
(SELECT COUNT(DISTINCT course_id) FROM SIS.Enrollments) = 
(SELECT COUNT(DISTINCT course_id) FROM SIS.Enrollments e WHERE e.student_id = s.student_id
 );

--6.Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.

SELECT first_name,last_name FROM SIS.Teacher WHERE teacher_id NOT IN
(SELECT teacher_id FROM SIS.Courses)

--7.Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.

SELECT AVG(AGE) AS AVG_AGE FROM(
SELECT DATEDIFF(YEAR,date_of_birth,GETDATE()) AS AGE FROM SIS.Students) AS AGE;

--8.Identify courses with no enrollments. Use subqueries to find courses without enrollment records.

SELECT * FROM SIS.Courses WHERE course_id NOT IN
(SELECT course_id FROM SIS.Enrollments);

--9.Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments

SELECT s.student_id,s.first_name,s.last_name,c.course_id,c.course_name,
( SELECT SUM(p.amount) FROM SIS.Payments p
  WHERE p.student_id = s.student_id) AS TotalPayment
FROM SIS.Students s
JOIN
    SIS.Enrollments e ON s.student_id = e.student_id
JOIN
    SIS.Courses c ON e.course_id = c.course_id;


--10.Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.

SELECT student_id,first_name,last_name FROM SIS.Students WHERE student_id IN 
( SELECT student_id FROM SIS.Payments GROUP BY student_id
  HAVING COUNT(payment_id) > 1);


--11.Write an SQL query to calculate the total payments made by each student. Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.

SELECT s.student_id,s.first_name,s.last_name,SUM(p.amount) AS total_payments
FROM SIS.Students s
FULL JOIN
    SIS.Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;


--12.Retrieve a list of course names along with the count of students enrolled in each course. Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.

SELECT c.course_name,COUNT(e.student_id) AS num_students_enrolled
FROM SIS.Courses c
FULL JOIN SIS.Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

--13.Calculate the average payment amount made by students. Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average

SELECT AVG(p.amount) AS average_payment_amount FROM SIS.Students s
JOIN SIS.Payments p ON s.student_id = p.student_id;



SELECT * FROM SIS.Students
SELECT * FROM SIS.Courses
SELECT * FROM SIS.Enrollments
SELECT * FROM SIS.Teacher
SELECT * FROM SIS.Payments

