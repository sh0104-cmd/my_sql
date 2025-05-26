create database  Homework18

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

--Task 1

CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(10,2)
);

INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)

Select 
S.ProductID,
sum(S.Quantity) as TotalQuantity,
Sum(P.Price*S.Quantity) as TotalRevenue  
from  Sales as S
inner join  Products as P
on S.ProductID =P.ProductID
where MONTH(S.SaleDate)=MONTH(GETDATE()) and
      year(S.SaleDate)=year(GETDATE())

group by  S.ProductID


--TAsk 2

Create view vw_ProductSalesSummary as

Select P.ProductID, p.ProductName, p.Category,Sum(S.quantity) as TotalQuantitySold
from  Products as P
left join  Sales as S
on P.ProductID=S.ProductID
group by P.ProductID, p.ProductName , p.Category

--Task 3

create function fn_GetTotalRevenueForProduct(@ProductID INT)
returns table
as
return(Select Sales.ProductID,Sum(Products.Price*Sales.Quantity) as TotalRevenue   from Sales  
inner join Products 
on Sales.ProductID=Products.ProductID
where Sales.ProductID=@ProductID
group by Sales.ProductID)

SELECT * FROM dbo.fn_GetTotalRevenueForProduct(1);

--TAsk 4

create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table
as
return(Select 
P.ProductName,
sum(S.Quantity) as TotalQuantity,
Sum(P.Price*S.Quantity) as TotalRevenue  
from  Sales as S
inner join  Products as P
on S.ProductID =P.ProductID
where P.category=@Category
group by  P.ProductName
);


SELECT * FROM dbo.fn_GetSalesByCategory('Electronics');

--Task 5



CREATE FUNCTION fn_IsPrime(@num INT)
RETURNS VARCHAR(3)
AS
BEGIN
    declare @number int =23
declare @inc int = 2
declare @checker int

while @inc < @number
  begin
    if @number % @inc != 0
      begin
        set @checker = 1
        set @inc = @inc + 1
      end
    else
      begin
        set @checker = 0
        break
      end
  end
if @checker = 0
  begin
    print 'No'
  end
else
  begin
      print 'Yes'
  end



SELECT dbo.fn_IsPrime(7) AS Result;  -- Natija: 'Yes'
SELECT dbo.fn_IsPrime(10) AS Result; -- Natija: 'No'



--Task 6



CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS TABLE
AS
RETURN (
    SELECT Number
    FROM (VALUES (1), (2), (3), (4), (5), (6)) AS t(Number)
    WHERE number BETWEEN @Start AND @End
);

SELECT * FROM dbo.fn_GetNumbersBetween(2, 5);

--TAsk 7
create table Employess(id int ,Salary decimal(10,2))

insert into Employess values
(1,100),(2,200),(3,300)
select * from  Employess

create function  getNthHighestSalary(@Salary int )
returns int 
as
begin
return(select max(Salary) from  Employess as E1
where @Salary = (select count(Salary) from Employess as E2 where E1.Salary <= E2.Salary ))
end;

Select dbo.getNthHighestSalary(2)





--TAsk 8
CREATE TABLE Friendship (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

INSERT INTO Friendship (requester_id, accepter_id, accept_date)
VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');



;with F1 as (select count(*) as NumFriends from (
select requester_id from Friendship
union all
select accepter_id from Friendship
) as A
group by A.requester_id),
F2 as (Select * from F1
where NumFriends in  (select max(NumFriends)from F1))
select * from F2


--TAsk 9

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);




CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name;


--Task 10

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,'Charlie'),(8,NULL),(9,NULL);


SELECT g.RowNumber, filled.TestCase
FROM Gaps g
OUTER APPLY (
    SELECT TOP 1 TestCase
    FROM Gaps g2
    WHERE g2.RowNumber <= g.RowNumber AND g2.TestCase IS NOT NULL
    ORDER BY g2.RowNumber DESC
) AS filled;


