--select * from employees

--WITH  employee_hierarchy AS (
--    SELECT EMPLOYEE_ID, FIRST_NAME, manager_id, 1 AS level
--    FROM employees
--    WHERE manager_id=0

--    UNION ALL

--    SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.manager_id, eh.level + 1
--    FROM employees e
--    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
--)
--SELECT * FROM employee_hierarchy;
create database hw16
use hw16

CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);


--Easy Tasks
--Create a numbers table using a recursive query from 1 to 1000.

with numbers_table as (
select 1 as n
union all
select n+1 as num from numbers_table
where n+1<=1000
)

select * from numbers_table
option (maxrecursion 1000)

with numbers_table as (
select 2 as n
union all
select n+2 as num from numbers_table
where (n+2)<100
)

select * from numbers_table
option (maxrecursion 1000)

--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select * from Employees;
select * from Sales
select E.employeeid,E.firstName,E.LastName,s.total_sales from Employees as E
join
(select EmployeeID,sum(SalesAmount) as total_sales from sales group by EmployeeID) as S
on E.EmployeeID=S.EmployeeID

--Create a CTE to find the average salary of employees.(Employees)

with avg_salaries as (
select employeeid ,avg(salary) as average_salary from Employees group by EmployeeID
)
select * from avg_salaries

--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select * from sales;
select * from Products

select p.ProductID,s.max_sale from Products as p
join (select productid,max(salesamount) as max_sale from sales group by ProductID) as s
on p.ProductID=s.ProductID

--Beginning at 1, write a statement to double the number for each record, 
--the max value you get should be less than 1000000.
with numbers as (
select 1 as n
union all
select n*2 as doubling_number from numbers
where n*2<1000000
)
select * from numbers

--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)

with best_employees as(
select EmployeeID,count(salesid) as num_of_sales from sales group by EmployeeID having count(salesid)>5
)
select best_employees.employeeid, e.FirstName,e.LastName,best_employees.num_of_sales from best_employees
join employees as e
on e.employeeid=best_employees.employeeid

--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

with best_products as(
select ProductID,sum(SalesAmount) as total_sales from sales
group by productid having sum(salesamount)>500
)
select p.ProductID,p.ProductName,b.total_sales from best_products as b
join Products as p
on p.ProductID=b.ProductID

--Create a CTE to find employees with salaries above the average salary.(Employees)
with above_avg as(
select EmployeeID,firstname,LastName,Salary from Employees
where salary > (select avg(salary) as avg_salary from Employees)
)
select * from above_avg

--Medium Tasks
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select * from Employees;
select * from sales


select top 5 e.EmployeeID,e.FirstName,e.LastName,s.num_of_sales from Employees as e
join (select EmployeeID,count(salesid)as num_of_sales from sales group by Employeeid  ) as s
on s.EmployeeID=e.employeeid
order by s.num_of_sales

--Write a query using a derived table to find the sales per product category.(Sales, Products)

--SELECT FirstName
--FROM Employees e
--WHERE EXISTS (
--    SELECT DepartmentName
--    FROM Departments d
--    WHERE e.DepartmentID = d.DepartmentID
--);
select * from sales
select p.CategoryID,sum(s.nu_of_sales)as total_sales from Products as p
join 
(select ProductID,count(salesid)as nu_of_sales from sales  group by ProductID) as s
on s.ProductID=p.ProductID
group by p.CategoryID

--Write a script to return the factorial of each value next to it.(Numbers1)
with numbers as (
select 1 as n,
 1 as f
union all
select n+1,(n+1)*f from numbers
where n+1<10 
)
select * from numbers
where n in (select number from Numbers1)

1,1
2,2*1
3,3 *2
4,4 *6

--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
select * from Example
-- Recursive CTE to split each string in the Example table into characters
WITH RecursiveSplit AS (
    -- Anchor: start with first character of each string
    SELECT
        Id,
        1 AS Position,
        SUBSTRING(String, 1, 1) AS Character,
        String
    FROM Example
    WHERE LEN(String) > 0

    UNION ALL

    -- Recursive part: get next character
    SELECT
        Id,
        Position + 1,
        SUBSTRING(String, Position + 1, 1),
        String
    FROM RecursiveSplit
    WHERE Position + 1 <= LEN(String)
)

-- Final output: one character per row per string
SELECT
    Id,
    Position,
    Character
