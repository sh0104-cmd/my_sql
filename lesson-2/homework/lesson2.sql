--BASIC-LEVEL TASKS (10)
--Create a database Employees
CREATE DATABASE Employees;

-- Create Employees table

CREATE TABLE Employees (
EmpID int,
Name varchar(50),
Salary decimal(10,2)
);

--Insert values into table
INSERT INTO Employees (
EmpID, Name, Salary) VALUES 
(1, 'Shahnoza', 10500);


INSERT INTO Employees (
EmpID, Name, Salary) VALUES 
(2, 'Shaxlo', 10100),
(3, 'Aziz', 12300),
(4, 'Akmal', 11900),
(5, 'Said', 13200);

--Update the Salary where EmpID=1 
UPDATE Employees SET Salary=17000 WHERE EmpID=1;


--Delete a record from the table where EmpID=2
DELETE FROM Employees WHERE EmpID=2;

--Create a Test table to demonstrate the difference between DELETE, TRUNCATE and DROP

CREATE TABLE Test(
StudentID int,
StudentName char(20),
StudentMark decimal(10,2)
);
SELECT * FROM Test;
INSERT INTO Test ( StudentID,StudentName,StudentMark) VALUES 
(1,'John',73);

INSERT INTO Test ( StudentID,StudentName,StudentMark) VALUES 
(2,'Ali',76);

--Delete a row from a table where StudentID=1
DELETE FROM Test WHERE StudentID=1;

--Truncate the table, it will clear all the records of the table without deleting its structure
TRUNCATE TABLE Test;

--Drop the table, it will delete the whole table
DROP TABLE Test;

--Modify Name column in the Employees Table to VARCHAR(100)
EXEC sp_rename 
'Employees.Name','VARCHAR(100)',
'COLUMN';


--Add a new column Department (VARCHAR(50)) to the Employees table.
ALTER TABLE Employees
ADD Department varchar(50);


--Change the data type of the Salary column to FLOAT.
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

/*Create another table Departments with columns 
DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).*/
CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50));
S

--Remove all records from the Employees table without deleting its structure.
TRUNCATE TABLE Employees;


--INTERMEDIATE-LEVEL TASKS (6)
--Insert records into table Employees
INSERT INTO Employees (
EmpID,"VARCHAR(100)",Salary,Department) VALUES 
(1, 'John',5700,'HR'),
(2, 'Leslie',4700,'Production'),
(3, 'Ann',6200,'Accounting');


--Insert five records into the Departments table using INSERT INTO SELECT from an existing table.
INSERT INTO Departments(DepartmentID,DepartmentName)
SELECT EmpID, Department FROM Employees;


--Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees SET Department='Management' WHERE Salary>5000;

--Write a query that removes all employees but keeps the table structure intact.
TRUNCATE TABLE Employees;

--Drop the Department column from the Employees table.
ALTER TABLE Employees
DROP COLUMN Department;


--Rename the Employees table to StaffMembers using SQL commands.
Exec sp_rename 'Employees', 'StaffMembers';
SELECT * FROM StaffMembers;

--Write a query to completely remove the Departments table from the database.
DROP TABLE Departments;

--ADVANCED-LEVEL TASKS (9)
/*Create a table named Products with at least 5 columns, including: 
ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
*/
CREATE TABLE Products (
 ProductID INT Primary Key, ProductName VARCHAR(50), Category VARCHAR(50), Price DECIMAL(10,2)
 );
 --Add a CHECK constraint to ensure Price is always greater than 0.
 ALTER TABLE Products
 ADD CHECK (Price>0);
 SELECT * FROM Products;
 
 --Modify the table to add a StockQuantity column with a DEFAULT value of 50.

 ALTER TABLE Products
 ADD StockQuantity Int DEFAULT 50;


 --Rename Category to ProductCategory
Exec sp_rename 'Products.Category','ProductCategory','COLUMN';


--Insert 5 records into the Products table using standard INSERT INTO queries.
INSERT INTO Products (ProductID,ProductName,ProductCategory,Price,StockQuantity) VALUES 
(1,'Apple','Fruit',10,50),
(2,'Mango','Fruit',13,50),
(3,'Flash','Beverage',2,50),
(4,'AppleJuice','Beverage',5,50),
(5,'Coke','Beverage',1,50);
SELECT * FROM Products;

--Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT * INTO Products_Backup
FROM Products;


--Rename the Products table to Inventory.
Exec sp_rename 'Products', 'Inventory';


--Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

--Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5.
ALTER TABLE Inventory
ADD ProductCode Int	IDENTITY(1000,5); 

