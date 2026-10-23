-- The SQL Practice Lab - MySQL solutions
-- Author: Pooja M A
-- Run novacart_mysql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for MySQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 14 - Build a Business Report
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 92 - Payment Status Health Report
-- Check Your Result: 4 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_status,
    COUNT(*) AS payment_count,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS average_payment
FROM payments
GROUP BY payment_status
ORDER BY total_amount DESC;

-- ----------------------------------------------------------------------
-- Exercise 93 - Monthly Sales Summary
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Exercise 94 - Inventory Position by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    category_id,
    COUNT(*) AS product_count,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(SUM(price * stock_quantity), 2) AS inventory_value
FROM products
GROUP BY category_id
ORDER BY inventory_value DESC;

-- ----------------------------------------------------------------------
-- Exercise 95 - Inventory Risk Report
-- Check Your Result: 10 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    product_name,
    stock_quantity,
    price,
    stock_quantity * price AS inventory_value
FROM products
WHERE stock_quantity < 25
ORDER BY stock_quantity ASC;

-- ----------------------------------------------------------------------
-- Exercise 96 - Customer Signup Quality Report
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    EXTRACT(YEAR FROM signup_date) AS signup_year,
    COUNT(*) AS total_customers,
    COUNT(email) AS customers_with_email,
    COUNT(*) - COUNT(email) AS missing_email,
    MIN(signup_date) AS first_signup,
    MAX(signup_date) AS latest_signup
FROM customers
GROUP BY EXTRACT(YEAR FROM signup_date)
ORDER BY signup_year;

-- ----------------------------------------------------------------------
-- Exercise 97 - Website Traffic Report
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    traffic_source,
    COUNT(*) AS total_sessions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT customer_id), 2)
        AS sessions_per_customer
FROM website_sessions
GROUP BY traffic_source
ORDER BY total_sessions DESC;

-- ----------------------------------------------------------------------
-- Exercise 98 - Department Workforce Summary
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    department_id,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;

-- ----------------------------------------------------------------------
-- Exercise 99 - High-Activity Customer Report
-- Check Your Result: 14 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    COUNT(*) AS completed_orders,
    SUM(total_amount) AS total_spent,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed'
GROUP BY customer_id
HAVING COUNT(*) >= 5
ORDER BY total_spent DESC;

-- ----------------------------------------------------------------------
-- Exercise 100 - Executive Customer Snapshot
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS total_customers,
    COUNT(email) AS customers_with_email,
    COUNT(DISTINCT country) AS countries,
    MIN(signup_date) AS first_signup,
    MAX(signup_date) AS latest_signup
FROM customers;

