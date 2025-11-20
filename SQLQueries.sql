create table Department(
DeptId int primary key,
DeptName varchar(20),
Location varchar(20)
);

insert into Department (DeptId , DeptName , Location) values 
(1,"HR" , "Delhi"),
(2,"Finance" , "Mumbai"),
(3,"IT" , "Bangalore"),
(4,"Marketing" , "Puna");

select * from Department;

create table Employee(
EmpId INT primary key,
EmpName varchar(20) not null,
Gender char(1),
City varchar(20),
Salary decimal(10,2),
DeptId int,
foreign key (DeptId) references Department (DeptId)
);

insert into Employee (EmpId , EmpName , Gender,City,Salary,DeptId) values 
(101, 'Asha', 'F', 'Delhi', 45000, 1),
(102, 'Raj', 'M', 'Mumbai', 60000, 2),
(103, 'Neha', 'F', 'Bangalore', 55000, 3),
(104, 'Karan', 'M', 'Pune', 30000, 4),
(105, 'Meena', 'F', 'Bangalore', 70000, 3),
(106, 'Vikram', 'M', 'Delhi', 40000, 1);

select * from Employee;

create table Project (
 ProjectID VARCHAR(5) PRIMARY KEY,
    ProjectName VARCHAR(30) NOT NULL,
    DeptID INT,
    Budget DECIMAL(12,2),
foreign key (DeptId) references Department (DeptId)
);

insert into Project (ProjectId , ProjectName ,DeptId ,Budget) values
('P1', 'Recruit System', 1, 250000),
('P2', 'Audit Tool', 2, 300000),
('P3', 'ERP System', 3, 600000),
('P4', 'Ad Campaign', 4, 150000);

select * from Project;

Alter table Employee Add column Email varchar(50);
Alter table Employee Modify column salary decimal(12,2);
Alter table employee drop column gender;

update employee set salary = salary * 1.10 where DeptId = 3;
update employee set city = 'Hyderabad' where EmpName = 'Karan';

delete from employee where empid = 106;

select * from employee where city = 'Bangalore';

select * from employee where salary >=40000 and salary <= 60000;

select * from employee where salary between 40000 and 60000;

select * from employee where empname like 'N%';

select * from employee where not city = 'Delhi'; --Not Delhi

select * from employee where city <> 'Delhi'; --Not Delhi

select * from project where budget > 200000;

select * from employee where deptId in(1 , 3);

select * from employee where city not in('Mumbai' , 'Pune');

select * from employee where not salary > 50000;

select deptid , sum(salary) as TotalSalary from employee group by DeptId;

select deptid , avg(salary) as AverageSalary from employee group by DeptId;

select deptid , avg(salary) as AverageSalary from employee group by DeptId having AverageSalary  > 50000;

select deptid , avg(salary) as AverageSalary from employee group by DeptId having avg(salary) > 50000;

select city,count(city) as NumberOfEmployee from employee group by city;

select * from employee order by salary desc;

select * from employee order by salary desc Limit 2;

select * from employee order by DeptId asc , salary desc;

Display employees earning more than the average salary of all employees.

SELECT * FROM Employee WHERE Salary > (SELECT AVG(Salary) FROM Employee);

Find employees working on the same department as ‘Neha’.

SELECT * FROM Employee 
WHERE DeptID = (SELECT DeptID FROM Employee WHERE EmpName = 'Neha');

create view highpaid as select empname , salary , deptid from employee where salary > 55000;

select * from highpaid;

create table student (
	student_id int primary key,
	name varchar(8),
	department varchar(4),
	marks int(3),
	city varchar(10)
);

insert into student values
(1,"Aditi","CS", 85 ,"Ahmedabad"),
(2,"Rohan","IT", 75 ,"Surat"),
(3,"Priya","CS", 92 ,"Ahmedabad"),
(4,"Amit","EC", 66 ,"Baroda"),
(5,"Neha","IT", 89 ,"Surat"),
(6,"Krunal","CS", 75 ,"Baroda"),
(7,"Mansi","EC", 81,"Rajkot"),
(8,"Parth","IT", 73 ,"Ahmedabad");

-- 1 Count the total number of student.
select count(*) from student;
+----------+
| count(*) |
+----------+
|        8 |
+----------+


-- 2 Find the average marks of all student.
select avg(marks) from student;
+------------+
| avg(marks) |
+------------+
|    79.5000 |
+------------+


-- 3 Find the highest and lowest marks.
select max(marks) as highest_marks , min(marks) as lowest_marks from student;
+---------------+--------------+
| highest_marks | lowest_marks |
+---------------+--------------+
|            92 |           66 |
+---------------+--------------+


