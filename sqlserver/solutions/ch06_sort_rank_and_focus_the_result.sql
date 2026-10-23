-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 6 - Sort, Rank and Focus the Result
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 16 - Products by Price
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    price
FROM products
ORDER BY price ASC;

-- ----------------------------------------------------------------------
-- Exercise 17 - Highest-Paid Employees First
-- Check Your Result: 16 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_name,
    salary
FROM employees
ORDER BY salary DESC;

-- ----------------------------------------------------------------------
-- Exercise 18 - Newest Customers
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    signup_date
FROM customers
ORDER BY signup_date DESC;

-- ----------------------------------------------------------------------
-- Exercise 19 - Lowest Stock First
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    stock_quantity
FROM products
ORDER BY stock_quantity ASC;

-- ----------------------------------------------------------------------
-- Exercise 20 - Sort Customers by Location
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_name,
    country,
    city
FROM customers
ORDER BY country ASC, city ASC;

-- ----------------------------------------------------------------------
-- Exercise 21 - Five Largest Successful Payments
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT TOP 5
    payment_id,
    order_id,
    payment_method,
    amount
FROM payments
WHERE payment_status = 'Successful'
ORDER BY amount DESC;

-- ----------------------------------------------------------------------
-- Exercise 22 - Latest Five Orders
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT TOP 5
    order_id,
    order_date,
    status,
    total_amount
FROM orders
ORDER BY order_date DESC;

-- ----------------------------------------------------------------------
-- Exercise 23 - Largest Completed Orders
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT TOP 3
    order_id,
    order_date,
    total_amount
FROM orders
WHERE status = 'Completed'
ORDER BY total_amount DESC;

