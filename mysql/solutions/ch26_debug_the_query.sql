-- The SQL Practice Lab - MySQL solutions
-- Author: Pooja M A
-- Run novacart_mysql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for MySQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 26 - Debug the Query
-- ======================================================================

-- ----------------------------------------------------------------------
-- Debug Challenge 1 - The NULL Comparison
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    customer_id,
    customer_name
FROM customers
WHERE email = NULL;
*/

-- Correct query
SELECT
    customer_id,
    customer_name
FROM customers
WHERE email IS NULL;

-- ----------------------------------------------------------------------
-- Debug Challenge 2 - The Missing GROUP BY
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    status,
    SUM(total_amount) AS revenue
FROM orders;
*/

-- Correct query
SELECT
    status,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY status;

-- ----------------------------------------------------------------------
-- Debug Challenge 3 - WHERE or HAVING?
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    customer_id,
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'Completed'
  AND COUNT(*) >= 5
GROUP BY customer_id;
*/

-- Correct query
SELECT
    customer_id,
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'Completed'
GROUP BY customer_id
HAVING COUNT(*) >= 5;

-- ----------------------------------------------------------------------
-- Debug Challenge 4 - The Wrong Join
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    o.order_id,
    c.customer_name
FROM orders AS o
JOIN customers AS c
    ON o.order_id = c.customer_id;
*/

-- Correct query
SELECT
    o.order_id,
    c.customer_name
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id;

-- ----------------------------------------------------------------------
-- Debug Challenge 5 - Inflated Revenue
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    SUM(o.total_amount) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';
*/

-- Correct query
SELECT
    SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed';

-- If product-level revenue is required
SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';

-- ----------------------------------------------------------------------
-- Debug Challenge 6 - LEFT JOIN That Became an INNER JOIN
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
  AND o.order_id IS NULL;
*/

-- Correct query
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
   AND o.status = 'Completed'
WHERE o.order_id IS NULL;

-- ----------------------------------------------------------------------
-- Debug Challenge 7 - Counting Orders Instead of Customers
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    COUNT(customer_id) AS ordering_customers
FROM orders;
*/

-- Correct query
SELECT
    COUNT(DISTINCT customer_id) AS ordering_customers
FROM orders;

-- ----------------------------------------------------------------------
-- Debug Challenge 8 - Month Grouping Across Years
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date);
*/

-- Correct query
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Debug Challenge 9 - Ranking Without a Partition
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;
*/

-- Correct query
SELECT
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

-- ----------------------------------------------------------------------
-- Debug Challenge 10 - Incorrect Percentage Calculation
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
WITH category_sales AS (
    SELECT
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    JOIN products AS p
        ON oi.product_id = p.product_id
    JOIN categories AS c
        ON p.category_id = c.category_id
    WHERE o.status = 'Completed'
    GROUP BY c.category_name
)
SELECT
    category_name,
    revenue,
    revenue / SUM(revenue) * 100 AS revenue_share
FROM category_sales;
*/

-- Correct query
WITH category_sales AS (
    SELECT
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    JOIN products AS p
        ON oi.product_id = p.product_id
    JOIN categories AS c
        ON p.category_id = c.category_id
    WHERE o.status = 'Completed'
    GROUP BY c.category_name
)
SELECT
    category_name,
    revenue,
    ROUND(
        100.0 * revenue / SUM(revenue) OVER (),
        2
    ) AS revenue_share
FROM category_sales
ORDER BY revenue DESC;

