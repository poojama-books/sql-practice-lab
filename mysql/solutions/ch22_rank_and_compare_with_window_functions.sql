-- The SQL Practice Lab - MySQL solutions
-- Author: Pooja M A
-- Run novacart_mysql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for MySQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 22 - Rank and Compare with Window Functions
-- ======================================================================

-- ----------------------------------------------------------------------
-- Analyst Challenge 1 - Rank Products by Stock Level
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    stock_quantity,
    RANK() OVER (
        ORDER BY stock_quantity ASC
    ) AS stock_risk_rank
FROM products
ORDER BY stock_risk_rank, product_name;

-- ----------------------------------------------------------------------
-- Analyst Challenge 2 - Unique Salary Positions
-- Check Your Result: 16 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_name,
    salary,
    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS salary_position
FROM employees;

-- ----------------------------------------------------------------------
-- Analyst Challenge 3 - Rank Orders Within Each Customer
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    order_id,
    total_amount,
    RANK() OVER (
        PARTITION BY customer_id
        ORDER BY total_amount DESC
    ) AS customer_order_rank
FROM orders
ORDER BY customer_id, customer_order_rank, order_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 4 - Products' Share of Category Inventory Value
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    product_name,
    category_id,
    CAST(price * stock_quantity AS DECIMAL(18, 2))
        AS inventory_value,
    CAST(
        SUM(price * stock_quantity)
            OVER (PARTITION BY category_id)
        AS DECIMAL(18, 2)
    ) AS category_inventory_value,
    CAST(
        100.0 * (price * stock_quantity)
        / NULLIF(
            SUM(price * stock_quantity)
                OVER (PARTITION BY category_id),
            0
        )
        AS DECIMAL(18, 2)
    ) AS category_value_percentage
FROM products
ORDER BY
    category_id,
    inventory_value DESC;

-- ----------------------------------------------------------------------
-- Analyst Challenge 5 - Order Value Percentile
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    CAST(
        CUME_DIST() OVER (
            ORDER BY total_amount
        ) * 100 AS DECIMAL(10, 2)
    ) AS order_value_percentile
FROM orders
ORDER BY total_amount;

-- ----------------------------------------------------------------------
-- Analyst Challenge 6 - Rank Suppliers by Product Coverage
-- Check Your Result: 8 rows
-- ----------------------------------------------------------------------
-- Solution
WITH supplier_coverage AS (
    SELECT
        s.supplier_id,
        s.supplier_name,
        COUNT(DISTINCT ps.product_id) AS product_count
    FROM suppliers AS s
    JOIN product_suppliers AS ps
        ON s.supplier_id = ps.supplier_id
    GROUP BY
        s.supplier_id,
        s.supplier_name
)
SELECT
    supplier_id,
    supplier_name,
    product_count,
    RANK() OVER (
        ORDER BY product_count DESC
    ) AS supplier_rank
FROM supplier_coverage
ORDER BY supplier_rank, supplier_name;

-- ----------------------------------------------------------------------
-- Analyst Challenge 7 - Compare Salary with Department Average
-- Check Your Result: 16 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_name,
    department_id,
    salary,
    ROUND(
        AVG(salary) OVER (
            PARTITION BY department_id
        ),
        2
    ) AS department_average
FROM employees;

