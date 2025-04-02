--Define and explain the purpose of BULK INSERT in SQL Server.
--The BULK INSERT task provides an efficient way to copy large amounts of data from a data file into a SQL Server table or view.

--List four file formats that can be imported into SQL Server.
/*Here are four common file formats that can be imported into SQL Server:
CSV (Comma-Separated Values)
TXT (Text File)
Excel (XLSX/XLS) 
JSON (JavaScript Object Notation)*/

--Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10,2));

--Insert three records into the Products table using INSERT INTO.
INSERT INTO Products (ProductID,ProductName,Price) VALUES 
(1,'Laptop',800),
(2,'Iwatch',200),
(3,'Iphone',900);

--Explain the difference between NULL and NOT NULL with examples.
/*In SQL, NULL and NOT NULL are used to define 
whether a column in a database table can accept null values (i.e., no value) or must have a value.*/
/* NULL represents the absence of a value or an unknown value. It is not equivalent to zero or an empty string; it simply means "no value."*/
--Example of NULL
CREATE TABLE Employees1 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    MiddleName VARCHAR(50) NULL  -- This column can accept NULL values
);

-- This will work because MiddleName can be NULL
INSERT INTO Employees (EmployeeID, FirstName, LastName, MiddleName)
VALUES (1, 'John', 'Doe', NULL);
-- NOT NULL specifies that a column must always contain a value. It cannot be left empty or set to NULL.
--Example
CREATE TABLE Employees2 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,  -- This column must have a value
    LastName VARCHAR(50) NOT NULL,   -- This column must have a value
    MiddleName VARCHAR(50) NULL       -- This column can accept NULL values
);
-- This will fail because FirstName cannot be NULL
INSERT INTO Employees2 (EmployeeID, FirstName, LastName)
VALUES (2, NULL, 'Smith');  -- Error: Cannot insert the value NULL into column 'FirstName'

--Add a UNIQUE constraint to the ProductName column in the Products table.
ALTER TABLE Products
ADD UNIQUE (ProductName);

--Write a comment in a SQL query explaining its purpose.
-- The following table definition creates a Customers table
-- with a UNIQUE constraint on the Email column to ensure that 
-- no two customers can have the same email address.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,  -- Ensures each email address is unique across all records
    Phone VARCHAR(15)
);
--Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE Categories (
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR(50) UNIQUE
);

--Explain the purpose of the IDENTITY column in SQL Server.
/*In SQL Server, an IDENTITY column is used to create a unique identifier for each row in a table.
It automatically generates sequential numeric values for the column, which can be particularly useful for primary keys. */

--MEDIUM-LEVEL TASKS (10)
--Use BULK INSERT to import data from a text file into the Products table.
BULK INSERT [dbo].[Products]
FROM 'C:\Users\user\Documents\SQL Server Management Studio\Book1.txt'
WITH 
(
	firstrow = 2, 
	rowterminator = '\n',
	fieldterminator = '	'
);
SELECT * FROM Products;

--Create a FOREIGN KEY in the Products table that references the Categories table.

ALTER TABLE Products
ADD CategoryID INT FOREIGN KEY REFERENCES Categories (CategoryID);

--Explain the differences between PRIMARY KEY and UNIQUE KEY with examples.

/*In relational databases, both PRIMARY KEY and UNIQUE KEY are used to enforce uniqueness of values in a column or a set of columns. 
However, there are key differences between them:

1. Definition

PRIMARY KEY: A primary key is a column (or a combination of columns) that uniquely identifies each row in a table. Each table can have only one primary key, and it cannot contain NULL values.
UNIQUE KEY: A unique key is a constraint that ensures all values in a column (or a combination of columns) are unique across the table. 
Unlike primary keys, a table can have multiple unique keys, and they can accept NULL values (but only one NULL per unique column).

2. NULL Values

PRIMARY KEY: Cannot contain NULL values. Every row must have a valid value for the primary key.
UNIQUE KEY: Can contain NULL values. However, if the unique key column allows NULLs, only one NULL value is permitted in that column.

3. Number of Keys

PRIMARY KEY: A table can have only one primary key.
UNIQUE KEY: A table can have multiple unique keys.

4. Purpose

PRIMARY KEY: Primarily used to uniquely identify records in the table.
UNIQUE KEY: Used to enforce uniqueness for a column or a combination of columns that are not the primary identifier for the table.*/

--Example of a PRIMARY KEY

CREATE TABLE Employees3 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

--In this example:

--EmployeeID is the primary key, which means each employee must have a unique EmployeeID, and it cannot be NULL.

--Example of a UNIQUE KEY

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
    Email VARCHAR(100) UNIQUE
);

--In this example:

--UserID is the primary key.

