--Lesson-12: Practice
--Combine Two Tables
--Write a solution to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table,
--report null instead.

Create table Person (personId int, firstName varchar(255), lastName varchar(255))
Create table Address (addressId int, personId int, city varchar(255), state varchar(255))
Truncate table Person
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')
Truncate table Address
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')

select P.firstName,P.lastName,A.city,A.state from Person as P
left join Address as A
on P.personId=A.personId

--Employees Earning More Than Their Managers
Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

--Write a solution to find the employees who earn more than their managers.
select E1.name from Employee as E1
inner join Employee as E2
on E2.id=E1.managerId 
where E1.salary>E2.salary

--Duplicate Emails
 drop table Person
 create table Person (id int, email varchar(255))

 insert into Person (id, email) values 
 ('1', 'a@b.com') insert into Person (id, email) values ('2', 'c@d.com') insert into Person (id, email) values ('3', 'a@b.com')
 --Write a solution to report all the duplicate emails. Note that it''s guaranteed that the email field is not NULL.
 select email,count(id) from Person
 group by email
 having count(id)>1

 --Delete Duplicate Emails
  insert into Person (id, email) values (1,'john@example.com'),(2,'bob@example.com'),(3,'john@example.com')
  
  delete from person where id not in(select min(id) from person group by email)

  --Find those parents who has only girls.
  CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

select distinct g.ParentName from girls as g
full join boys as b
on g.ParentName=b.ParentName
where b.name is null


--Total over 50 and least

--Find total Sales amount for the orders which weights more than 50 for each customer along with their least weight.
--(from TSQL2012 database, Sales.Orders Table)
CREATE SCHEMA Sales;
CREATE TABLE Sales.Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),  -- Auto-incrementing primary key
    CustomerID INT NOT NULL,                 -- Customer ID (foreign key could be added later)
    OrderAmount DECIMAL(18, 2) NOT NULL,    -- Total amount of the order
    Weight DECIMAL(10, 2) NOT NULL,         -- Weight of the order
    OrderDate DATETIME NOT NULL DEFAULT GETDATE()  -- Date of the order
);
INSERT INTO Sales.Orders (CustomerID, OrderAmount, Weight)
VALUES 
    (1, 150.00, 55.5),
    (1, 200.00, 60.0),
    (2, 300.00, 45.0),
    (2, 400.00, 70.0),
    (3, 250.00, 80.0),
    (3, 100.00, 30.0),
    (4, 500.00, 90.0),
    (5, 600.00, 20.0);

SELECT 
    CustomerID,
    SUM(OrderAmount) AS TotalSalesAmount,
    MIN(Weight) AS LeastWeight
FROM 
    Sales.Orders
WHERE 
    Weight > 50
GROUP BY 
    CustomerID;


--Carts
--you have the tables below, write a query to get the expected output

DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO

select isnull(c1.item,' ') as item_cart_1,isnull(c2.item,' ') as item_cart_2 from cart1 as c1
full join cart2 as c2
on c1.Item=c2.Item

--Matches
--Resultga yutgan jamoaning nomi chiqsin agar durrang bo''lsa 'Draw' so''zi chiqsin.(Hisob 10:11 yoki 111:99 bo'lishi ham mumkin :) )

create table match1 (MatchID int, Match varchar(30), Score varchar(5))
insert into match1 values 
		      (1,'Italy-Spain','2:0'),
              (2,'Spain-France','2:1'),
              (3,'France-Belgium','0:0'),
              (4,'Belgium-Spain','2:2'),
              (5,'Belgium-Italy','0:3'),
              (6,'Italy-France','2:0');

SELECT 
    MatchID,
    Match,
    CASE 
        WHEN Score = '0:0' OR Score LIKE '%:%' AND LEFT(Score, CHARINDEX(':', Score) - 1) = RIGHT(Score, LEN(Score) - CHARINDEX(':', Score)) THEN 'Draw'
        WHEN LEFT(Score, CHARINDEX(':', Score) - 1) > RIGHT(Score, LEN(Score) - CHARINDEX(':', Score)) THEN LEFT(Match, CHARINDEX('-', Match) - 1)
        ELSE RIGHT(Match, LEN(Match) - CHARINDEX('-', Match))
    END AS Result
FROM match1;

--Customers Who Never Order
Create table Customers (id int, name varchar(255))
Create table Orders (id int, customerId int)
select * from Orders
insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')

insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

select C.name from Customers as C
left join Orders as O
on C.id=O.customerid
where O.id is null

--Students and Examinations

Create table Students (student_id int, student_name varchar(20))
Create table Subjects (subject_name varchar(20))
Create table Examinations (student_id int, subject_name varchar(20))

insert into Students (student_id, student_name) values ('1', 'Alice');
insert into Students (student_id, student_name) values ('2', 'Bob');
insert into Students (student_id, student_name) values ('13', 'John');
insert into Students (student_id, student_name) values ('6', 'Alex')

insert into Subjects (subject_name) values ('Math');
insert into Subjects (subject_name) values ('Physics');
insert into Subjects (subject_name) values ('Programming')

insert into Examinations (student_id, subject_name) values ('1', 'Math');
insert into Examinations (student_id, subject_name) values ('1', 'Physics');
insert into Examinations (student_id, subject_name) values ('1', 'Programming');
insert into Examinations (student_id, subject_name) values ('2', 'Programming');
insert into Examinations (student_id, subject_name) values ('1', 'Physics');
insert into Examinations (student_id, subject_name) values ('1', 'Math');
insert into Examinations (student_id, subject_name) values ('13', 'Math');
insert into Examinations (student_id, subject_name) values ('13', 'Programming');
insert into Examinations (student_id, subject_name) values ('13', 'Physics');
insert into Examinations (student_id, subject_name) values ('2', 'Math');
insert into Examinations (student_id, subject_name) values ('1', 'Math')

select St.student_id,St.student_name,Sub.subject_name,count(E.subject_name) as attended_exams from Students as St
inner join Examinations as E
on E.student_id=St.student_id
full join Subjects as Sub
on Sub.subject_name=E.subject_name
group by St.student_id,Sub.subject_name,St.student_name
