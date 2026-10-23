-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 15 - Connect Related Tables
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 101 - Website Sessions with Customer Names
-- Check Your Result: 75 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ws.session_id,
    ws.session_date,
    c.customer_name,
    ws.traffic_source
FROM website_sessions AS ws
INNER JOIN customers AS c
    ON ws.customer_id = c.customer_id
ORDER BY ws.session_date, ws.session_id;

-- ----------------------------------------------------------------------
-- Exercise 102 - Products with Category Names
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_name,
    c.category_name,
    p.price
FROM products AS p
INNER JOIN categories AS c
    ON p.category_id = c.category_id;

-- ----------------------------------------------------------------------
-- Exercise 103 - Employees with Department Names
-- Check Your Result: 16 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    e.employee_name,
    d.department_name,
    e.salary
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id;

-- ----------------------------------------------------------------------
-- Exercise 104 - Orders with Payment Details
-- Check Your Result: 180 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    o.order_date,
    p.payment_method,
    p.payment_status,
    p.amount
FROM orders AS o
INNER JOIN payments AS p
    ON o.order_id = p.order_id;

-- ----------------------------------------------------------------------
-- Exercise 105 - Completed Orders with Customer Details
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    c.customer_name,
    c.country,
    o.order_date,
    o.total_amount
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.status = 'Completed';

-- ----------------------------------------------------------------------
-- Exercise 106 - Product Sales Details
-- Check Your Result: 384 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_value
FROM order_items AS oi
INNER JOIN products AS p
    ON oi.product_id = p.product_id;

-- ----------------------------------------------------------------------
-- Exercise 107 - Customer Payment Report
-- Check Your Result: 180 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_name,
    o.order_id,
    p.payment_date,
    p.payment_method,
    p.amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN payments AS p
    ON o.order_id = p.order_id;

-- ----------------------------------------------------------------------
-- Exercise 108 - Product Revenue by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id
INNER JOIN categories AS c
    ON p.category_id = c.category_id
WHERE o.status = 'Completed'
GROUP BY c.category_name
ORDER BY total_revenue DESC;

-- ----------------------------------------------------------------------
-- Exercise 109 - Customer Website Activity
-- Check Your Result: 15 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(ws.session_id) AS session_count,
    MAX(ws.session_date) AS latest_session
FROM customers AS c
JOIN website_sessions AS ws
    ON c.customer_id = ws.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY latest_session DESC;

