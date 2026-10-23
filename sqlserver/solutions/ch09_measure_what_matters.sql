-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 9 - Measure What Matters
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 41 - Count Website Sessions
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS total_sessions
FROM website_sessions;

-- ----------------------------------------------------------------------
-- Exercise 42 - Count Completed Orders
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'Completed';

-- ----------------------------------------------------------------------
-- Exercise 43 - Total Successful Collections
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    SUM(amount) AS total_collected
FROM payments
WHERE payment_status = 'Successful';

-- ----------------------------------------------------------------------
-- Exercise 44 - Average Employee Salary
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;

-- ----------------------------------------------------------------------
-- Exercise 45 - Earliest Customer Signup
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    MIN(signup_date) AS first_signup_date
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 46 - Most Recent Successful Payment
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    MAX(payment_date) AS latest_successful_payment
FROM payments
WHERE payment_status = 'Successful';

-- ----------------------------------------------------------------------
-- Exercise 47 - Total Units Sold
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;

-- ----------------------------------------------------------------------
-- Exercise 48 - Average Product Price
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ROUND(AVG(price), 2) AS average_product_price
FROM products;

-- ----------------------------------------------------------------------
-- Exercise 49 - Salary Range
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;

-- ----------------------------------------------------------------------
-- Exercise 50 - Customer Email Coverage
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS total_customers,
    COUNT(email) AS customers_with_email
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 51 - Successful Payment Summary
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS successful_payments,
    SUM(amount) AS total_collected,
    ROUND(AVG(amount), 2) AS average_payment,
    MIN(amount) AS smallest_payment,
    MAX(amount) AS largest_payment
FROM payments
WHERE payment_status = 'Successful';

-- ----------------------------------------------------------------------
-- Exercise 52 - Count Active Payment Methods
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(DISTINCT payment_method) AS active_payment_methods
FROM payments
WHERE payment_status = 'Successful';

