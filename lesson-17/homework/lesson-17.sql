--Lesson-17: Practice

create database hw17

DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

--You must provide a report of all distributors and their sales by region. 
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region
select * from #RegionSales


;with region as(
select distinct region from #regionsales),

distributor as(
select distinct distributor from #regionsales),
allcombs as (
select r.region,d.Distributor from region as r
cross join distributor as d)
select ac.Region,ac.Distributor,isnull(rs.Sales,0) from allcombs as ac
left join #regionsales as rs
on ac.region=rs.region and ac.distributor=rs.distributor

--Find managers with at least five direct reports
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select distinct e1.name as manager,count(e1.id) as managerid from Employee as e1
join Employee as e2
on e1.id=e2.managerId
where e1.id in (select managerId from Employee group by managerid having count(id)>=5 ) 
group by e1.name

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select * from orders
select p.product_name,o.sum_unit from Products as p
join (select product_id,sum(unit) as sum_unit from Orders where month(order_date)=2 group by product_id having sum(unit)>=100) as o
on o.product_id=p.product_id

--4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders2 (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders2 VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');



with cte as (
select  CustomerID,vendor,sum(count)as total_count from Orders2 group by customerid,vendor 
)
select * from cte where total_count in (select max(total_count) from cte group by CustomerID) order by CustomerID

--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 
--'This number is prime' else eturn 'This number is not prime'

--6.6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

;with signal_device as(
select distinct Device_id,locations,count(Locations)as nu_signal  from device group by Device_id,Locations

)
,signal_device2 as(
select  Device_id,count(Locations)as total_signal  from device group by Device_id
 ),

 
 combos as(
 select s1.Device_id,s1.nu_signal,s3.no_of_locations,s1.Locations,s2.total_signal from signal_device as s1 join signal_device2 as s2 on s1.Device_id=s2.Device_id

 join (select count(distinct locations) as no_of_locations,Device_id from device group by Device_id) as s3 on s1.Device_id=s3.Device_id
 )

select Device_id,no_of_locations,Locations,total_signal from combos
where nu_signal in (select max(nu_signal) from signal_device group by Device_id)



--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 
--'This number is prime' else eturn 'This number is not prime'

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

-- Handle edge cases
IF @Check_Prime <= 1
    SET @IsPrime = 0;
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers
--along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. 
--If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.

 create table tickets(Ticket_ID varchar(50),Number int);
 insert into tickets values('A23423',25),('A23423',45),('A23423',78),('B35643',25),
 ('B35643',45),('B35643',98),('C98787',67),('C98787',86),('C98787',91)

 select * from tickets
 CREATE TABLE WinningNumbers (
    Number INT
);
INSERT INTO WinningNumbers (Number) VALUES (25), (45), (78);

WITH MatchCounts AS (
    SELECT 
        t.Ticket_ID,
        COUNT(DISTINCT t.Number) AS MatchCount
    FROM 
        tickets t
    INNER JOIN 
        WinningNumbers w ON t.Number = w.Number
    GROUP BY 
        t.Ticket_ID
),
Winnings AS (
    SELECT 
        Ticket_ID,
        CASE 
            WHEN MatchCount = 3 THEN 100
            WHEN MatchCount IN (1, 2) THEN 10
            ELSE 0
        END AS Prize
    FROM MatchCounts
)
SELECT SUM(Prize) AS TotalWinnings FROM Winnings;

--9. The Spending table keeps the logs of the spendings history of users that make purchases
--from an online shopping website which has a desktop and a mobile devices.
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

WITH DeviceSpend AS (
  SELECT
    User_id,
    Spend_date,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS UsedMobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS UsedDesktop,
    SUM(Amount) AS TotalAmount
  FROM Spending
  GROUP BY User_id, Spend_date
),
ClassifiedUsers AS (
  SELECT
    Spend_date,
    CASE 
      WHEN UsedMobile = 1 AND UsedDesktop = 1 THEN 'Both'
      WHEN UsedMobile = 1 THEN 'Mobile Only'
      WHEN UsedDesktop = 1 THEN 'Desktop Only'
    END AS UsageType,
    User_id,
    TotalAmount
  FROM DeviceSpend
)
SELECT
  Spend_date,
  UsageType,
  COUNT(DISTINCT User_id) AS TotalUsers,
  SUM(TotalAmount) AS TotalAmountSpent
FROM ClassifiedUsers
GROUP BY Spend_date, UsageType
ORDER BY Spend_date, UsageType;

--Write an SQL Statement to de-group the following data.

DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

with cte as (
select Product,1 as Quantity from Grouped
union all
select cte.Product,cte.Quantity + 1 from Grouped as A
inner join cte on cte.Product = A.Product and cte.Quantity < A.Quantity)
select cte.Product,1 as Quantity from cte
order by cte.Product


