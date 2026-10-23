-- The SQL Practice Lab - PostgreSQL solutions
-- Author: Pooja M A
-- Run novacart_postgresql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for PostgreSQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 19 - Add Business Logic with CASE
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 134 - Classify Order Processing State
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    status,
    CASE
        WHEN status = 'Completed' THEN 'Closed'
        WHEN status = 'Pending' THEN 'Open'
        WHEN status IN ('Cancelled', 'Returned') THEN 'Exception'
        ELSE 'Other'
    END AS processing_state
FROM orders;

-- ----------------------------------------------------------------------
-- Exercise 135 - Classify Customers by Signup Period
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    signup_date,
    CASE
        WHEN signup_date < '2025-01-01' THEN 'Established'
        ELSE 'Recent'
    END AS signup_group
FROM customers
ORDER BY signup_date;

-- ----------------------------------------------------------------------
-- Exercise 136 - Build an Inventory Status Report
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity < 20 THEN 'Low Stock'
        WHEN stock_quantity <= 100 THEN 'Available'
        ELSE 'Well Stocked'
    END AS stock_status
FROM products
ORDER BY stock_quantity;

