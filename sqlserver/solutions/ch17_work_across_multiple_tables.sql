-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 17 - Work Across Multiple Tables
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 118 - Employee Reporting Directory
-- Check Your Result: 16 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    m.employee_name AS manager_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
LEFT JOIN employees m
    ON e.manager_id = m.employee_id
ORDER BY
    d.department_name,
    e.employee_name;

-- ----------------------------------------------------------------------
-- Exercise 119 - Product Sales by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    cat.category_name,
    SUM(oi.quantity) AS units_sold
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
JOIN categories AS cat
    ON p.category_id = cat.category_id
WHERE o.status = 'Completed'
GROUP BY cat.category_name
ORDER BY units_sold DESC;

-- ----------------------------------------------------------------------
-- Exercise 120 - Revenue by Product
-- Check Your Result: 23 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS product_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY product_revenue DESC;

-- ----------------------------------------------------------------------
-- Exercise 121 - Catalogue Value vs Actual Revenue by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    cat.category_name,
    SUM(oi.quantity * p.price) AS catalogue_value,
    SUM(oi.quantity * oi.unit_price) AS actual_revenue,
    SUM(oi.quantity * p.price)
        - SUM(oi.quantity * oi.unit_price) AS price_difference
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
JOIN categories AS cat
    ON p.category_id = cat.category_id
WHERE o.status = 'Completed'
GROUP BY cat.category_name
ORDER BY price_difference DESC;

-- ----------------------------------------------------------------------
-- Exercise 122 - Customer Revenue by Country
-- Check Your Result: 17 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.country,
    SUM(o.total_amount) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.country
ORDER BY total_revenue DESC;

-- ----------------------------------------------------------------------
-- Exercise 123 - Successful Collections by Country and Payment Method
-- Check Your Result: 45 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.country,
    p.payment_method,
    COUNT(*) AS successful_payments,
    SUM(p.amount) AS total_collected
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN payments AS p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Successful'
GROUP BY
    c.country,
    p.payment_method
ORDER BY
    c.country,
    total_collected DESC;

-- ----------------------------------------------------------------------
-- Exercise 124 - Supplier Product Catalogue
-- Check Your Result: 30 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    s.supplier_name,
    p.product_name,
    p.price
FROM suppliers AS s
JOIN product_suppliers AS ps
    ON s.supplier_id = ps.supplier_id
JOIN products AS p
    ON ps.product_id = p.product_id
ORDER BY
    s.supplier_name,
    p.product_name;

-- ----------------------------------------------------------------------
-- Exercise 125 - Supplier Coverage by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    cat.category_name,
    COUNT(DISTINCT ps.supplier_id) AS supplier_count
FROM categories AS cat
JOIN products AS p
    ON cat.category_id = p.category_id
JOIN product_suppliers AS ps
    ON p.product_id = ps.product_id
GROUP BY cat.category_name
ORDER BY supplier_count DESC;

-- ----------------------------------------------------------------------
-- Exercise 126 - Customer Purchase Detail
-- Check Your Result: 384 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_name,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
ORDER BY
    c.customer_name,
    o.order_date;

-- ----------------------------------------------------------------------
-- Exercise 127 - Orders Containing Products from Multiple Categories
-- Check Your Result: 125 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    o.customer_id,
    COUNT(DISTINCT p.category_id) AS category_count
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    o.order_id,
    o.customer_id
HAVING COUNT(DISTINCT p.category_id) >= 2
ORDER BY
    category_count DESC,
    o.order_id;

