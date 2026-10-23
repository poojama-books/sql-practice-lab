-- The SQL Practice Lab - PostgreSQL solutions
-- Author: Pooja M A
-- Run novacart_postgresql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for PostgreSQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 13 - Build Time-Based Reports
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 82 - Daily Successful Collections
-- Check Your Result: 136 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_date,
    COUNT(*) AS payments,
    SUM(amount) AS collected_amount
FROM payments
WHERE payment_status = 'Successful'
GROUP BY payment_date
ORDER BY payment_date;

-- ----------------------------------------------------------------------
-- Exercise 83 - Monthly Order Count
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Exercise 84 - Monthly Order Volume by Status
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END)
        AS completed_orders,
    SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END)
        AS pending_orders,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END)
        AS cancelled_orders,
    SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END)
        AS returned_orders
FROM orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Exercise 85 - Monthly Customer Signups
-- Check Your Result: 18 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM signup_date) AS signup_year,
    EXTRACT(MONTH FROM signup_date) AS signup_month,
    COUNT(*) AS new_customers
FROM customers
GROUP BY
    EXTRACT(YEAR FROM signup_date),
    EXTRACT(MONTH FROM signup_date)
ORDER BY signup_year, signup_month;

-- ----------------------------------------------------------------------
-- Exercise 86 - Seasonal Order Activity
-- Check Your Result: 12 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(MONTH FROM order_date) AS month_number,
    TO_CHAR(order_date, 'FMMonth') AS month_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    EXTRACT(MONTH FROM order_date),
    TO_CHAR(order_date, 'FMMonth')
ORDER BY month_number;

-- ----------------------------------------------------------------------
-- Exercise 87 - Order Activity by Day of Week
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(ISODOW FROM order_date) AS day_number,
    TO_CHAR(order_date, 'FMDay') AS day_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    EXTRACT(ISODOW FROM order_date),
    TO_CHAR(order_date, 'FMDay')
ORDER BY day_number;

-- ----------------------------------------------------------------------
-- Exercise 88 - Monthly Payment Activity
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM payment_date) AS payment_year,
    EXTRACT(MONTH FROM payment_date) AS payment_month,
    COUNT(*) AS total_payments
FROM payments
GROUP BY
    EXTRACT(YEAR FROM payment_date),
    EXTRACT(MONTH FROM payment_date)
ORDER BY payment_year, payment_month;

-- ----------------------------------------------------------------------
-- Exercise 89 - Monthly Website Sessions
-- Check Your Result: 30 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM session_date) AS session_year,
    EXTRACT(MONTH FROM session_date) AS session_month,
    COUNT(*) AS total_sessions
FROM website_sessions
GROUP BY
    EXTRACT(YEAR FROM session_date),
    EXTRACT(MONTH FROM session_date)
ORDER BY session_year, session_month;

-- ----------------------------------------------------------------------
-- Exercise 90 - Completed vs Cancelled Orders by Month
-- Check Your Result: 44 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    status,
    COUNT(*) AS total_orders
FROM orders
WHERE status IN ('Completed', 'Cancelled')
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date),
    status
ORDER BY order_year, order_month, status;

-- ----------------------------------------------------------------------
-- Exercise 91 - Monthly Average Order Value
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY order_year, order_month;

