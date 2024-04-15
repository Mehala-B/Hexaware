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
(2,'Benny','George','1999-09-04','benny@gmail.com',1456327241),
(3,'John','Davis','2000-02-21','john@gmail.com',1246787466),
(4,'Caren','David','1997-09-17','caren@gmail.com',1332642756),
(5,'Henry','Jones','2001-12-06','henry@gmail.com',1286653326),
(6,'Harry','Potter','2003-02-19','harry@gmail.com',1545443253),
(7,'Charlie','Lewis','1998-03-31','charlie@gmail.com',1423535675),
(8,'Marry','Willams','1997-06-10','marry@gmail.com',1237654686),
(9,'Jenny','Dooms','1998-02-15','jenny@gmail.com',1753442544),
(10,'Sara','Diana','2000-02-18','sara@gmail.com',1433562354)
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
FROM SIS.Students 
JOIN SIS.Payments  ON SIS.Students.student_id =SIS.Payments.student_id
WHERE first_name='Caren'
GROUP BY first_name;
FROM SIS.Courses 
JOIN SIS.Enrollments ON SIS.Enrollments.course_id =SIS.Courses.course_id
GROUP BY course_name;
LEFT JOIN 
    SIS.Enrollments E ON S.student_id=E.student_id
WHERE E.student_id IS NULL;
INNER JOIN 
   SIS.Enrollments e ON s.student_id=e.student_id
INNER JOIN
   SIS.Courses c ON c.course_id = e.course_id
GROUP BY first_name,last_name,course_name;

--5.Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

SELECT first_name,last_name,course_name from SIS.Teacher t 
INNER JOIN 
   SIS.Courses c ON c.teacher_id=t.teacher_id;

INNER JOIN 
   SIS.Enrollments e ON s.student_id=e.student_id
INNER JOIN
   SIS.Courses c ON c.course_id = e.course_id;
LEFT JOIN 
    SIS.Payments P ON S.student_id=P.student_id
WHERE P.student_id IS NULL;

FROM SIS.Enrollments e1
JOIN SIS.Enrollments e2 ON e1.student_id = e2.student_id AND e1.course_id <> e2.course_id
JOIN SIS.Students s ON e1.student_id = s.student_id
GROUP BY s.first_name,s.last_name;
FROM (
    SELECT course_id, COUNT(*) AS course_count
    FROM SIS.Enrollments
    GROUP BY course_id
) AS course_counts
GROUP BY course_id;
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
(SELECT COUNT(DISTINCT course_id) FROM SIS.Enrollments) = 
(SELECT COUNT(DISTINCT course_id) FROM SIS.Enrollments e WHERE e.student_id = s.student_id
 );
( SELECT SUM(p.amount) FROM SIS.Payments p
  WHERE p.student_id = s.student_id) AS TotalPayment
FROM SIS.Students s
JOIN
    SIS.Enrollments e ON s.student_id = e.student_id
JOIN
    SIS.Courses c ON e.course_id = c.course_id;
( SELECT student_id FROM SIS.Payments GROUP BY student_id
  HAVING COUNT(payment_id) > 1);
FROM SIS.Students s
FULL JOIN
    SIS.Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;
FROM SIS.Courses c
FULL JOIN SIS.Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
JOIN SIS.Payments p ON s.student_id = p.student_id;