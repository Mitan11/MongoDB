# SQL Practice Queries

This file contains SQL practice queries with explanations for database operations, table creation, data manipulation, and analysis.

## Table Creation and Data Setup

### Department Table
```sql
-- Create Department table with primary key
create table Department(
    DeptId int primary key,
    DeptName varchar(20),
    Location varchar(20)
);

-- Insert sample department data
insert into Department (DeptId, DeptName, Location) values 
(1, "HR", "Delhi"),
(2, "Finance", "Mumbai"),
(3, "IT", "Bangalore"),
(4, "Marketing", "Puna");

-- Display all departments
select * from Department;
```

### Employee Table
```sql
-- Create Employee table with foreign key reference to Department
create table Employee(
    EmpId INT primary key,
    EmpName varchar(20) not null,
    Gender char(1),
    City varchar(20),
    Salary decimal(10,2),
    DeptId int,
    foreign key (DeptId) references Department (DeptId)
);

-- Insert employee data
insert into Employee (EmpId, EmpName, Gender, City, Salary, DeptId) values 
(101, 'Asha', 'F', 'Delhi', 45000, 1),
(102, 'Raj', 'M', 'Mumbai', 60000, 2),
(103, 'Neha', 'F', 'Bangalore', 55000, 3),
(104, 'Karan', 'M', 'Pune', 30000, 4),
(105, 'Meena', 'F', 'Bangalore', 70000, 3),
(106, 'Vikram', 'M', 'Delhi', 40000, 1);

-- Display all employees
select * from Employee;
```

### Project Table
```sql
-- Create Project table linked to departments
create table Project (
    ProjectID VARCHAR(5) PRIMARY KEY,
    ProjectName VARCHAR(30) NOT NULL,
    DeptID INT,
    Budget DECIMAL(12,2),
    foreign key (DeptId) references Department (DeptId)
);

-- Insert project data
insert into Project (ProjectId, ProjectName, DeptId, Budget) values
('P1', 'Recruit System', 1, 250000),
('P2', 'Audit Tool', 2, 300000),
('P3', 'ERP System', 3, 600000),
('P4', 'Ad Campaign', 4, 150000);

-- Display all projects
select * from Project;
```

## DDL Operations (Data Definition Language)

### ALTER TABLE Examples
```sql
-- Add new column Email to Employee table
Alter table Employee Add column Email varchar(50);

-- Modify salary column to allow larger values
Alter table Employee Modify column salary decimal(12,2);

-- Drop the gender column from Employee table
Alter table employee drop column gender;
```

## DML Operations (Data Manipulation Language)

### UPDATE Examples
```sql
-- Give 10% salary raise to IT department employees
update employee set salary = salary * 1.10 where DeptId = 3;

-- Update Karan's city to Hyderabad
update employee set city = 'Hyderabad' where EmpName = 'Karan';
```

### DELETE Examples
```sql
-- Delete employee with ID 106 (Vikram)
delete from employee where empid = 106;
```

## Query Examples with Explanations

### Basic WHERE Clauses
```sql
-- Question: Find all employees working in Bangalore
select * from employee where city = 'Bangalore';

-- Question: Find employees with salary between 40,000 and 60,000 (using AND operator)
select * from employee where salary >= 40000 and salary <= 60000;

-- Question: Find employees with salary between 40,000 and 60,000 (using BETWEEN)
select * from employee where salary between 40000 and 60000;

-- Question: Find employees whose name starts with 'N'
select * from employee where empname like 'N%';

-- Question: Find employees NOT working in Delhi (using NOT operator)
select * from employee where not city = 'Delhi';

-- Question: Find employees NOT working in Delhi (using <> operator)
select * from employee where city <> 'Delhi';

-- Question: Find projects with budget greater than 200,000
select * from project where budget > 200000;
```

### IN and NOT IN Operations
```sql
-- Question: Find employees working in departments 1 or 3 (HR or IT)
select * from employee where deptId in(1, 3);

-- Question: Find employees NOT working in Mumbai or Pune
select * from employee where city not in('Mumbai', 'Pune');

-- Question: Find employees with salary NOT greater than 50,000 (salary <= 50,000)
select * from employee where not salary > 50000;
```

## Aggregate Functions and GROUP BY

