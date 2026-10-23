-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 10 - Group the Business
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 53 - Order Count per Customer
-- Check Your Result: 20 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC, customer_id;

-- ----------------------------------------------------------------------
-- Exercise 54 - Most Recent Customer Signup by Country
-- Check Your Result: 18 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    country,
    MAX(signup_date) AS latest_signup_date
FROM customers
GROUP BY country
ORDER BY latest_signup_date DESC;

-- ----------------------------------------------------------------------
-- Exercise 55 - Average Order Value by Date
-- Check Your Result: 191 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
order_date,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- ----------------------------------------------------------------------
-- Exercise 56 - Revenue by Payment Method
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_method,
    SUM(amount) AS total_amount
FROM payments
WHERE payment_status = 'Successful'
GROUP BY payment_method
ORDER BY total_amount DESC;

-- ----------------------------------------------------------------------
-- Exercise 57 - Products by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    category_id,
    COUNT(*) AS total_products
FROM products
GROUP BY category_id
ORDER BY total_products DESC;

-- ----------------------------------------------------------------------
-- Exercise 58 - Average Product Price by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    category_id,
    ROUND(AVG(price), 2) AS average_price
FROM products
GROUP BY category_id
ORDER BY average_price DESC;

-- ----------------------------------------------------------------------
-- Exercise 59 - Employees by Department
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;

-- ----------------------------------------------------------------------
-- Exercise 60 - Average Salary by Department
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    department_id,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department_id
ORDER BY average_salary DESC;

-- ----------------------------------------------------------------------
-- Exercise 61 - Website Sessions by Traffic Source
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    traffic_source,
    COUNT(*) AS total_sessions
FROM website_sessions
GROUP BY traffic_source
ORDER BY total_sessions DESC;

-- ----------------------------------------------------------------------
-- Exercise 62 - Website Sessions by Device and Source
-- Check Your Result: 15 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    device_type,
    traffic_source,
    COUNT(*) AS total_sessions
FROM website_sessions
GROUP BY
    device_type,
    traffic_source
ORDER BY
    device_type,
    total_sessions DESC;

-- ----------------------------------------------------------------------
-- Exercise 63 - Order Summary by Status
-- Check Your Result: 4 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    status,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_value,
    ROUND(AVG(total_amount), 2) AS average_value,
    MIN(total_amount) AS smallest_order,
    MAX(total_amount) AS largest_order
FROM orders
GROUP BY status
ORDER BY total_value DESC;

