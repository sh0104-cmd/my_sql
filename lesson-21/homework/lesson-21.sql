create database hw21;
use hw21

--Lesson 21 WINDOW FUNCTIONS
CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);
INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);

CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');


--1.Write a query to assign a row number to each sale based on the SaleDate.
select *,row_number()over(order by saleamount desc) as rn from ProductSales


--2.Write a query to rank products based on the total quantity sold.
--give the same rank for the same amounts without skipping numbers.

select ProductName,sum(quantity) as total_quantity,
dense_rank()over(order by sum(quantity) desc)as dnrk
from ProductSales
group by ProductName

--3.Write a query to identify the top sale for each customer based on the SaleAmount.

with cte as (
select customerid,saleamount,
dense_rank() over(partition by customerid order by saleamount desc) as drnk
from productsales)
select * from cte
where cte.drnk=1

--4.Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.

select *,
isnull(lead(SaleAmount) over( order by saledate),0) as ld
from productsales

--5.Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
select *,
isnull(lag(SaleAmount) over( order by saledate),0) as ld
from productsales

--6.Write a query to identify sales amounts that are greater than the previous sale's amount
with cte as(
select *,
lag(saleamount)over(order by saledate) as prev_amount
from productsales
)

select * from cte
where cte.SaleAmount>cte.prev_amount

--select SaleAmount,SaleDate,
--lag(saleamount)over(order by saledate) as prev_amount
--from productsales
--where SaleAmount>lag(saleamount)over(order by saledate)


--7.Write a query to calculate the difference in sale amount from the previous sale for every product
select *,
isnull(lag(saleamount)over(partition by productname order by saledate),0) as prev_amount,SaleAmount-isnull(lag(saleamount)over(partition by productname order by saledate),0) as diff_amount
from productsales
order by ProductName

--8.Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
select *,
lag(saleamount)over( order by saledate) as prev_amount,SaleAmount/lag(saleamount)over(order by saledate)*100-100 as diff_amount
from productsales

--9.Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
select *,
lag(saleamount)over(partition by productname order by saledate) as prev_amount,SaleAmount/lag(saleamount)over(partition by productname order by saledate) as diff_amount
from productsales
order by ProductName

--10.Write a query to calculate the difference in sale amount from the very first sale of that product.
;with cte as 
(select *,
first_value(saleamount)over(partition by productname order by saledate) as f_value

from productsales
)
select *,cte.saleamount-cte.f_value as diff_value from cte 

--Write a query to find sales that have been increasing continuously for a product (i.e.,
--each sale amount is greater than the previous sale amount for that product).

;with cte as
(select *,
lag(saleamount)over(partition by productname order by saledate) as prev_amount 
from productsales
)
select * from cte
where saleamount>prev_amount
order by ProductName

--12.Write a query to calculate a "closing balance"(running total) for sales amounts
--which adds the current sale amount to a running total of previous sales.
SELECT
  productname,
  saledate,
  SaleAmount,
  SUM(saleamount) OVER (
    PARTITION BY productname 
    ORDER BY saledate
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total
FROM
  productsales;

  --13.Write a query to calculate the moving average of sales amounts over the last 3 sales.

  select *,avg(saleamount) over(
  partition by productname
  order by saledate
  rows between 2 preceding and current row)
  as mov_avg_sale
  from ProductSales
 --14.Write a query to show the difference between each sale amount and the average sale amount.
  ;with cte as(
   select *,avg(saleamount) over(
  partition by productname
  order by saledate
  rows between unbounded preceding and current row)
  as avg_sale
  from ProductSales)
  select *,cte.saleamount-cte.avg_sale
  as diff_amount
  from cte
  --15.Find Employees Who Have the Same Salary Rank
select * from Employees1

;with cte as(
select *,rank()over (order by salary desc)as rnk from Employees1)
select cte.Salary,count(cte.rnk)as same_rnk from cte
group by cte.Salary
having count(cte.rnk)>1

--16.Identify the Top 2 Highest Salaries in Each Department

with cte as (
select *,DENSE_RANK() over(partition by Department order by salary desc) as dnr from Employees1)
select * from cte where cte.dnr in (1,2)

--17.Find the Lowest-Paid Employee in Each Department
SELECT * FROM (
    SELECT 
       *,ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary ASC
        ) AS rn
    FROM Employees1
) AS ranked
WHERE rn = 1;

--18.Calculate the Running Total of Salaries in Each Department
select *,
sum(salary)over(partition by department order by salary desc rows between unbounded preceding and current row)as running_total from Employees1

----Find the Total Salary of Each Department Without GROUP BY
select *,
sum(salary)over(partition by department)as total_salary from Employees1

--20.Calculate the Average Salary in Each Department Without GROUP BY
select *,
avg(salary)over(partition by department)as avg_salary from Employees1

--21.Find the Difference Between an Employee’s Salary and Their Department’s Average
select *,
avg(salary)over(partition by department)as avg_salary,
Salary-avg(salary)over(partition by department) as diff_from_avg
from Employees1

--22.Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
select *,
avg(salary)over(partition by department order by salary desc rows between 1 preceding and 1 following)as moving_avg from Employees1

--23.Find the Sum of Salaries for the Last 3 Hired Employees
select sum(Salary) total_3_sal from(
select *,row_number()over(order by hiredate desc)as rn from Employees1) as e2
where rn in (1,2,3)
