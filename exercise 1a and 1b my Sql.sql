-- every sql query - table specific and database specific
-- relational database management system - actual db
-- mysql,microsoft sql server, sqllite, oracle, postgre

drop database if exists School;
create database School;

use School;

create table Students (
FirstName varchar(50),
LastName varchar(50),
Student_Id int,
age int);

describe Students;

insert into Students (FirstName,LastName,Student_Id,age) values
('Jane','Doe',001,20);

insert into Students (FirstName,LastName,Student_Id,age) values
('John','Doe',002,22);


insert into Students (FirstName,LastName,Student_Id,age) values
('Michael','Dunn',003,24),
('Grace','Michell',004,21);

select * from Students;
select FirstName,LastName from Students;

-- add a new column
alter table Students
add column Subject varchar(100);

-- set sql_safe_updates = 0;

update Students
set Subject = 'Math'
where Student_Id = 2;

-- deleting a record
delete from Students
where Subject = 'Math';

-- dropping a table
drop table Students;

-- create database school
-- create table Students, firstname,stud_id,age
-- insert 4 students
-- add a column to the table Students, Subject
-- Update 2 records with a subject
-- drop a column from the table, Subject

create table Students (
StudentID int auto_increment,
FirstName varchar(50) not null,
LastName varchar(50) not null,
BirthDate Date,
Primary Key (StudentID)
);

CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    PRIMARY KEY (CourseID),
    CONSTRAINT CHK_Credits CHECK (Credits > 0)
);

CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE NOT NULL,
    PRIMARY KEY (EnrollmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE SET NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    UNIQUE (StudentID, CourseID)
);

INSERT INTO Students (FirstName, LastName, BirthDate) VALUES
('John', 'Doe', '2000-01-15'),
('Jane', 'Smith', '1999-11-30'),
('Michael', 'Brown', '2001-06-22');

INSERT INTO Courses (CourseName, Credits) VALUES
('Mathematics', 3),
('Science', 4),
('History', 2);

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-02-12'),
(3, 3, '2024-03-15');


select * from Students;
select * from Courses;
select * from Enrollments;

-- Primary Key constraint
insert into Students (StudentID, FirstName, LastName, BirthDate) values
(1,'Alice','Johnson','1998-05-05');

-- Check constraints
INSERT INTO Courses (CourseName, Credits) 
VALUES ('Invalid Course', -1);

-- Foreign Key Constraint
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) 
VALUES (4, 1, '2024-04-01');

-- Constraint
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) 
VALUES (1, 1, '2024-01-11');

-- On Delete Cascade
DELETE FROM Students WHERE StudentID = 1;

alter table Courses
add column Description varchar(255) default 'No Description';

insert into Courses (CourseName,Credits) values
('Arts',20);

insert into Courses (CourseName,Credits,Description) values
('Optics',20,'An intro to Optics');
drop database if exists SalesDB;
CREATE DATABASE SalesDB;
USE SalesDB;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ProductID)
);

CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    PRIMARY KEY (SaleID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Insert data into Customers
INSERT INTO Customers (FirstName, LastName, Email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Michael', 'Brown', 'michael.brown@example.com');

-- Insert data into Products
INSERT INTO Products (ProductName, Price) VALUES
('Laptop', 1200.00),
('Smartphone', 800.00),
('Tablet', 300.00);

-- Insert data into Sales
INSERT INTO Sales (CustomerID, ProductID, SaleDate, Quantity) VALUES
(1, 1, '2024-05-01', 1),
(1, 2, '2024-05-03', 2),
(2, 1, '2024-05-04', 1),
(2, 3, '2024-05-05', 1),
(3, 2, '2024-05-06', 3),
(3, 3, '2024-05-07', 2);

select * from Customers;
select * from Products;
select * from Sales;

-- avg quantity
select avg(Quantity) as Average_Quantity from Sales;

-- count of sales (how many sales)
select count(*) as No_of_Sales from Sales;

-- max quantity
select min(Quantity) as Min_Qty from Sales;

-- total sales
select Sales.Quantity,Products.Price,(Sales.Quantity * Products.Price)
from Sales 
join Products on Sales.ProductID = Products.ProductID;
select sum(Quantity * Price) as Tot_Sales
from Sales 
join Products on Sales.ProductID = Products.ProductID;

drop database if exists datasciencedb;
CREATE DATABASE DataScienceDB;
USE DataScienceDB;

-- Create tables
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Insert data
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID) VALUES
(1, 'John', 'Doe', 1),
(2, 'Jane', 'Smith', 2),
(3, 'Sam', 'Brown', 3),
(4, 'Lisa', 'Ray', 2);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(4, 'Finance');

select * from Employees;
select * from Departments;

-- inner join
select Employees.EmployeeID, Employees.FirstName,Employees.LastName,Departments.DepartmentName,Departments.DepartmentID
from Employees
right join Departments
on Employees.DepartmentID = Departments.DepartmentID;

-- SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName,Departments.DepartmentID,Employees.DepartmentID
-- FROM Employees
-- LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
-- UNION
-- SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName,Departments.DepartmentID,Employees.DepartmentID
-- FROM Departments
-- LEFT JOIN Employees ON Departments.DepartmentID = Employees.DepartmentID;
Use salesdb;

-- Calculate the average quantity
Select* from sales;
select avg(Quantity) as Average_Quantity from Sales;
-- Calculate the number of sales made
-- count of sales (how many sales)
select count(*) as No_of_Sales from Sales;
-- Calculate the maximum quantity sold
select max(Quantity) as Max_Qty from Sales;
-- Calculate the minimum quantity sold
select min(Quantity) as Min_Qty from Sales;
-- Calculate the total sales made
select Sales.Quantity,Products.Price,(Sales.Quantity * Products.Price)
from Sales 
join Products on Sales.ProductID = Products.ProductID;
select sum(Quantity * Price) as Tot_Sales
from Sales 
join Products on Sales.ProductID = Products.ProductID;
-- Calculate the Total Sales Amount by Customer
Select * from Customers;
Select * from Sales;
Select * from products;
SELECT CustomerID, SUM(Quantity) AS TotalSalesAmount
FROM Sales
GROUP BY CustomerID;
-- Calculate the Total Quantity Sold by Product
Select * from sales;
Select * from products;
SELECT Products.ProductID, SUM(Quantity) AS TotalQuantitySold
FROM Products
JOIN sales
On Products.ProductID=Sales.ProductID
GROUP BY ProductID;
-- Calculate the Average Quantity Sold per Customer
Select * from customers;
Select * from Sales;
SELECT Customers.CustomerID, AVG(Quantity) AS AvgQuantitySoldPerCustomer
FROM Customers
Join sales
on Customers.CustomerID=Sales.CustomerID
GROUP BY CustomerID;


-- Customers with Total Sales Amount Greater Than $1500
Select *from sales;
select*from customers;
Select * from products;
SELECT Customers.CustomerID, SUM(quantity*price) AS TotalSalesAmount
FROM Customers
join Sales
on Customers.CustomerID=Sales.CustomerID
Join Products
on Sales.productID=Products.ProductID
Group  by customerID
HAVING TotalSalesAmount > 1500;