FROM RecursiveSplit
ORDER BY Id, Position;

--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
select * from sales

WITH MonthlySales AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesWithDifference AS (
    SELECT 
        SaleMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SaleMonth) AS PreviousMonthSales
    FROM MonthlySales
)
SELECT 
    SaleMonth,
    TotalSales,
    PreviousMonthSales,
    TotalSales - ISNULL(PreviousMonthSales, 0) AS SalesDifference
FROM SalesWithDifference
ORDER BY SaleMonth;


--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
-- Derived table to calculate quarterly sales per employee
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        DATEPART(YEAR, SaleDate) AS SaleYear,
        SUM(SalesAmount) AS QuarterlySales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(YEAR, SaleDate), DATEPART(QUARTER, SaleDate)
    HAVING SUM(SalesAmount) > 45000
) AS QuarterlySales
ON e.EmployeeID = QuarterlySales.EmployeeID
GROUP BY 
    e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(DISTINCT QuarterlySales.Quarter) = 4;


--select (select SalesAmount from sales where SaleDate in (select min(saledate)as min_sale_date from sales)) as min_date_salary,
--(select SalesAmount from sales where SaleDate in (select max(saledate)as min_sale_date from sales)) as max_date_salary,
--(select SalesAmount from sales where SaleDate in (select min(saledate)as min_sale_date from sales))-
--(select SalesAmount from sales where SaleDate in (select max(saledate)as min_sale_date from sales))

WITH MonthlySales AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesWithDiff AS (
    SELECT 
        SaleMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SaleMonth) AS PrevMonthSales
    FROM MonthlySales
)
SELECT 
    SaleMonth,
    TotalSales,
    PrevMonthSales,
    TotalSales - PrevMonthSales AS SalesDifference
FROM SalesWithDiff;





--with sale_diff as(
--select 

--sum(salesamount),
--MONTH(GETDATE()) as current_month from sales
--group by MONTH(GETDATE())
--)
--select
--sum(salesamount),
--dateadd(month,-1,(GETDATE())) from sales
--group by dateadd(month,-1,(GETDATE()))

--select * from sale_diff

--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
select * from sales;
select * from Employees

select saledate,sum(SalesAmount) as total_sales from sales
group by SaleDate

--Difficult Tasks
--This script uses recursion to calculate Fibonacci numbers

;with cte as (
  select 0 as first_num, 1 as second_num 
  union all
  select second_num,first_num + second_num from cte
  where first_num < 100)
select first_num from cte


--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT Vals
FROM FindSameCharacters
WHERE 
    LEN(Vals) > 1
    AND LEN(REPLACE(vals, LEFT(vals, 1), '')) = 0;
	select * from FindSameCharacters

--Create a numbers table that shows all numbers 1 through n and
--their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @n INT = 5;

WITH NumbersCTE AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(100)) AS sequence
    UNION ALL
    SELECT num + 1, sequence + CAST(num + 1 AS VARCHAR(10))
    FROM NumbersCTE
    WHERE num + 1 <= @n
)
SELECT *
FROM NumbersCTE;

--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)

SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    TotalSales
FROM (
    SELECT 
        s.EmployeeID,
        SUM(s.SalesAmount) AS TotalSales
    FROM Sales s
    WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())  -- Sales in the last 6 months
    GROUP BY s.EmployeeID
) AS EmployeeSales
JOIN Employees e ON e.EmployeeID = EmployeeSales.EmployeeID
WHERE EmployeeSales.TotalSales = (
    SELECT MAX(TotalSales) 
    FROM (
        SELECT 
            s.EmployeeID,
            SUM(s.SalesAmount) AS TotalSales
        FROM Sales s
        WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY s.EmployeeID
    ) AS InnerEmployeeSales
);
--Write a T-SQL query to remove the duplicate integer values present in the string column.
--Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

-- Query to remove duplicates and single characters from the string
;WITH CleanedData AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        -- Removing duplicate integers and single integer characters
        -- 1. Remove single digits
        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            Pawan_slug_name,
            '0', ''), '1', ''), '2', ''), '3', ''), '4', ''), '5', ''), '6', ''), '7', ''), '8', ''), '9', '') AS CleanedSlug
    FROM RemoveDuplicateIntsFromNames
)
SELECT 
    PawanName, 
    Pawan_slug_name,
    CleanedSlug
FROM CleanedData;