-- 4 Display total marks obtained by students from the IT department.
select marks from student where department="IT";
+-------+
| marks |
+-------+
|    75 |
|    89 |
|    73 |
+-------+


-- 5 Count students from each department.
select count(*) from student group by department;
+----------+
| count(*) |
+----------+
|        3 |
|        2 |
|        3 |
+----------+


-- 6 Find the department-wise average marks.
select avg(marks) from student group by department;
+------------+
| avg(marks) |
+------------+
|    84.0000 |
|    73.5000 |
|    79.0000 |
+------------+


-- 7 List departments having more than 2 student.
select department from student group by department having count(*) > 2;
+------------+
| department |
+------------+
| CS         |
| IT         |
+------------+


-- 8 Show the number of students in each city.
select count(*) from student group by city;
+----------+
| count(*) |
+----------+
|        3 |
|        2 |
|        1 |
|        2 |
+----------+


-- 9 Find the total and average marks of CS student.
select sum(marks) as total , avg(marks) as average from student where department="CS";
+-------+---------+
| total | average |
+-------+---------+
|   252 | 84.0000 |
+-------+---------+


-- 10 Display name and marks of student(s) who scored the highest.
select name , marks from student where marks = (select max(marks) from student);
+-------+-------+
| name  | marks |
+-------+-------+
| Priya |    92 |
+-------+-------+

create table Department_C(
DeptID Int primary key,
DeptName varchar(20)
);

create table Student_C(
StudentID int primary key, 
Name varchar(20), 
Age int, 
Gender varchar(1), 
DeptID int,
foreign key (DeptId) References Department_C (DeptId)
);

insert into Department_C values 
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mechanical');

insert into Student_C values
(101, 'Alice', 19, 'F', 1),
(102, 'Bob', 20, 'M', 1),
(103, 'Charlie', 22, 'M', 2),
(104, 'Diana', 18, 'F', 3),
(105, 'Eve', 21, 'F', 1);

3. Write a query to update the age of the student with StudentID = 102 to 21.

update Student_C set age = 21 where studentid = 102;

4. Write a query to delete the student record whose StudentID is 105.

delete from student_c where studentid = 105;

5. Write a query to display the names of all students whose age is greater than 20.

select name from student_c where age > 20;

6. Write a query to display the total number of students in each department.

select deptid , count(*) from student_c group by deptid;	

7. Write a query to display the department names where the total number of students is
more than 2.

SELECT DeptName 
FROM Department_C
WHERE DeptID IN (
    SELECT DeptID
    FROM Student_C
    GROUP BY DeptID
    HAVING COUNT(StudentID) >= 2
);

SELECT d.DeptName, COUNT(s.StudentID) AS Total_Students
FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName
HAVING COUNT(s.StudentID) >= 2;

8. Write a query to display all student names in ascending order.

select * from student_c order by name asc;

9. Write a query to display each DeptID and the minimum age of students in that
department.

select deptid , min(age) from student_c group by deptid;

10. Write a query to display each department name along with the average age of its
students.

SELECT DeptID, AVG(Age) AS Avg_Age
FROM Student_c 
GROUP BY DeptID;

    SELECT DeptName,
        (SELECT AVG(Age)
            FROM Student_c s
            WHERE s.DeptID = d.DeptID) AS Avg_Age
    FROM Department_c d;

SELECT d.DeptName, AVG(s.Age) AS Avg_Age
FROM Department_c d
JOIN Student_c s ON d.DeptID = s.DeptID
GROUP BY d.DeptName;


11. Write a query to count how many male and female students are in each department.

SELECT DeptID, Gender, COUNT(*) AS Total
FROM Student_C
GROUP BY DeptID, Gender;

SELECT d.DeptName, s.Gender, COUNT(*) AS Total
FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName, s.Gender;


12. Write a query to display departments where the maximum age of students is more
than 21.

SELECT d.DeptName FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName
HAVING MAX(s.Age) > 21;

SELECT DeptName
FROM Department_C d
WHERE (
    SELECT MAX(Age)
    FROM Student_C s
    WHERE s.DeptID = d.DeptID
) > 21;



13. Write a query to display the total number of students in the entire college.

SELECT COUNT(*) AS Total_Students FROM Student;


CREATE TABLE supplier_master (
    SupplierID INT PRIMARY KEY,                      -- unique ID for each supplier
    SupplierName VARCHAR(50) NOT NULL,               -- supplier’s name
    SupplierCity VARCHAR(30),                        -- supplier’s city
    SupplierEmailID VARCHAR(100) UNIQUE,             -- unique email
    SupplierContact VARCHAR(15)                      -- phone number
);

