create database hw19
use hw19

--TASKS on Stored Procedures and MERGE
--Part 1: Stored Procedure Tasks

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10,2)
);

CREATE TABLE DepartmentBonus (
    Department NVARCHAR(50) PRIMARY KEY,
    BonusPercentage DECIMAL(5,2)
);

INSERT INTO Employees VALUES
(1, 'John', 'Doe', 'Sales', 5000),
(2, 'Jane', 'Smith', 'Sales', 5200),
(3, 'Mike', 'Brown', 'IT', 6000),
(4, 'Anna', 'Taylor', 'HR', 4500);

INSERT INTO DepartmentBonus VALUES
('Sales', 10),
('IT', 15),
('HR', 8);

select * from Employees;
select * from DepartmentBonus
--Creates a temp table #EmployeeBonus
--Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
--(BonusAmount = Salary * BonusPercentage / 100)

CREATE PROCEDURE GetEmployeeBonuses1
AS
begin
    -- Create temp table
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(101),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- Insert data with join between Employees and DepartmentBonus
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 AS BonusAmount
    FROM 
        Employees e
    INNER JOIN 
        DepartmentBonus db ON e.Department = db.Department;

		

    -- Select from the temp table
    SELECT * FROM #EmployeeBonus;
	end;
exec GetEmployeeBonuses1

--Task 2:
--Create a stored procedure that:

--Accepts a department name and an increase percentage as parameters
--Update salary of all employees in the given department by the given percentage
--Returns updated employees from that department.

CREATE PROCEDURE UpdateDepartmentSalaries
    @Department NVARCHAR(50),
    @IncreasePercentage DECIMAL(5,2)
AS
BEGIN
    -- Update salaries
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercentage / 100)
    WHERE Department = @Department;

    -- Return updated employees from the specified department
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        Salary
    FROM Employees
    WHERE Department = @Department;
END;
exec UpdateDepartmentSalaries 'Sales', 10

--Part 2: MERGE Tasks
CREATE TABLE Products_Current (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Products_New (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

INSERT INTO Products_Current VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 600),
(3, 'Smartphone', 800);

INSERT INTO Products_New VALUES
(2, 'Tablet Pro', 700),
(3, 'Smartphone', 850),
(4, 'Smartwatch', 300);

----Task 3:
--Perform a MERGE operation that:

--Updates ProductName and Price if ProductID matches
--Inserts new products if ProductID does not exist
--Deletes products from Products_Current if they are missing in Products_New
--Return the final state of Products_Current after the MERGE.
;merge into Products_current as target
using products_new as Source
on Target.productID = Source.productID
when matched then
	update set
		target.productName = Source.productName,
		target.price = Source.price
when Not Matched by Target then
	insert (productID,productName)
	values (Source.productID,Source.productName)
when Not Matched by Source then
	delete;

	select * from products_current
	select * from products_new

	--Task 4:
--Tree Node

--Each node in the tree can be one of three types:

--"Leaf": if the node is a leaf node.
--"Root": if the node is the root of the tree.
--"Inner": If the node is neither a leaf node nor a root node.
--Write a solution to report the type of each node in the tree.

1  -- root
2  -- innner
3  -- leaf
4  -- leaf
5  -- leaf

SELECT 
    t1.id,
    CASE 
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN t1.id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t1
ORDER BY t1.id;



select * from Tree
CREATE TABLE Tree (id INT, p_id INT);
TRUNCATE TABLE Tree;
INSERT INTO Tree (id, p_id) VALUES (1, NULL);
INSERT INTO Tree (id, p_id) VALUES (2, 1);
INSERT INTO Tree (id, p_id) VALUES (3, 1);
INSERT INTO Tree (id, p_id) VALUES (4, 2);
INSERT INTO Tree (id, p_id) VALUES (5, 2);



--Task 5:
--Confirmation Rate

--Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.

CREATE TABLE Signups (user_id INT, time_stamp DATETIME);
CREATE TABLE Confirmations (user_id INT, time_stamp DATETIME, action varchar(50) );

TRUNCATE TABLE Signups;
INSERT INTO Signups (user_id, time_stamp) VALUES 
(3, '2020-21-03'),
(7, '2020-01-04'),
(2, '2020-29-07'),
(6, '2020-12-09');

TRUNCATE TABLE Confirmations;
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES 
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-14-07 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-13-06 12:58:28', 'confirmed'),
(7, '2021-14-06 13:59:27', 'confirmed'),
(2, '2021-22-01 00:00:00', 'confirmed'),
(2, '2021-28-02 23:59:59', 'timeout');


select S.user_id,isnull(cast(sum(case when action='confirmed' then 1 else 0 end)*1.0/nullif(count(action),0) as decimal(10,2)),0) as rate from Confirmations as C
right join Signups as S on S.user_id = C.user_id
group by S.user_id



--6.Find employees with the lowest salary
CREATE TABLE employees1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO employees1 (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

select * from employees1
where salary in(select min(salary) from employees1)


--Task 7:Get Product Sales Summary
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        P.ProductName,
        SUM(S.Quantity) AS TotalQuantitySold,
        SUM(S.Quantity * P.Price) AS TotalSalesAmount,
        MIN(S.SaleDate) AS FirstSaleDate,
        MAX(S.SaleDate) AS LastSaleDate
    FROM Products P
    LEFT JOIN Sales S ON P.ProductID = S.ProductID
    WHERE P.ProductID = @ProductID
    GROUP BY P.ProductName;
END;
