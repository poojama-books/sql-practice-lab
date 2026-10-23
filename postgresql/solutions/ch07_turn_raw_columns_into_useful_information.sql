-- The SQL Practice Lab - PostgreSQL solutions
-- Author: Pooja M A
-- Run novacart_postgresql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for PostgreSQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 7 - Turn Raw Columns into Useful Information
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 24 - Value of Multi-Unit Order Lines
-- Check Your Result: 25 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price AS line_value
FROM order_items
WHERE quantity >= 3
ORDER BY line_value DESC;

-- ----------------------------------------------------------------------
-- Exercise 25 - Discounted Product Price
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    price,
    price * 0.85 AS discounted_price
FROM products;

-- ----------------------------------------------------------------------
-- Exercise 26 - Discount Amount
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    price,
    price * 0.20 AS discount_amount
FROM products;

-- ----------------------------------------------------------------------
-- Exercise 27 - Restock Cost to Reach 50 Units
-- Check Your Result: 20 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    stock_quantity,
    price,
    50 - stock_quantity AS units_to_order,
    (50 - stock_quantity) * price AS restock_cost
FROM products
WHERE stock_quantity < 50
ORDER BY restock_cost DESC;

-- ----------------------------------------------------------------------
-- Exercise 28 - Price After an Increase
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    price,
    price * 1.12 AS revised_price
FROM products;

-- ----------------------------------------------------------------------
-- Exercise 29 - Salary Gap to the Next Band
-- Check Your Result: 11 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_id,
    employee_name,
    salary,
    100000 - salary AS gap_to_band,
    ROUND(salary * 100.0 / 100000, 1) AS percent_of_band
FROM employees
WHERE salary < 100000
ORDER BY gap_to_band DESC;

-- ----------------------------------------------------------------------
-- Exercise 30 - Estimated Service Charge
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    total_amount,
    total_amount * 0.05 AS service_charge
FROM orders;

-- ----------------------------------------------------------------------
-- Exercise 31 - Total After Service Charge
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    total_amount,
    total_amount + (total_amount * 0.05) AS final_amount
FROM orders;

-- Alternative
SELECT
    order_id,
    total_amount,
    total_amount * 1.05 AS final_amount
FROM orders;