### Basic Aggregations
```sql
-- Question: Calculate total salary expenditure by department
select deptid, sum(salary) as TotalSalary from employee group by DeptId;

-- Question: Calculate average salary by department
select deptid, avg(salary) as AverageSalary from employee group by DeptId;

-- Question: Show departments with average salary > 50,000 (using HAVING with alias)
select deptid, avg(salary) as AverageSalary from employee group by DeptId having AverageSalary > 50000;

-- Question: Show departments with average salary > 50,000 (using HAVING with function)
select deptid, avg(salary) as AverageSalary from employee group by DeptId having avg(salary) > 50000;

-- Question: Count number of employees in each city
select city, count(city) as NumberOfEmployee from employee group by city;
```

## Sorting and Limiting Results

### ORDER BY Examples
```sql
-- Question: Show all employees sorted by salary (highest first)
select * from employee order by salary desc;

-- Question: Show top 2 highest paid employees
select * from employee order by salary desc Limit 2;

-- Question: Sort by department first (ascending), then by salary (descending)
select * from employee order by DeptId asc, salary desc;
```

## Subqueries

### Scalar Subqueries
```sql
-- Question: Display employees earning more than the average salary of all employees
SELECT * FROM Employee WHERE Salary > (SELECT AVG(Salary) FROM Employee);

-- Question: Find employees working in the same department as 'Neha'
SELECT * FROM Employee 
WHERE DeptID = (SELECT DeptID FROM Employee WHERE EmpName = 'Neha');
```

## Views

### Creating and Using Views
```sql
-- Question: Create a view for high-paid employees (salary > 55,000)
create view highpaid as select empname, salary, deptid from employee where salary > 55000;

-- Question: Query the view to see high-paid employees
select * from highpaid;
```

## Student Database Practice

### Student Table Setup
```sql
-- Create student table for practice queries
create table student (
    student_id int primary key,
    name varchar(8),
    department varchar(4),
    marks int(3),
    city varchar(10)
);

-- Insert student data
insert into student values
(1, "Aditi", "CS", 85, "Ahmedabad"),
(2, "Rohan", "IT", 75, "Surat"),
(3, "Priya", "CS", 92, "Ahmedabad"),
(4, "Amit", "EC", 66, "Baroda"),
(5, "Neha", "IT", 89, "Surat"),
(6, "Krunal", "CS", 75, "Baroda"),
(7, "Mansi", "EC", 81, "Rajkot"),
(8, "Parth", "IT", 73, "Ahmedabad");
```

### Student Analysis Queries
```sql
-- Question 1: Count the total number of students
select count(*) from student;
-- Result: 8 students

-- Question 2: Find the average marks of all students
select avg(marks) from student;
-- Result: 79.5000

-- Question 3: Find the highest and lowest marks
select max(marks) as highest_marks, min(marks) as lowest_marks from student;
-- Result: Highest = 92, Lowest = 66

-- Question 4: Display total marks obtained by students from the IT department
select marks from student where department = "IT";
-- Result: Shows marks for IT students (75, 89, 73)

-- Question 5: Count students from each department
select count(*) from student group by department;
-- Result: Shows count per department

-- Question 6: Find the department-wise average marks
select avg(marks) from student group by department;
-- Result: Average marks per department

-- Question 7: List departments having more than 2 students
select department from student group by department having count(*) > 2;
-- Result: CS and IT departments

-- Question 8: Show the number of students in each city
select count(*) from student group by city;
-- Result: Student count per city

-- Question 9: Find the total and average marks of CS students
select sum(marks) as total, avg(marks) as average from student where department = "CS";
-- Result: Total = 252, Average = 84.0000

-- Question 10: Display name and marks of student(s) who scored the highest
select name, marks from student where marks = (select max(marks) from student);
-- Result: Priya with 92 marks
```

## Advanced Database Example

### Department_C and Student_C Tables
```sql
-- Create Department_C table
create table Department_C(
    DeptID Int primary key,
    DeptName varchar(20)
);

-- Create Student_C table with foreign key
create table Student_C(
    StudentID int primary key, 
    Name varchar(20), 
    Age int, 
    Gender varchar(1), 
    DeptID int,
    foreign key (DeptId) References Department_C (DeptId)
);

-- Insert department data
insert into Department_C values 
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mechanical');

-- Insert student data
insert into Student_C values
(101, 'Alice', 19, 'F', 1),
(102, 'Bob', 20, 'M', 1),
(103, 'Charlie', 22, 'M', 2),
(104, 'Diana', 18, 'F', 3),
(105, 'Eve', 21, 'F', 1);
```