/* Username and Email are unique keys. This means that each username and email must be unique across the table, 
but they can accept NULL values (if not explicitly set to NOT NULL).*/

--Add a CHECK constraint to the Products table ensuring Price > 0.
ALTER TABLE Products
ADD CHECK (Price>0);

--Modify the Products table to add a column Stock (INT, NOT NULL).

ALTER TABLE Products
ADD Stock int NOT NULL DEFAULT 0;

--Use the ISNULL function to replace NULL values in a column with a default value.
SELECT * FROM Products;
--Replacing NULL Values in a CategoryID column

INSERT INTO Categories (CategoryID) VALUES 
(1);
SELECT * FROM Categories;
UPDATE Categories
SET CategoryName = 0
WHERE CategoryName IS NULL;

--Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
/*A FOREIGN KEY constraint in SQL Server is a fundamental concept in relational database design that helps maintain data integrity and establish relationships between tables. 

Purpose of FOREIGN KEY Constraints:
 - Data Integrity: FOREIGN KEY constraints ensure that the relationship between two tables remains consistent. 
 They enforce referential integrity by making sure that a value in one table (the child table) corresponds to a valid value in another table (the parent table).
 - Relationship Establishment: They define relationships between tables,
 typically representing a one-to-many relationship where one record in the parent table can relate to multiple records in the child table.  
 - Cascading Actions:FOREIGN KEY constraints can be configured 
 to automatically propagate changes made in the parent table to the child table through cascading actions

Usage of FOREIGN KEY Constraints:
 - Creating a FOREIGN KEY Constraint;
 - Adding a FOREIGN KEY Constraint to an Existing Table;
 - Cascading Actions: ON DELETE CASCADE and ON UPDATE CASCADE;
 - Dropping a FOREIGN KEY Constraint */

 --HARD-LEVEL TASKS (10)
 --Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
 CREATE TABLE Customers (
 ID int,
 Age int CHECK (Age>=18)
 );
 --Create a table with an IDENTITY column starting at 100 and incrementing by 10.

 CREATE TABLE IdentityDemo2 (
 PersonID int Identity(100,10),
 PersonName varchar(50)
 );
 INSERT INTO IdentityDemo2 (PersonName) VALUES ('Sarvar');
 SELECT * FROM IdentityDemo2;
 --Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
 CREATE TABLE OrderDetails (
    ClientID INT,
    PurchaseID INT,
    OrderDate DATE,
    PRIMARY KEY (ClientID, PurchaseID)  -- Composite PRIMARY KEY
);

--Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.

/*In SQL, handling NULL values is crucial for ensuring that your queries return meaningful results. 
Two commonly used functions for dealing with NULL values are COALESCE and ISNULL. Below, I’ll explain each function with examples.

1. ISNULL Function

The ISNULL function is used to replace NULL values with a specified replacement value. It takes two arguments: the expression to check for NULL and the value to return if the expression is NULL.

Syntax:

ISNULL(expression, replacement_value)*/


--Example:

--Suppose you have a table named Employees with the following structure:

CREATE TABLE Employees (
    EmployeeID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2) NULL
);


--Now, let's say you want to retrieve the salary of each employee, but if the salary is NULL, you want to display 'Not Specified' instead.

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    ISNULL(Salary, 0) AS Salary -- Replacing NULL with 0
FROM 
    Employees;


--If an employee has a NULL salary, this query will display 0 instead.
/*2. COALESCE Function

The COALESCE function returns the first non-NULL value from a list of expressions. It can take multiple arguments and will evaluate them in order until it finds a non-NULL value.

Syntax:

COALESCE(expression1, expression2, ..., expressionN)


Example:

Using the same Employees table, suppose you want to check for the salary first, and if it is NULL, you want to check another column (for example, a bonus) 
and display that instead. If both are NULL, you want to return 'No Compensation'.*/

--Assuming there is a Bonus column added to the table:

ALTER TABLE Employees ADD Bonus DECIMAL(10, 2) NULL;


--Now you can use COALESCE to handle this situation:

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    COALESCE(Salary, Bonus, 'No Compensation') AS Compensation -- Returns first non-NULL value
FROM 
    Employees;


/*In this case:

 If Salary is not NULL, it will be displayed.

 If Salary is NULL but Bonus has a value, then that value will be displayed.

 If both are NULL, it will return 'No Compensation'.*/

 --Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
 CREATE TABLE Employees (
 EmpID Int PRIMARY KEY,
 Email varchar(100) UNIQUE 
 );

 --Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
 /*To create a foreign key with ON DELETE CASCADE and ON UPDATE CASCADE options in SQL, you first need to have two tables: 
 a parent table (the table that contains the primary key) and a child table (the table that contains the foreign key).*/

 -- Create Parent Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100)
);

-- Create Child Table with Foreign Key
CREATE TABLE TheEmployees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
