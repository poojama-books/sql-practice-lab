-- The SQL Practice Lab - PostgreSQL solutions
-- Author: Pooja M A
-- Run novacart_postgresql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for PostgreSQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 18 - Avoid the Duplicate Row Trap
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 128 - Count Customers Correctly
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(DISTINCT c.customer_id) AS ordering_customers
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- ----------------------------------------------------------------------
-- Exercise 129 - Calculate Average Order Value at the Order Grain
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed';

-- Incorrect Approach (for comparison - do not run)
/*
SELECT
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';
*/

-- ----------------------------------------------------------------------
-- Exercise 130 - Calculate Average Selling Price Correctly
-- Check Your Result: 23 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    ROUND(AVG(oi.unit_price), 2) AS simple_average_price,
    ROUND(
        SUM(oi.quantity * oi.unit_price) / SUM(oi.quantity),
        2
    ) AS average_selling_price
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY average_selling_price DESC;

-- ----------------------------------------------------------------------
-- Exercise 131 - Avoid Inflated Customer Revenue
-- Check Your Result: 19 rows
-- ----------------------------------------------------------------------
-- Correct query
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name;

-- Incorrect Approach (for comparison - do not run)
/*
SELECT
    c.customer_name,
    SUM(o.total_amount)
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name;
*/

-- ----------------------------------------------------------------------
-- Exercise 132 - Count Products Correctly After a Supplier Join
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    cat.category_name,
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT p.product_id) AS products_with_suppliers
FROM categories AS cat
JOIN products AS p
    ON cat.category_id = p.category_id
JOIN product_suppliers AS ps
    ON p.product_id = ps.product_id
GROUP BY cat.category_name
ORDER BY joined_rows DESC;

-- ----------------------------------------------------------------------
-- Exercise 133 - Compare Row Count and Unique Order Count
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS joined_row_count,
    COUNT(DISTINCT o.order_id) AS unique_order_count
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;