### Practice Questions with Solutions
```sql
-- Question 3: Update the age of student with StudentID = 102 to 21
update Student_C set age = 21 where studentid = 102;

-- Question 4: Delete the student record whose StudentID is 105
delete from student_c where studentid = 105;

-- Question 5: Display names of all students whose age is greater than 20
select name from student_c where age > 20;

-- Question 6: Display the total number of students in each department
select deptid, count(*) from student_c group by deptid;

-- Question 7: Display department names where total students >= 2 (using subquery)
SELECT DeptName 
FROM Department_C
WHERE DeptID IN (
    SELECT DeptID
    FROM Student_C
    GROUP BY DeptID
    HAVING COUNT(StudentID) >= 2
);

-- Question 7: Alternative solution using JOIN
SELECT d.DeptName, COUNT(s.StudentID) AS Total_Students
FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName
HAVING COUNT(s.StudentID) >= 2;

-- Question 8: Display all student names in ascending order
select * from student_c order by name asc;

-- Question 9: Display each DeptID and minimum age of students in that department
select deptid, min(age) from student_c group by deptid;

-- Question 10: Display department name with average age of students (3 methods)
-- Method 1: Basic GROUP BY (shows DeptID only)
SELECT DeptID, AVG(Age) AS Avg_Age
FROM Student_c 
GROUP BY DeptID;

-- Method 2: Using correlated subquery
SELECT DeptName,
    (SELECT AVG(Age)
        FROM Student_c s
        WHERE s.DeptID = d.DeptID) AS Avg_Age
FROM Department_c d;

-- Method 3: Using JOIN (recommended)
SELECT d.DeptName, AVG(s.Age) AS Avg_Age
FROM Department_c d
JOIN Student_c s ON d.DeptID = s.DeptID
GROUP BY d.DeptName;

-- Question 11: Count male and female students in each department
-- Method 1: Group by DeptID and Gender
SELECT DeptID, Gender, COUNT(*) AS Total
FROM Student_C
GROUP BY DeptID, Gender;

-- Method 2: Group by DeptName and Gender (using JOIN)
SELECT d.DeptName, s.Gender, COUNT(*) AS Total
FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName, s.Gender;

-- Question 12: Display departments where maximum age of students > 21 (2 methods)
-- Method 1: Using JOIN with HAVING
SELECT d.DeptName FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName
HAVING MAX(s.Age) > 21;

-- Method 2: Using subquery
SELECT DeptName
FROM Department_C d
WHERE (
    SELECT MAX(Age)
    FROM Student_C s
    WHERE s.DeptID = d.DeptID
) > 21;

-- Question 13: Display total number of students in the entire college
SELECT COUNT(*) AS Total_Students FROM Student_C;
```

## Supplier-Product Database Example

### Table Creation
```sql
-- Create supplier master table
CREATE TABLE supplier_master (
    SupplierID INT PRIMARY KEY,                      -- unique ID for each supplier
    SupplierName VARCHAR(50) NOT NULL,               -- supplier's name
    SupplierCity VARCHAR(30),                        -- supplier's city
    SupplierEmailID VARCHAR(100) UNIQUE,             -- unique email
    SupplierContact VARCHAR(15)                      -- phone number
);

-- Create product master table
CREATE TABLE Product_master (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    ProductDescription VARCHAR(100),
    ProductQuantity INT,
    ProductCost DECIMAL(10,2)
);

-- Create complaint information table
CREATE TABLE complain_info (
    SupplierID INT,
    ProductID INT,
    ComplainDescription VARCHAR(100),
    ComplainDate DATE,
    ComplainStatus VARCHAR(20),
    FOREIGN KEY (SupplierID) REFERENCES Supplier_master(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Product_master(ProductID)
);
```

### Sample Data Insertion
```sql
-- Insert supplier data
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

-- Insert product data
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
```

---

## Raw SQL Practice Queries (Complete Set)

