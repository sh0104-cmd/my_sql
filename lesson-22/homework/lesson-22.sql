create database Homework22
use Homework22


CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')



--Task 1
Select 
    customer_id,
	customer_name,
	total_amount,
	sum(total_amount) over (partition  by customer_name order by order_date  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RunningTotal
from sales_data




--Task 2

Select product_category,count(distinct sale_id) as SaleCouunt from sales_data
group by product_category


--Task 3
Select product_category,max(total_amount) as MaxTotal from sales_data
 group by product_category

 --Task 4
 Select product_category,min(unit_price) as MaxTotal from sales_data
 group by product_category
 
 

 --Task 5
 Select customer_id,
        customer_name,
		product_category,
		total_amount,
		AVG(total_amount) over(order by order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as MovingAvg
                 from  sales_data
 
  --Task 6
 Select distinct 
        region,
		sum(total_amount) over(partition by region ) as SumRegion 
                 from  sales_data
 

  --Task 7
 Select  customer_id,
                 customer_name,  
                 sum(total_amount) AS total_purchase,
                 DENSE_RANK() over (order by  sum(total_amount) desc ) as RankCustomer
                 from  sales_data
				 group by customer_id, customer_name
            
			
  --Task 8

  Select total_amount as CurrentAmount,
         LEAD(total_amount) over(order by order_date) as NextSaleAmount,
		 (total_amount-LEAD(total_amount) over(order by order_date)) as DiffSaleAmount
  from sales_data


  --Task 9

 ;with cte as (Select  product_category,
          product_name,unit_price,
		  dense_rank() over (partition by product_category order by unit_price desc) as Price 
  from sales_data)
  select * from cte 
  where Price<=3

  --Task 10

  Select region,
        order_date,
		total_amount,
		sum(total_amount) over (partition by region order by order_date   
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as SumAmount from  sales_data
  order by region,order_date



 --Task 11


 SELECT
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM
    sales_data
ORDER BY
    product_category, order_date;

 --Task 12
 CREATE TABLE numbers (
    ID INT
);

INSERT INTO numbers (ID) VALUES
(1),
(2),
(3),
(4),
(5);


Select id,sum(id) over(order by id) as SumPreValues from numbers


 --Task 13
 CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

Select Value,Sum(Value) over (order by Value  ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) as Sum_of_Previous  from OneColumn




 --Task 14


 CREATE TABLE Row_Nums (
    Id INT,
    Vals VARCHAR(10)
);
INSERT INTO Row_Nums VALUES
(101,'a'), (102,'b'), (102,'c'), (103,'f'), (103,'e'), (103,'q'), (104,'r'), (105,'p');

;with cte as (Select id,Vals,row_number() over(  partition by id order by Vals) as row_number_in_group ,
2 * DENSE_RANK() OVER (ORDER BY Id) - 1 AS start_odd_number
from Row_Nums)

Select id,Vals,(start_odd_number + row_number_in_group -1 ) AS RowNumber from cte


 --Task 15
 Select customer_id, 
        customer_name,
		count(distinct product_category) AS num_categories
from sales_data
group by  customer_id, 
        customer_name		
Having count(distinct product_category)>1


 --Task 16

;with Sumcte as (Select customer_id,
	   region,
	   sum(total_amount)  as customer_spending
from sales_data
group by customer_id,
	   region ),


Avgcte as (Select customer_id,
       region,
	   avg(total_amount) AS avg_spending 
from sales_data
group by customer_id,
	   region)

Select s.customer_id,s.region,s.customer_spending,a.avg_spending from Sumcte as S
join Avgcte as A
on s.customer_id=a.customer_id
where s.customer_spending>a.avg_spending




 --Task 17

;with customer_spending as ( 
Select customer_id,
       customer_name,
       region, 
	   SUM(total_amount) AS total_spent from sales_data
 group by  customer_id,customer_name,region,total_amount)

 Select customer_id,
        customer_name,
        region,
		total_spent,
		 dense_rank() over (partition by region order by total_spent desc) as RankRegion
		from customer_spending

--Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.

SELECT
    customer_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM orders;


--Calculate the sales growth rate (growth_rate) for each month compared to the previous month.

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS sales_month,
        SUM(total_amount) AS monthly_total
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
),
sales_with_growth AS (
    SELECT
        sales_month,
        monthly_total,
        LAG(monthly_total) OVER (ORDER BY sales_month) AS previous_month_total
    FROM monthly_sales
)
SELECT
    sales_month,
    monthly_total,
    previous_month_total,
    ROUND(
        CASE 
            WHEN previous_month_total = 0 OR previous_month_total IS NULL THEN NULL
            ELSE (monthly_total - previous_month_total) / previous_month_total
        END, 4
    ) AS growth_rate
FROM sales_with_growth
ORDER BY sales_month;


--Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)
SELECT
    customer_id,
    order_date,
    total_amount,
    previous_total,
    (total_amount - previous_total) AS increase_amount
FROM (
    SELECT
        customer_id,
        order_date,
        total_amount,
        LAG(total_amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_total
    FROM sales_data
) AS comparison
WHERE total_amount > previous_total;


--Hard Questions
--Identify Products that prices are above the average product price

SELECT *
FROM products
WHERE price > (
    SELECT AVG(price) FROM products
);

--In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. 
--The challenge here is to do this in a single select. For more details please see the sample input and expected output.

SELECT
    group_id,
    item_id,
    val1,
    val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY item_id) = 1
        THEN SUM(val1 + val2) OVER (PARTITION BY group_id)
        ELSE NULL
    END AS group_total
FROM sales_data;

--Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.
--Please go through the sample input and expected output for details.
WITH distinct_quantities AS (
    SELECT DISTINCT id, quantity
    FROM sales_data
),
summed_quantities AS (
    SELECT id, SUM(quantity) AS total_quantity
    FROM distinct_quantities
    GROUP BY id
),
summed_costs AS (
    SELECT id, SUM(cost) AS total_cost
    FROM sales_data
    GROUP BY id
)
SELECT
    c.id,
    c.total_cost,
    q.total_quantity
FROM summed_costs c
JOIN summed_quantities q ON c.id = q.id;

--From following set of integers, write an SQL statement to determine the expected outputs
SELECT num, COUNT(*) AS frequency
FROM numbers
GROUP BY num
ORDER BY num;

--In this puzzle you need to generate row numbers for the given data. The condition is that the first row number for every partition should be even number.
--For more details please check the sample input and expected output.

SELECT
    category,
    item,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY item) + 1 AS row_num
FROM sales_data;
