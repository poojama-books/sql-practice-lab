-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 5 - Ask Better Questions with WHERE
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 7 - Completed Orders
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE status = 'Completed';

-- ----------------------------------------------------------------------
-- Exercise 8 - Orders Above 1,000
-- Check Your Result: 9 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    status,
    total_amount
FROM orders
WHERE total_amount > 1000;

-- ----------------------------------------------------------------------
-- Exercise 9 - Low Stock Alert
-- Check Your Result: 8 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 20;

-- ----------------------------------------------------------------------
-- Exercise 10 - Large Completed Orders
-- Check Your Result: 21 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE status = 'Completed'
  AND total_amount > 600;

-- ----------------------------------------------------------------------
-- Exercise 11 - Customers from Selected Countries
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_name,
    country,
    email
FROM customers
WHERE country IN ('Canada', 'Germany', 'Spain');

-- ----------------------------------------------------------------------
-- Exercise 12 - Mid-Range Salaries
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_name,
    salary
FROM employees
WHERE salary BETWEEN 70000 AND 90000;

-- ----------------------------------------------------------------------
-- Exercise 13 - Customer Name Search
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_name LIKE 'S%';

-- ----------------------------------------------------------------------
-- Exercise 14 - Orders That Are Not Cancelled
-- Check Your Result: 189 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    status
FROM orders
WHERE status <> 'Cancelled';

-- Alternative
SELECT
    order_id,
    order_date,
    status
FROM orders
WHERE NOT status = 'Cancelled';

-- ----------------------------------------------------------------------
-- Exercise 15 - Missing Customer Email Addresses
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name
FROM customers
WHERE email IS NULL;