### Department-Employee-Project Database Setup
```sql
-- Create Department table with primary key
create table Department(
    DeptId int primary key,
    DeptName varchar(20),
    Location varchar(20)
);

-- Insert sample department data
insert into Department (DeptId , DeptName , Location) values 
(1,"HR" , "Delhi"),
(2,"Finance" , "Mumbai"),
(3,"IT" , "Bangalore"),
(4,"Marketing" , "Puna");

-- Display all departments
select * from Department;

-- Create Employee table with foreign key reference to Department
create table Employee(
    EmpId INT primary key,
    EmpName varchar(20) not null,
    Gender char(1),
    City varchar(20),
    Salary decimal(10,2),
    DeptId int,
    foreign key (DeptId) references Department (DeptId)
);

-- Insert employee data
insert into Employee (EmpId , EmpName , Gender,City,Salary,DeptId) values 
(101, 'Asha', 'F', 'Delhi', 45000, 1),
(102, 'Raj', 'M', 'Mumbai', 60000, 2),
(103, 'Neha', 'F', 'Bangalore', 55000, 3),
(104, 'Karan', 'M', 'Pune', 30000, 4),
(105, 'Meena', 'F', 'Bangalore', 70000, 3),
(106, 'Vikram', 'M', 'Delhi', 40000, 1);

-- Display all employees
select * from Employee;

-- Create Project table linked to departments
create table Project (
    ProjectID VARCHAR(5) PRIMARY KEY,
    ProjectName VARCHAR(30) NOT NULL,
    DeptID INT,
    Budget DECIMAL(12,2),
    foreign key (DeptId) references Department (DeptId)
);

-- Insert project data
insert into Project (ProjectId , ProjectName ,DeptId ,Budget) values
('P1', 'Recruit System', 1, 250000),
('P2', 'Audit Tool', 2, 300000),
('P3', 'ERP System', 3, 600000),
('P4', 'Ad Campaign', 4, 150000);

-- Display all projects
select * from Project;
```

### DDL Operations (Data Definition Language)
```sql
-- Add new column Email to Employee table
Alter table Employee Add column Email varchar(50);

-- Modify salary column to allow larger values
Alter table Employee Modify column salary decimal(12,2);

-- Drop the gender column from Employee table
Alter table employee drop column gender;
```

### DML Operations (Data Manipulation Language)
```sql
-- Give 10% salary raise to IT department employees
update employee set salary = salary * 1.10 where DeptId = 3;

-- Update Karan's city to Hyderabad
update employee set city = 'Hyderabad' where EmpName = 'Karan';

-- Delete employee with ID 106 (Vikram)
delete from employee where empid = 106;
```

### Basic Query Examples
```sql
-- Find all employees working in Bangalore
select * from employee where city = 'Bangalore';

-- Find employees with salary between 40,000 and 60,000 (using comparison operators)
select * from employee where salary >=40000 and salary <= 60000;

-- Find employees with salary between 40,000 and 60,000 (using BETWEEN)
select * from employee where salary between 40000 and 60000;

-- Find employees whose name starts with 'N'
select * from employee where empname like 'N%';

-- Find employees NOT working in Delhi (using NOT operator)
select * from employee where not city = 'Delhi'; --Not Delhi

-- Find employees NOT working in Delhi (using <> operator)  
select * from employee where city <> 'Delhi'; --Not Delhi

-- Find projects with budget greater than 200,000
select * from project where budget > 200000;

-- Find employees working in departments 1 or 3 (HR or IT)
select * from employee where deptId in(1 , 3);

-- Find employees NOT working in Mumbai or Pune
select * from employee where city not in('Mumbai' , 'Pune');

-- Find employees with salary NOT greater than 50,000 (salary <= 50,000)
select * from employee where not salary > 50000;
```

### Aggregate Functions and GROUP BY
```sql
-- Calculate total salary expenditure by department
select deptid , sum(salary) as TotalSalary from employee group by DeptId;

-- Calculate average salary by department
select deptid , avg(salary) as AverageSalary from employee group by DeptId;

-- Show departments with average salary > 50,000 (using HAVING with alias)
select deptid , avg(salary) as AverageSalary from employee group by DeptId having AverageSalary  > 50000;

-- Show departments with average salary > 50,000 (using HAVING with function)
select deptid , avg(salary) as AverageSalary from employee group by DeptId having avg(salary) > 50000;

-- Count number of employees in each city
select city,count(city) as NumberOfEmployee from employee group by city;
```

