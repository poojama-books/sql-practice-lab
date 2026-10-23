-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 12 - SQL Through Time
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 72 - Orders After a Given Date
-- Check Your Result: 184 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    status,
    total_amount
FROM orders
WHERE order_date >= '2025-01-01';

-- ----------------------------------------------------------------------
-- Exercise 73 - Payments in the Second Quarter of 2026
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_id,
    order_id,
    payment_date,
    amount
FROM payments
WHERE payment_date >= '2026-04-01'
  AND payment_date < '2026-07-01'
ORDER BY payment_date, payment_id;

-- ----------------------------------------------------------------------
-- Exercise 74 - Customers Who Joined in 2025
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    signup_date
FROM customers
WHERE YEAR(signup_date) = 2025;

-- ----------------------------------------------------------------------
-- Exercise 75 - Identify the Order Month
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    MONTH(order_date) AS order_month
FROM orders;

-- ----------------------------------------------------------------------
-- Exercise 76 - Recent Customer Registrations
-- Check Your Result: depends on the day you run it (uses today's date)
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    signup_date
FROM customers
WHERE signup_date >= DATEADD(DAY, -30, CAST(GETDATE() AS DATE));

-- Try it: add a test customer, run the solution again, then run the clean-up
/*
INSERT INTO customers
(customer_name, city, country, email, signup_date)
VALUES
('Test Customer', 'Pune', 'India',
 'test.customer@example.com', DATEADD(DAY, -5, CAST(GETDATE() AS DATE)));
*/

-- Clean-up: remove the test customer
/*
DELETE FROM customers
WHERE customer_name = 'Test Customer';
*/

-- ----------------------------------------------------------------------
-- Exercise 77 - Customer Tenure at the Reporting Date
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_name,
    signup_date,
    DATEDIFF(DAY, signup_date, '2026-09-30') AS days_as_customer
FROM customers
ORDER BY days_as_customer DESC;

-- ----------------------------------------------------------------------
-- Exercise 78 - Long-Serving Employees
-- Check Your Result: 6 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_id,
    employee_name,
    hire_date
FROM employees
WHERE hire_date < '2020-01-01';

-- ----------------------------------------------------------------------
-- Exercise 79 - Orders from a Specific Month
-- Check Your Result: 2 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE YEAR(order_date) = 2025
  AND MONTH(order_date) = 3;

-- ----------------------------------------------------------------------
-- Exercise 80 - Payment Delay
-- Check Your Result: 180 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    o.order_date,
    p.payment_date,
    DATEDIFF(DAY, o.order_date, p.payment_date) AS days_to_payment
FROM orders AS o
JOIN payments AS p
    ON o.order_id = p.order_id;

-- ----------------------------------------------------------------------
-- Exercise 81 - Identify Weekend Website Sessions
-- Check Your Result: 23 rows
-- ----------------------------------------------------------------------
-- Solution
SET DATEFIRST 1;
SELECT
    session_id,
    session_date,
    customer_id
FROM website_sessions
WHERE DATEPART(weekday, session_date) IN (6, 7);