CREATE TABLE Product_master (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    ProductDescription VARCHAR(100),
    ProductQuantity INT ,
    ProductCost DECIMAL(10,2)
);

CREATE TABLE complain_info (
    SupplierID INT,
    ProductID INT,
    ComplainDescription VARCHAR(100),
    ComplainDate DATE,
    ComplainStatus VARCHAR(20),
    FOREIGN KEY (SupplierID) REFERENCES Supplier_master(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Product_master(ProductID)
);


INSERT INTO supplier_master (SupplierID, SupplierName, SupplierCity, SupplierEmailID, SupplierContact)
VALUES
(1, 'hannah', 'Mumbai', 'hannah@example.com', '9876543210'),
(2, 'harsh', 'Delhi', 'harsh@example.com', '9876543211'),
(3, 'hites', 'Bangalore', 'hites@example.com', '9876543212'),
(4, 'hxxxh', 'Chennai', 'hxxxh@example.com', '9876543213'),
(5, 'rahul', 'Pune', 'rahul@example.com', '9876543214'),
(6, 'smith', 'Hyderabad', 'smith@example.com', '9876543215'),
(7, 'peter', 'Jaipur', 'peter@example.com', '9876543216'),
(8, 'hyyhh', 'Surat', 'hyyhh@example.com', '9876543217'),
(9, 'nikil', 'Ahmedabad', 'nikil@example.com', '9876543218'),
(10, 'hzzzh', 'Kolkata', 'hzzzh@example.com', '9876543219');

INSERT INTO Product_master (ProductID, ProductName, ProductDescription, ProductQuantity, ProductCost)
VALUES
(101, 'Laptop', 'Gaming Laptop', 50, 55000.00),
(102, 'Mouse', 'Wireless Mouse', 200, 1500.00),
(103, 'Keyboard', 'Mechanical Keyboard', 150, 3500.00),
(104, 'Monitor', '27-inch Monitor', 70, 18000.00),
(105, 'Printer', 'Laser Printer', 30, 25000.00),
(106, 'Router', 'WiFi 6 Router', 60, 8000.00),
(107, 'Scanner', 'Document Scanner', 20, 22000.00),
(108, 'Tablet', 'Android Tablet', 40, 21000.00),
(109, 'Projector', '4K Projector', 15, 65000.00),
(110, 'Webcam', 'HD Webcam', 80, 5000.00);

INSERT INTO complain_info (SupplierID, ProductID, ComplainDescription, ComplainDate, ComplainStatus)
VALUES
(1, 101, 'display issue', '2024-05-10', 'pending'),
(2, 101, 'disk error', '2024-11-01', 'resolved'),
(2, 105, 'paper jam', '2024-06-15', 'waiting'),
(3, 102, 'battery issue', '2024-07-20', 'resolved'),
(4, 103, 'keys stuck', '2024-08-05', 'pending'),
(5, 105, 'disconnection issue', '2024-11-05', 'pending'),
(5, 106, 'slow speed', '2024-08-10', 'waiting'),
(6, 107, 'disconnected frequently', '2024-09-12', 'resolved'),
(7, 108, 'display cracked', '2024-09-15', 'pending'),
(8, 109, 'discoloration on screen', '2024-10-01', 'resolved'),
(9, 110, 'distorted audio', '2024-10-05', 'pending'),
(10, 104, 'no signal', '2024-10-15', 'waiting');

SELECT * FROM supplier_master;

SELECT * FROM Product_master;

SELECT * FROM complain_info;

Q-2 Supplier name has 5 characters, starting & ending with ‘h’

select * from supplier_master where SupplierName like 'h___h';

Q-3 Minimum product cost

select min(productcost) from Product_master;

Q-4 Add new column S_Age to Supplier master

alter table supplier_master add column S_Age int;

Q-5 Position of ‘e’ in “Hello Data”

select INSTR('Hello Data', 'e') ;

Q-6 Product details with cost > 20000

select * from Product_master where productcost > 20000;

Q-7 Complains with status ‘pending’ or ‘waiting’

select * from  complain_info where complainstatus in('pending' , 'waiting');

Q-8 Month form date ‘2007-03-03’

SELECT MONTH('2007-03-03') AS MonthNumber;
Select MONTHNAME('2007-03-03');

Q-9 Rename complain_info to complain_details

rename table complain_info  to  complain_details;

Q-10 Absolute value of -233.5

SELECT ABS(-233.5) AS AbsoluteValue;

Q-11 Update productname size to 40

alter table  Product_master modify column productname varchar(40);

Q-12 Records where description starts with dis
select * from  complain_details where complaindescription like 'dis%';

CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(50) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M','F')),
    City VARCHAR(30),
    Age INT CHECK (Age >= 0),
    ContactNo VARCHAR(15) UNIQUE
);

CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(30),
    City VARCHAR(30),
    Fee DECIMAL(10,2)
);

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Diagnosis VARCHAR(100),
    BillAmount DECIMAL(10,2),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Medicine (
    MedicineID INT PRIMARY KEY,
    MedicineName VARCHAR(40),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY,
    AppointmentID INT,
    MedicineID INT,
    Quantity INT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
    FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID)
);

INSERT INTO Patient VALUES
(1, 'Riya', 'F', 'Delhi', 25, '9876543210'),
(2, 'Aarav', 'M', 'Mumbai', 30, '9876543211'),
(3, 'Priya', 'F', 'Pune', 28, '9876543212'),
(4, 'Rohan', 'M', 'Chennai', 40, '9876543213'),
(5, 'Sneha', 'F', 'Bangalore', 35, '9876543214');


INSERT INTO Doctor VALUES
(101, 'Dr. Mehta', 'Cardiologist', 'Delhi', 1500),
(102, 'Dr. Sharma', 'Dermatologist', 'Mumbai', 1200),
(103, 'Dr. Rao', 'Neurologist', 'Pune', 1800),
(104, 'Dr. Iyer', 'Dentist', 'Chennai', 800),
(105, 'Dr. Roy', 'Pediatrician', 'Bangalore', 1000);


INSERT INTO Appointment VALUES
(201, 1, 101, '2024-09-15', 'High BP', 3000),
(202, 2, 102, '2024-09-17', 'Skin Allergy', 1500),
(203, 3, 103, '2024-09-18', 'Migraine', 2500),
(204, 4, 104, '2024-09-20', 'Tooth Pain', 900),
(205, 5, 105, '2024-09-22', 'Fever', 1200),
(206, 1, 105, '2024-10-02', 'Cold', 800);


INSERT INTO Medicine VALUES
(301, 'Paracetamol', 25.00, 100),
(302, 'Aspirin', 40.00, 150),
(303, 'Cough Syrup', 60.00, 80),
(304, 'Antibiotic', 120.00, 50),
(305, 'Vitamin C', 20.00, 200);

INSERT INTO Prescription VALUES
(401, 201, 301, 2),
(402, 202, 304, 1),
(403, 203, 302, 2),
(404, 204, 303, 1),
(405, 205, 305, 3),
(406, 206, 301, 1);

select * from Patient;
select * from Doctor;
select * from Appointment;
select * from Medicine;
select * from Prescription;


1️⃣ Display all patients from “Delhi” or “Mumbai”.
select * from patient where City in('Delhi' , 'Mumbai');

2️⃣ Find doctors whose consultation fee is more than ₹1000.
select * from Doctor where Fee > 1000;

3️⃣ Display patients whose name starts with ‘R’.
select * from Patient where PatientName like 'R%';

4️⃣ Show all appointments with bill amount between ₹1000 and ₹2500.
select * from Appointment where BillAmount between 1000 and 2500;

5️⃣ List doctors not from “Mumbai” and “Chennai”.
select * from doctor where city not in('Mumbai' , 'Chennai');

6️⃣ Display total appointments for each doctor.
SELECT 
    d.DoctorName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM 
    doctor d, appointment a
WHERE 
    d.DoctorID = a.DoctorID
GROUP BY 
    d.DoctorName;

select DoctorId , count(*) from appointment group by doctorid;

7️⃣ Display doctors having average bill amount > ₹2000.
select doctorid from Appointment where BillAmount > 2000;

SELECT 
    d.DoctorName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM 
    doctor d, appointment a
WHERE 
    d.DoctorID = a.DoctorID and a.BillAmount > 2000
GROUP BY 
    d.DoctorName 
;

8️⃣ Show total stock value of all medicines.
 select sum(Price * Stock) from medicine;

9️⃣ Display patients ordered by city (A–Z).
select * from patient order by city;

🔟 Show medicines sorted by price (highest first).
select * from medicine order by price desc;

11️⃣ Display patients who have spent more than the average bill amount.
select p.PatientID,
    p.PatientName,
    a.AppointmentID,
    a.BillAmount from patient as p ,appointment a  where a.BillAmount > (select avg(BillAmount) from appointment);

SELECT 
    p.PatientID,
    p.PatientName,
    a.AppointmentID,
    a.BillAmount 
FROM 
    patient AS p, appointment a  
WHERE 
    a.BillAmount > (SELECT AVG(BillAmount) FROM appointment);

12️⃣ Find doctors who treated the same patient as “Riya”.
SELECT DoctorID FROM Appointment
WHERE PatientID IN (SELECT PatientID FROM Patient WHERE PatientName='Riya');