### Sorting and Limiting Results
```sql
-- Show all employees sorted by salary (highest first)
select * from employee order by salary desc;

-- Show top 2 highest paid employees
select * from employee order by salary desc Limit 2;

-- Sort by department first (ascending), then by salary (descending)
select * from employee order by DeptId asc , salary desc;
```

### Subqueries
```sql
-- Display employees earning more than the average salary of all employees.
SELECT * FROM Employee WHERE Salary > (SELECT AVG(Salary) FROM Employee);

-- Find employees working on the same department as 'Neha'.
SELECT * FROM Employee 
WHERE DeptID = (SELECT DeptID FROM Employee WHERE EmpName = 'Neha');
```

### Views
```sql
-- Create a view for high-paid employees (salary > 55,000)
create view highpaid as select empname , salary , deptid from employee where salary > 55000;

-- Query the view to see high-paid employees
select * from highpaid;
```

### Student Database Practice
```sql
-- Create student table for practice queries
create table student (
    student_id int primary key,
    name varchar(8),
    department varchar(4),
    marks int(3),
    city varchar(10)
);

-- Insert student data
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
/*
+----------+
| count(*) |
+----------+
|        8 |
+----------+
*/

-- 2 Find the average marks of all student.
select avg(marks) from student;
/*
+------------+
| avg(marks) |
+------------+
|    79.5000 |
+------------+
*/

-- 3 Find the highest and lowest marks.
select max(marks) as highest_marks , min(marks) as lowest_marks from student;
/*
+---------------+--------------+
| highest_marks | lowest_marks |
+---------------+--------------+
|            92 |           66 |
+---------------+--------------+
*/

-- 4 Display total marks obtained by students from the IT department.
select marks from student where department="IT";
/*
+-------+
| marks |
+-------+
|    75 |
|    89 |
|    73 |
+-------+
*/

-- 5 Count students from each department.
select count(*) from student group by department;
/*
+----------+
| count(*) |
+----------+
|        3 |
|        2 |
|        3 |
+----------+
*/

-- 6 Find the department-wise average marks.
select avg(marks) from student group by department;
/*
+------------+
| avg(marks) |
+------------+
|    84.0000 |
|    73.5000 |
|    79.0000 |
+------------+
*/

-- 7 List departments having more than 2 student.
select department from student group by department having count(*) > 2;
/*
+------------+
| department |
+------------+
| CS         |
| IT         |
+------------+
*/

-- 8 Show the number of students in each city.
select count(*) from student group by city;
/*
+----------+
| count(*) |
+----------+
|        3 |
|        2 |
|        1 |
|        2 |
+----------+
*/

-- 9 Find the total and average marks of CS student.
select sum(marks) as total , avg(marks) as average from student where department="CS";
/*
+-------+---------+
| total | average |
+-------+---------+
|   252 | 84.0000 |
+-------+---------+
*/

-- 10 Display name and marks of student(s) who scored the highest.
select name , marks from student where marks = (select max(marks) from student);
/*
+-------+-------+
| name  | marks |
+-------+-------+
| Priya |    92 |
+-------+-------+
*/
```

