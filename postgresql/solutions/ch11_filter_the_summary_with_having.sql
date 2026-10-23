-- The SQL Practice Lab - PostgreSQL solutions
-- Author: Pooja M A
-- Run novacart_postgresql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for PostgreSQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 11 - Filter the Summary with HAVING
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 64 - Products Appearing in More Than 15 Orders
-- Check Your Result: 13 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    COUNT(DISTINCT order_id) AS order_count
FROM order_items
GROUP BY product_id
HAVING COUNT(DISTINCT order_id) > 15
ORDER BY order_count DESC, product_id;

-- ----------------------------------------------------------------------
-- Exercise 65 - Product Categories with High Inventory Levels
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    category_id,
    SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category_id
HAVING SUM(stock_quantity) > 100
ORDER BY total_stock DESC;

-- ----------------------------------------------------------------------
-- Exercise 66 - Traffic Sources with More Than 5 Sessions
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    traffic_source,
    COUNT(*) AS total_sessions
FROM website_sessions
GROUP BY traffic_source
HAVING COUNT(*) > 5
ORDER BY total_sessions DESC;

-- ----------------------------------------------------------------------
-- Exercise 67 - Departments with High Average Salary
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    department_id,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 90000
ORDER BY average_salary DESC;

-- ----------------------------------------------------------------------
-- Exercise 68 - Categories with Large Product Ranges
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    category_id,
    COUNT(*) AS total_products
FROM products
GROUP BY category_id
HAVING COUNT(*) >= 4;

-- ----------------------------------------------------------------------
-- Exercise 69 - Customers with Multiple Completed Orders
-- Check Your Result: 15 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'Completed'
GROUP BY customer_id
HAVING COUNT(*) >= 3
ORDER BY completed_orders DESC;

-- ----------------------------------------------------------------------
-- Exercise 70 - Products with Multiple Suppliers
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    COUNT(DISTINCT supplier_id) AS supplier_count
FROM product_suppliers
GROUP BY product_id
HAVING COUNT(DISTINCT supplier_id) > 1
ORDER BY supplier_count DESC, product_id;

-- ----------------------------------------------------------------------
-- Exercise 71 - Customers with High Average Order Value
-- Check Your Result: 6 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    COUNT(*) AS completed_orders,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed'
GROUP BY customer_id
HAVING AVG(total_amount) > 350
ORDER BY average_order_value DESC;

