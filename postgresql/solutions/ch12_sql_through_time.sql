-- The SQL Practice Lab - PostgreSQL solutions
-- Author: Pooja M A
-- Run novacart_postgresql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for PostgreSQL and runs as-is.
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
WHERE EXTRACT(YEAR FROM signup_date) = 2025;

-- ----------------------------------------------------------------------
-- Exercise 75 - Identify the Order Month
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    EXTRACT(MONTH FROM order_date) AS order_month
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
WHERE signup_date >= CURRENT_DATE - INTERVAL '30 days';

-- Try it: add a test customer, run the solution again, then run the clean-up
/*
INSERT INTO customers
(customer_name, city, country, email, signup_date)
VALUES
('Test Customer', 'Pune', 'India',
 'test.customer@example.com', CURRENT_DATE - 5);
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
    DATE '2026-09-30' - signup_date AS days_as_customer
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
WHERE EXTRACT(YEAR FROM order_date) = 2025
  AND EXTRACT(MONTH FROM order_date) = 3;

-- ----------------------------------------------------------------------
-- Exercise 80 - Payment Delay
-- Check Your Result: 180 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    o.order_date,
    p.payment_date,
    p.payment_date - o.order_date AS days_to_payment
FROM orders AS o
JOIN payments AS p
    ON o.order_id = p.order_id;

-- ----------------------------------------------------------------------
-- Exercise 81 - Identify Weekend Website Sessions
-- Check Your Result: 23 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    session_id,
    session_date,
    customer_id
FROM website_sessions
WHERE EXTRACT(ISODOW FROM session_date) IN (6, 7);