### Advanced Database Example (Department_C and Student_C)
```sql
-- Create Department_C table
create table Department_C(
    DeptID Int primary key,
    DeptName varchar(20)
);

-- Create Student_C table with foreign key
create table Student_C(
    StudentID int primary key, 
    Name varchar(20), 
    Age int, 
    Gender varchar(1), 
    DeptID int,
    foreign key (DeptId) References Department_C (DeptId)
);

-- Insert department data
insert into Department_C values 
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mechanical');

-- Insert student data
insert into Student_C values
(101, 'Alice', 19, 'F', 1),
(102, 'Bob', 20, 'M', 1),
(103, 'Charlie', 22, 'M', 2),
(104, 'Diana', 18, 'F', 3),
(105, 'Eve', 21, 'F', 1);

-- 3. Write a query to update the age of the student with StudentID = 102 to 21.
update Student_C set age = 21 where studentid = 102;

-- 4. Write a query to delete the student record whose StudentID is 105.
delete from student_c where studentid = 105;

-- 5. Write a query to display the names of all students whose age is greater than 20.
select name from student_c where age > 20;

-- 6. Write a query to display the total number of students in each department.
select deptid , count(*) from student_c group by deptid;

-- 7. Write a query to display the department names where the total number of students is more than 2.
SELECT DeptName 
FROM Department_C
WHERE DeptID IN (
    SELECT DeptID
    FROM Student_C
    GROUP BY DeptID
    HAVING COUNT(StudentID) >= 2
);

-- Alternative solution using JOIN
SELECT d.DeptName, COUNT(s.StudentID) AS Total_Students
FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName
HAVING COUNT(s.StudentID) >= 2;

-- 8. Write a query to display all student names in ascending order.
select * from student_c order by name asc;

-- 9. Write a query to display each DeptID and the minimum age of students in that department.
select deptid , min(age) from student_c group by deptid;

-- 10. Write a query to display each department name along with the average age of its students.
-- Method 1: Basic GROUP BY (shows DeptID only)
SELECT DeptID, AVG(Age) AS Avg_Age
FROM Student_c 
GROUP BY DeptID;

-- Method 2: Using correlated subquery
SELECT DeptName,
    (SELECT AVG(Age)
        FROM Student_c s
        WHERE s.DeptID = d.DeptID) AS Avg_Age
FROM Department_c d;

-- Method 3: Using JOIN (recommended)
SELECT d.DeptName, AVG(s.Age) AS Avg_Age
FROM Department_c d
JOIN Student_c s ON d.DeptID = s.DeptID
GROUP BY d.DeptName;

-- 11. Write a query to count how many male and female students are in each department.
-- Method 1: Group by DeptID and Gender
SELECT DeptID, Gender, COUNT(*) AS Total
FROM Student_C
GROUP BY DeptID, Gender;

-- Method 2: Group by DeptName and Gender (using JOIN)
SELECT d.DeptName, s.Gender, COUNT(*) AS Total
FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName, s.Gender;

-- 12. Write a query to display departments where the maximum age of students is more than 21.
-- Method 1: Using JOIN with HAVING
SELECT d.DeptName FROM Department_C d
JOIN Student_C s ON d.DeptID = s.DeptID
GROUP BY d.DeptName
HAVING MAX(s.Age) > 21;

-- Method 2: Using subquery
SELECT DeptName
FROM Department_C d
WHERE (
    SELECT MAX(Age)
    FROM Student_C s
    WHERE s.DeptID = d.DeptID
) > 21;

-- 13. Write a query to display the total number of students in the entire college.
SELECT COUNT(*) AS Total_Students FROM Student_C;
```

### Supplier-Product-Complaint Database
```sql
-- Create supplier master table
CREATE TABLE supplier_master (
    SupplierID INT PRIMARY KEY,                      -- unique ID for each supplier
    SupplierName VARCHAR(50) NOT NULL,               -- supplier's name
    SupplierCity VARCHAR(30),                        -- supplier's city
    SupplierEmailID VARCHAR(100) UNIQUE,             -- unique email
    SupplierContact VARCHAR(15)                      -- phone number
);

-- Create product master table
CREATE TABLE Product_master (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    ProductDescription VARCHAR(100),
    ProductQuantity INT,
    ProductCost DECIMAL(10,2)
);

-- Create complaint information table
CREATE TABLE complain_info (
    SupplierID INT,
    ProductID INT,
    ComplainDescription VARCHAR(100),
    ComplainDate DATE,
    ComplainStatus VARCHAR(20),
    FOREIGN KEY (SupplierID) REFERENCES Supplier_master(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Product_master(ProductID)
);

-- Insert supplier data
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

-- Insert product data
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

-- Insert complaint data
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

-- Display all data
SELECT * FROM supplier_master;
SELECT * FROM Product_master;
SELECT * FROM complain_info;

-- Q-2 Supplier name has 5 characters, starting & ending with 'h'
select * from supplier_master where SupplierName like 'h___h';

-- Q-3 Minimum product cost
select min(productcost) from Product_master;

-- Q-4 Add new column S_Age to Supplier master
alter table supplier_master add column S_Age int;

-- Q-5 Position of 'e' in "Hello Data"
select INSTR('Hello Data', 'e');

-- Q-6 Product details with cost > 20000
select * from Product_master where productcost > 20000;

-- Q-7 Complains with status 'pending' or 'waiting'
select * from complain_info where complainstatus in('pending', 'waiting');

-- Q-8 Month from date '2007-03-03'
SELECT MONTH('2007-03-03') AS MonthNumber;
SELECT MONTHNAME('2007-03-03');

-- Q-9 Rename complain_info to complain_details
rename table complain_info to complain_details;

-- Q-10 Absolute value of -233.5
SELECT ABS(-233.5) AS AbsoluteValue;

-- Q-11 Update productname size to 40
alter table Product_master modify column productname varchar(40);

-- Q-12 Records where description starts with 'dis'
select * from complain_details where complaindescription like 'dis%';
```

