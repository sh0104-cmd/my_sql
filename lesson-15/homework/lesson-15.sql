--Lesson-15: Subqueries and Exists

--Level 1: Basic Subqueries
--1. Find Employees with Minimum Salary

CREATE TABLE employees2 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees2 (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

select * from employees2
where salary in(select min(salary) from employees2)

--2. Find Products Above Average Price

--Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

CREATE TABLE products1 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products1(id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

select * from products1
where price > (select avg(price) from products1)

--Level 2: Nested Subqueries with Conditions
--3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);


select e.id,e.name,(select department_name from departments as d where d.id=e.department_id )as dept_name from employees as e
where department_id in (select id from departments where department_name='sales')

--4. Find Customers with No Orders

--Task: Retrieve customers who have not placed any orders. 
---Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders1 (order_id, customer_id) VALUES
(1, 1),
(2, 1);

select * from Customers
select * from orders1

--select distinct o.customer_id,
--(select c.name from customers as c where o.customer_id=c.customer_id)as order_id from orders1 as o


select * from customers
where customer_id not in (select customer_id from orders1)

--TAsk 5

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);

select * from products 
join (select category_id,max(price) as Max_price  from products
group by category_id ) as M
on products.category_id=M.category_id
and products.price=m.Max_price



--Task 6

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);




SELECT id, name, salary, department_id
FROM employees
WHERE department_id = (SELECT department_id FROM (
        SELECT department_id, AVG(salary) AS avg_salary
        FROM employees
        GROUP BY department_id
    ) AS avg_salaries
    WHERE avg_salary = (
        SELECT MAX(avg_salary)
        FROM (
            SELECT department_id, AVG(salary) AS avg_salary
            FROM employees
            GROUP BY department_id
        ) AS inner_avg
    )
);



--Task 7 

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);



SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);



--Task 8

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

select s.student_id, s.name, g.course_id, g.grade from grades as g
inner join(SELECT course_id, MAX(grade) AS max_grade FROM grades
GROUP BY course_id) as max_grades
on g.course_id=max_grades.course_id and g.grade=max_grades.max_grade
join students as s
on s.student_id=g.student_id



--9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)

CREATE TABLE products1 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products1 (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

SELECT id, product_name, price, category_id
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS price_rank
    FROM products1
) ranked
WHERE price_rank = 3;


--Retrieve employees with salaries above the company average but below the maximum in their department.
--Tables: employees (columns: id, name, salary, department_id)

select * from employees2
where salary between (select avg(salary) from employees2) and (select max(salary) from employees2)

CREATE TABLE employees2 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees2 (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);

