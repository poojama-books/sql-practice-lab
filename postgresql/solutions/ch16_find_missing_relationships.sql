-- The SQL Practice Lab - PostgreSQL solutions
-- Author: Pooja M A
-- Run novacart_postgresql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for PostgreSQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 16 - Find Missing Relationships
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 110 - Customers Without Orders
-- Check Your Result: 6 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    c.signup_date
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- ----------------------------------------------------------------------
-- Exercise 111 - Products Never Ordered
-- Check Your Result: 4 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products AS p
LEFT JOIN order_items AS oi
    ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- ----------------------------------------------------------------------
-- Exercise 112 - Orders Without Payments
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM orders AS o
LEFT JOIN payments AS p
    ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;

-- ----------------------------------------------------------------------
-- Exercise 113 - Customers Without Website Activity
-- Check Your Result: 11 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN website_sessions ws
    ON c.customer_id = ws.customer_id
WHERE ws.session_id IS NULL
ORDER BY c.customer_id;

-- ----------------------------------------------------------------------
-- Exercise 114 - Suppliers Without Products
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    s.supplier_id,
    s.supplier_name
FROM suppliers AS s
LEFT JOIN product_suppliers AS ps
    ON s.supplier_id = ps.supplier_id
WHERE ps.product_id IS NULL;

-- ----------------------------------------------------------------------
-- Exercise 115 - Employees Without Direct Reports
-- Check Your Result: 10 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    e.employee_id,
    e.employee_name
FROM employees e
LEFT JOIN employees r
    ON e.employee_id = r.manager_id
WHERE r.employee_id IS NULL
ORDER BY e.employee_id;

-- ----------------------------------------------------------------------
-- Exercise 116 - Categories Without Products
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.category_id,
    c.category_name
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
WHERE p.product_id IS NULL
ORDER BY c.category_id;

-- ----------------------------------------------------------------------
-- Exercise 117 - Completed Orders Without Successful Payments
-- Check Your Result: 4 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_amount
FROM orders o
LEFT JOIN payments p
    ON o.order_id = p.order_id
   AND p.payment_status = 'Successful'
WHERE o.status = 'Completed'
  AND p.payment_id IS NULL
ORDER BY o.order_date;