### Medical Database (Patient-Doctor-Appointment System)
```sql
-- Create Patient table
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(50) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M','F')),
    City VARCHAR(30),
    Age INT CHECK (Age >= 0),
    ContactNo VARCHAR(15) UNIQUE
);

-- Create Doctor table
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(30),
    City VARCHAR(30),
    Fee DECIMAL(10,2)
);

-- Create Appointment table
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

-- Create Medicine table
CREATE TABLE Medicine (
    MedicineID INT PRIMARY KEY,
    MedicineName VARCHAR(40),
    Price DECIMAL(10,2),
    Stock INT
);

-- Create Prescription table
CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY,
    AppointmentID INT,
    MedicineID INT,
    Quantity INT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
    FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID)
);

-- Insert sample data
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

-- Display all data
select * from Patient;
select * from Doctor;
select * from Appointment;
select * from Medicine;
select * from Prescription;

-- Practice Questions and Solutions:

-- 1️⃣ Display all patients from "Delhi" or "Mumbai".
select * from patient where City in('Delhi', 'Mumbai');

-- 2️⃣ Find doctors whose consultation fee is more than ₹1000.
select * from Doctor where Fee > 1000;

-- 3️⃣ Display patients whose name starts with 'R'.
select * from Patient where PatientName like 'R%';

-- 4️⃣ Show all appointments with bill amount between ₹1000 and ₹2500.
select * from Appointment where BillAmount between 1000 and 2500;

-- 5️⃣ List doctors not from "Mumbai" and "Chennai".
select * from doctor where city not in('Mumbai', 'Chennai');

-- 6️⃣ Display total appointments for each doctor.
-- Method 1: Using JOIN
SELECT 
    d.DoctorName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM 
    doctor d, appointment a
WHERE 
    d.DoctorID = a.DoctorID
GROUP BY 
    d.DoctorName;

-- Method 2: Simple grouping
select DoctorId, count(*) from appointment group by doctorid;

-- 7️⃣ Display doctors having average bill amount > ₹2000.
-- Method 1: Simple filter
select doctorid from Appointment where BillAmount > 2000;

-- Method 2: With doctor names
SELECT 
    d.DoctorName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM 
    doctor d, appointment a
WHERE 
    d.DoctorID = a.DoctorID and a.BillAmount > 2000
GROUP BY 
    d.DoctorName;

-- 8️⃣ Show total stock value of all medicines.
select sum(Price * Stock) from medicine;

-- 9️⃣ Display patients ordered by city (A–Z).
select * from patient order by city;

-- 🔟 Show medicines sorted by price (highest first).
select * from medicine order by price desc;

-- 11️⃣ Display patients who have spent more than the average bill amount.
-- Method 1: Using subquery
select p.PatientID,
    p.PatientName,
    a.AppointmentID,
    a.BillAmount from patient as p, appointment a  where a.BillAmount > (select avg(BillAmount) from appointment);

-- Method 2: Alternative syntax
SELECT 
    p.PatientID,
    p.PatientName,
    a.AppointmentID,
    a.BillAmount 
FROM 
    patient p, appointment a  
WHERE 
    a.BillAmount > (SELECT AVG(BillAmount) FROM appointment);

-- 12️⃣ Find doctors who treated the same patient as "Riya".
SELECT DoctorID FROM Appointment
WHERE PatientID IN (SELECT PatientID FROM Patient WHERE PatientName='Riya');
```

## Notes
- All queries are formatted with proper explanations
- Results are included where provided in original file
- Multiple solution methods are shown for complex queries
- Foreign key relationships are properly documented
- Comments explain the purpose of each operation