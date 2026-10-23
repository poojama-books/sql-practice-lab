-- The SQL Practice Lab - MySQL solutions
-- Author: Pooja M A
-- Run novacart_mysql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for MySQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 21 - Break Complex Queries into Steps with CTEs
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 146 - Product Supplier Summary
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
WITH supplier_counts AS (
    SELECT
        product_id,
        COUNT(*) AS supplier_count
    FROM product_suppliers
    GROUP BY product_id
)
SELECT
    p.product_id,
    p.product_name,
    COALESCE(sc.supplier_count, 0) AS supplier_count
FROM products AS p
LEFT JOIN supplier_counts AS sc
    ON p.product_id = sc.product_id
ORDER BY supplier_count DESC, p.product_name;

-- ----------------------------------------------------------------------
-- Exercise 147 - Orders with Large Baskets
-- Check Your Result: 86 rows
-- ----------------------------------------------------------------------
-- Solution
WITH basket_summary AS (
    SELECT
        order_id,
        COUNT(DISTINCT product_id) AS distinct_products,
        SUM(quantity) AS total_units,
        SUM(quantity * unit_price) AS basket_value
    FROM order_items
    GROUP BY order_id
)
SELECT
    order_id,
    distinct_products,
    total_units,
    basket_value
FROM basket_summary
WHERE total_units >= 3
ORDER BY total_units DESC, basket_value DESC;

-- ----------------------------------------------------------------------
-- Exercise 148 - Payment Method Collection Summary
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
WITH payment_summary AS (
    SELECT
        payment_method,
        COUNT(*) AS successful_payments,
        SUM(amount) AS collected_amount,
        ROUND(AVG(amount), 2) AS average_payment
    FROM payments
    WHERE payment_status = 'Successful'
    GROUP BY payment_method
)
SELECT
    payment_method,
    successful_payments,
    collected_amount,
    average_payment
FROM payment_summary
ORDER BY collected_amount DESC;

-- ----------------------------------------------------------------------
-- Exercise 149 - Traffic Sources Above Average Session Volume
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
WITH source_sessions AS (
    SELECT
        traffic_source,
        COUNT(*) AS session_count
    FROM website_sessions
    GROUP BY traffic_source
),
benchmark AS (
    SELECT
        AVG(session_count * 1.0) AS average_source_sessions
    FROM source_sessions
)
SELECT
    ss.traffic_source,
    ss.session_count,
    b.average_source_sessions
FROM source_sessions AS ss
CROSS JOIN benchmark AS b
WHERE ss.session_count > b.average_source_sessions
ORDER BY ss.session_count DESC;

-- ----------------------------------------------------------------------
-- Exercise 150 - Categories with Below-Average Total Stock
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
WITH category_stock AS (
    SELECT
        category_id,
        COUNT(*) AS product_count,
        SUM(stock_quantity) AS total_stock
    FROM products
    GROUP BY category_id
),
benchmark AS (
    SELECT
        AVG(total_stock * 1.0) AS average_category_stock
    FROM category_stock
)
SELECT
    cs.category_id,
    cs.product_count,
    cs.total_stock,
    b.average_category_stock
FROM category_stock AS cs
CROSS JOIN benchmark AS b
WHERE cs.total_stock < b.average_category_stock
ORDER BY cs.total_stock;

