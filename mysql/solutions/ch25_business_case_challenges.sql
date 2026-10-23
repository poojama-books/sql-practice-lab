-- The SQL Practice Lab - MySQL solutions
-- Author: Pooja M A
-- Run novacart_mysql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for MySQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 25 - Business Case Challenges
-- ======================================================================

-- ----------------------------------------------------------------------
-- Business Case 1 - Identify the Most Valuable Customers
-- Check Your Result: 10 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    COUNT(*) AS completed_orders,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.country
ORDER BY total_revenue DESC
LIMIT 10;

-- ----------------------------------------------------------------------
-- Business Case 2 - Find Customers at Risk of Churn
-- Check Your Result: 2 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    MAX(o.order_date) AS last_order_date,
    COUNT(*) AS completed_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.country
HAVING MAX(o.order_date) < '2025-01-01'
ORDER BY last_order_date;

-- ----------------------------------------------------------------------
-- Business Case 3 - Find the Strongest Product Categories
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
WITH category_sales AS (
    SELECT
        c.category_name,
        SUM(oi.quantity) AS units_sold,
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
    units_sold,
    revenue,
    ROUND(
        100.0 * revenue / SUM(revenue) OVER (),
        2
    ) AS revenue_share_percentage
FROM category_sales
ORDER BY revenue DESC;

-- ----------------------------------------------------------------------
-- Business Case 4 - Detect Declining Monthly Revenue
-- Check Your Result: 14 rows
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
    revenue - previous_revenue AS revenue_change
FROM comparison
WHERE revenue < previous_revenue
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Business Case 5 - Identify Products Requiring Attention
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS product_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE p.stock_quantity < 20
  AND o.status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name,
    p.stock_quantity
HAVING SUM(oi.quantity) >= 15
ORDER BY units_sold DESC;

-- ----------------------------------------------------------------------
-- Business Case 6 - Compare Traffic Sources
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
WITH source_sessions AS (
    SELECT
        traffic_source,
        COUNT(*) AS total_sessions
    FROM website_sessions
    GROUP BY traffic_source
)
SELECT
    traffic_source,
    total_sessions,
    ROUND(
        100.0 * total_sessions
        / SUM(total_sessions) OVER (),
        2
    ) AS session_share,
    RANK() OVER (
        ORDER BY total_sessions DESC
    ) AS source_rank
FROM source_sessions
ORDER BY source_rank;

-- ----------------------------------------------------------------------
-- Business Case 7 - Find High-Value Repeat Customers
-- Check Your Result: 9 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(*) AS completed_orders,
    SUM(o.total_amount) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(*) >= 3
   AND SUM(o.total_amount) > 3000
ORDER BY total_spent DESC;

-- ----------------------------------------------------------------------
-- Business Case 8 - Build a Compact Executive Sales View
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_summary AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        EXTRACT(MONTH FROM order_date) AS order_month,
        COUNT(*) AS completed_orders,
        SUM(total_amount) AS revenue,
        ROUND(AVG(total_amount), 2) AS average_order_value,
        COUNT(DISTINCT customer_id) AS unique_customers
    FROM orders
    WHERE status = 'Completed'
    GROUP BY
        EXTRACT(YEAR FROM order_date),
        EXTRACT(MONTH FROM order_date)
),
comparison AS (
    SELECT
        *,
        LAG(revenue) OVER (
            ORDER BY order_year, order_month
        ) AS previous_revenue
    FROM monthly_summary
)
SELECT
    order_year,
    order_month,
    completed_orders,
    revenue,
    average_order_value,
    unique_customers,
    previous_revenue,
    ROUND(
        100.0 * (revenue - previous_revenue)
        / NULLIF(previous_revenue, 0),
        2
    ) AS growth_percentage
FROM comparison
ORDER BY order_year, order_month;

