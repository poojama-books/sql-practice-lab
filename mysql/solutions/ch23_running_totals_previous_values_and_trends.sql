-- The SQL Practice Lab - MySQL solutions
-- Author: Pooja M A
-- Run novacart_mysql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for MySQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 23 - Running Totals, Previous Values and Trends
-- ======================================================================

-- ----------------------------------------------------------------------
-- Analyst Challenge 8 - Running Successful Payments by Payment Method
-- Check Your Result: 146 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_method,
    payment_id,
    order_id,
    payment_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY payment_method
        ORDER BY payment_date, payment_id
    ) AS running_collected
FROM payments
WHERE payment_status = 'Successful'
ORDER BY
    payment_method,
    payment_date,
    payment_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 9 - Cumulative Customer Signups by Month
-- Check Your Result: 18 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_signups AS (
    SELECT
        EXTRACT(YEAR FROM signup_date) AS signup_year,
        EXTRACT(MONTH FROM signup_date) AS signup_month,
        COUNT(*) AS new_customers
    FROM customers
    GROUP BY
        EXTRACT(YEAR FROM signup_date),
        EXTRACT(MONTH FROM signup_date)
)
SELECT
    signup_year,
    signup_month,
    new_customers,
    SUM(new_customers) OVER (
        ORDER BY signup_year, signup_month
    ) AS cumulative_customers
FROM monthly_signups
ORDER BY signup_year, signup_month;

-- ----------------------------------------------------------------------
-- Analyst Challenge 10 - Change in Monthly Website Sessions
-- Check Your Result: 30 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_sessions AS (
    SELECT
        EXTRACT(YEAR FROM session_date) AS session_year,
        EXTRACT(MONTH FROM session_date) AS session_month,
        COUNT(*) AS sessions
    FROM website_sessions
    GROUP BY
        EXTRACT(YEAR FROM session_date),
        EXTRACT(MONTH FROM session_date)
)
SELECT
    session_year,
    session_month,
    sessions,
    LAG(sessions) OVER (
        ORDER BY session_year, session_month
    ) AS previous_sessions,
    sessions - LAG(sessions) OVER (
        ORDER BY session_year, session_month
    ) AS session_change
FROM monthly_sessions
ORDER BY session_year, session_month;

-- ----------------------------------------------------------------------
-- Analyst Challenge 11 - Month-over-Month Growth in Successful Payment Count
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_payments AS (
    SELECT
        EXTRACT(YEAR FROM payment_date) AS payment_year,
        EXTRACT(MONTH FROM payment_date) AS payment_month,
        COUNT(*) AS successful_payments
    FROM payments
    WHERE payment_status = 'Successful'
    GROUP BY
        EXTRACT(YEAR FROM payment_date),
        EXTRACT(MONTH FROM payment_date)
),
comparison AS (
    SELECT
        payment_year,
        payment_month,
        successful_payments,
        LAG(successful_payments) OVER (
            ORDER BY payment_year, payment_month
        ) AS previous_payments
    FROM monthly_payments
)
SELECT
    payment_year,
    payment_month,
    successful_payments,
    previous_payments,
    ROUND(
        100.0 * (successful_payments - previous_payments)
        / NULLIF(previous_payments, 0),
        2
    ) AS growth_percentage
FROM comparison
ORDER BY payment_year, payment_month;

-- ----------------------------------------------------------------------
-- Analyst Challenge 12 - Customer Running Spend
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS cumulative_spend
FROM orders
WHERE status = 'Completed'
ORDER BY customer_id, order_date, order_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 13 - Compare Each Purchase with the Previous One
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS previous_order_value
FROM orders
WHERE status = 'Completed'
ORDER BY customer_id, order_date, order_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 14 - Classify Monthly Revenue Trend
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_revenue AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        EXTRACT(MONTH FROM order_date) AS order_month,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE status = 'Completed'
    GROUP BY
        EXTRACT(YEAR FROM order_date),
        EXTRACT(MONTH FROM order_date)
),
comparison AS (
    SELECT
        order_year,
        order_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY order_year, order_month
        ) AS previous_revenue
    FROM monthly_revenue
)
SELECT
    order_year,
    order_month,
    revenue,
    previous_revenue,
    CASE
        WHEN previous_revenue IS NULL THEN 'No Prior Period'
        WHEN revenue > previous_revenue THEN 'Growth'
        WHEN revenue < previous_revenue THEN 'Decline'
        ELSE 'No Change'
    END AS trend
FROM comparison
ORDER BY order_year, order_month;

