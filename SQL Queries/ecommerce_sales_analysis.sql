show databases
use ecommerce_project
show tables

CREATE TABLE sales (
OrderID INT PRIMARY KEY,
CustomerID VARCHAR(10),
CustomerName VARCHAR(50),
Product VARCHAR(50),
Category VARCHAR(50),
Quantity INT,
Price DECIMAL(10,2),
OrderDate DATE,
City VARCHAR(50)
);

INSERT INTO sales
(OrderID, CustomerID, CustomerName, Product, Category, Quantity, Price, OrderDate, City)
VALUES
(1001,'C001','Rahul','Laptop','Electronics',1,50000,'2025-01-10','Delhi'),
(1002,'C002','Priya','Phone','Electronics',2,25000,'2025-01-12','Mumbai'),
(1003,'C003','Aman','Headphones','Accessories',3,1500,'2025-01-15','Delhi'),
(1004,'C001','Mohit','Mouse','Accessories',2,800,'2025-01-18','Delhi'),
(1005,'C004','Neha','Laptop','Electronics',1,52000,'2025-01-20','Bangalore'),
(1006,'C005','Ankit','Keyboard','Electronics',1,50000,'2025-01-10','Chandigarh'),
(1007,'C002','Neha','Phone','Electronics',2,25000,'2025-01-22','Mumbai'),
(1008,'C006','Piyu','Tablet','Accessories',3,15000,'2025-01-25','Gurgaon'),
(1009,'C007','Ankush','Mouse','Accessories',2,5800,'2025-01-27','Jaipur'),
(1010,'C003','Boby','Laptop','Electronics',1,52000,'2025-01-29','Delhi'),
(1011,'C008','Rocky','Tablet','Electronics',5,50000,'2025-02-01','Pune'),
(1012,'C009','Paras','Phone','Electronics',2,25000,'2025-02-05','Mumbai'),
(1013,'C010','Aditya','Keyboard','Accessories',3,1200,'2025-02-10','Delhi'),
(1014,'C011','Monu','Mouse','Accessories',2,9800,'2025-02-15','Gurgaon'),
(1015,'C012','Rahul','Laptop','Electronics',1,52000,'2025-02-18','Bangalore');


-- DATA EXPLORATION :- 

-- Total Records :-

select count(*)  as total_orders
from sales

-- Unique Customers :-
select count(distinct CustomerID) as unique_customer
from sales

-- Unique Products
select count(distinct Product) as unique_product
from sales


-- BUSINESS ANALYSIS QUERIES :-

-- 1. Total Revenue :-
select sum(Quantity * Price) as total_revenue
from sales;


-- 2. Top Selling Products :-
SELECT
Product,
SUM(Quantity) AS total_quantity
FROM sales
GROUP BY Product
ORDER BY total_quantity DESC;


-- 3. Revenue by Product :-
select product, sum(Quantity * Price) AS revenue_by_product
from sales group by product
order by revenue_by_product desc;


-- 3. Revenue by Category :-
select Category, sum(Quantity * Price) as revenue
from sales
group by Category
order by revenue desc;


-- 4. Top Customers :-
SELECT
CustomerName,
SUM(Quantity * Price) AS total_spending
FROM sales
GROUP BY CustomerName
ORDER BY total_spending DESC;


-- 5. Top Cities by Revenue :-
select City, sum(Quantity * Price) AS revenue
from sales
group by City
order by revenue desc;


-- 6. Monthly Revenue Trend :-
SELECT
MONTH(OrderDate) AS month,
SUM(Quantity * Price) AS revenue
FROM sales
GROUP BY MONTH(OrderDate);


-- 7. Average Order Value :-
SELECT
ROUND(AVG(Quantity * Price),2)
AS avg_order_value
FROM sales;


-- 8. Highest Revenue Order :-
SELECT *
FROM sales
ORDER BY Quantity * Price DESC
LIMIT 1;


-- 9. Customer Purchase Frequency :-
SELECT
CustomerName,
COUNT(*) AS total_orders
FROM sales
GROUP BY CustomerName
ORDER BY total_orders DESC;


-- 10. Rank Customers by using Window Function :-
SELECT
CustomerName,
SUM(Quantity * Price) AS Spending,
DENSE_RANK() OVER(
ORDER BY SUM(Quantity * Price) DESC
) AS Customer_Rank
FROM sales
GROUP BY CustomerName;


-- 11. Running Revenue :-
SELECT
OrderDate,
SUM(Quantity * Price) AS Revenue,
SUM(SUM(Quantity * Price))
OVER(ORDER BY OrderDate)
AS Running_Total
FROM sales
GROUP BY OrderDate;



-- BUSINESS INSIGHTS :- 

1. Electronics contributes over 90% of revenue.
2. Laptop is the highest revenue-generating product.
3. Delhi generates maximum sales.
4. Rahul and Aman are top customers.
5. Revenue increased in February compared to January.