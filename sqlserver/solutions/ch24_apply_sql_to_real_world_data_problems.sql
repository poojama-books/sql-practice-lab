-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 24 - Apply SQL to Real-World Data Problems
-- ======================================================================

-- ----------------------------------------------------------------------
-- Analyst Challenge 15 - Employee Hiring Period Distribution
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
WITH classified_employees AS (
    SELECT
        employee_id,
        CASE
            WHEN hire_date IS NULL THEN 'Unknown'
            WHEN hire_date < '2020-01-01' THEN 'Before 2020'
            WHEN hire_date < '2022-01-01' THEN '2020-2021'
            ELSE '2022 Onward'
        END AS hiring_period
    FROM employees
),
period_counts AS (
    SELECT
        hiring_period,
        COUNT(*) AS employee_count
    FROM classified_employees
    GROUP BY hiring_period
)
SELECT
    hiring_period,
    employee_count,
    ROUND(
        100.0 * employee_count
        / NULLIF(SUM(employee_count) OVER (), 0),
        2
    ) AS workforce_percentage
FROM period_counts
ORDER BY
    CASE hiring_period
        WHEN 'Before 2020' THEN 1
        WHEN '2020-2021' THEN 2
        WHEN '2022 Onward' THEN 3
        ELSE 4
    END;

-- ----------------------------------------------------------------------
-- Analyst Challenge 16 - Build a Unified Activity Log
-- Check Your Result: 463 rows
-- ----------------------------------------------------------------------
-- Solution
WITH unified_activity AS (
    SELECT
        'Order' AS event_type,
        o.order_id AS event_id,
        o.order_date AS event_date,
        o.customer_id,
        o.status AS event_detail
    FROM orders AS o

    UNION ALL

    SELECT
        'Payment' AS event_type,
        p.payment_id AS event_id,
        p.payment_date AS event_date,
        o.customer_id,
        p.payment_status AS event_detail
    FROM payments AS p
    JOIN orders AS o
        ON p.order_id = o.order_id
    WHERE p.payment_date IS NOT NULL

    UNION ALL

    SELECT
        'Website Session' AS event_type,
        ws.session_id AS event_id,
        ws.session_date AS event_date,
        ws.customer_id,
        ws.device_type AS event_detail
    FROM website_sessions AS ws
)
SELECT
    event_date,
    event_type,
    event_id,
    customer_id,
    event_detail
FROM unified_activity
ORDER BY event_date, event_type, event_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 17 - Audit Order Totals Against Line-Item Totals
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
WITH item_totals AS (
    SELECT
        order_id,
        COUNT(*) AS item_count,
        SUM(quantity * unit_price) AS item_total
    FROM order_items
    GROUP BY order_id
)
SELECT
    o.order_id,
    o.status AS order_status,
    o.total_amount AS recorded_total,
    COALESCE(it.item_total, 0) AS item_total,
    ROUND(
        o.total_amount - COALESCE(it.item_total, 0),
        2
    ) AS total_difference,
    CASE
        WHEN it.order_id IS NULL THEN 'No Line Items'
        WHEN ROUND(o.total_amount - it.item_total, 2) = 0
            THEN 'Matched'
        ELSE 'Mismatch'
    END AS audit_status
FROM orders AS o
LEFT JOIN item_totals AS it
    ON o.order_id = it.order_id
ORDER BY o.order_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 18 - Manager Workload and Team Structure
-- Check Your Result: 6 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    m.employee_id AS manager_id,
    m.employee_name AS manager_name,
    COUNT(r.employee_id) AS direct_reports,
    ROUND(
        AVG(r.salary), 2
    ) AS average_report_salary,
    COUNT(DISTINCT r.department_id)
        AS departments_represented
FROM employees AS m
JOIN employees AS r
    ON m.employee_id = r.manager_id
GROUP BY
    m.employee_id,
    m.employee_name
ORDER BY
    direct_reports DESC,
    manager_name;

-- ----------------------------------------------------------------------
-- Analyst Challenge 19 - Compare Transaction Prices with Catalogue Prices
-- Check Your Result: 384 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    oi.order_item_id,
    oi.order_id,
    p.product_name,
    oi.unit_price AS recorded_unit_price,
    p.price AS current_catalogue_price,
    ROUND(
        oi.unit_price - p.price,
        2
    ) AS price_difference,
    ROUND(
        100.0 * (oi.unit_price - p.price)
        / NULLIF(p.price, 0),
        2
    ) AS price_difference_percentage
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
ORDER BY
    ABS(oi.unit_price - p.price) DESC,
    oi.order_item_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 20 - Website Engagement Coverage by Signup Year
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
WITH session_activity AS (
    SELECT
        customer_id,
        COUNT(*) AS session_count
    FROM website_sessions
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
),
customer_activity AS (
    SELECT
        YEAR(c.signup_date) AS signup_year,
        c.customer_id,
        COALESCE(sa.session_count, 0) AS session_count
    FROM customers AS c
    LEFT JOIN session_activity AS sa
        ON c.customer_id = sa.customer_id
)
SELECT
    signup_year,
    COUNT(*) AS registered_customers,
    SUM(
        CASE WHEN session_count > 0 THEN 1 ELSE 0 END
    ) AS customers_with_sessions,
    SUM(session_count) AS total_sessions,
    ROUND(
        100.0 * SUM(
            CASE WHEN session_count > 0 THEN 1 ELSE 0 END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS engagement_coverage_percentage
FROM customer_activity
GROUP BY signup_year
ORDER BY signup_year;

-- ----------------------------------------------------------------------
-- Analyst Challenge 21 - Detect Gaps in the Paid-Order Sequence
-- Check Your Result: 22 rows
-- ----------------------------------------------------------------------
-- Solution
WITH paid_orders AS (
    SELECT
        order_id,
        LAG(order_id) OVER (
            ORDER BY order_id
        ) AS previous_paid_order_id
    FROM payments
)
SELECT
    previous_paid_order_id,
    order_id AS next_paid_order_id,
    previous_paid_order_id + 1 AS first_unpaid_id,
    order_id - 1 AS last_unpaid_id,
    order_id - previous_paid_order_id - 1
        AS unpaid_order_count
FROM paid_orders
WHERE previous_paid_order_id IS NOT NULL
  AND order_id > previous_paid_order_id + 1
ORDER BY previous_paid_order_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 22 - Build a Consolidated Data Quality Report
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
WITH order_checks AS (
    SELECT
        COUNT(*) AS orders_checked,
        SUM(
            CASE WHEN total_amount < 0 THEN 1 ELSE 0 END
        ) AS negative_order_totals
    FROM orders
),
item_checks AS (
    SELECT
        COUNT(*) AS items_checked,
        SUM(
            CASE
                WHEN quantity <= 0 OR unit_price < 0
                    THEN 1
                ELSE 0
            END
        ) AS invalid_item_rows
    FROM order_items
),
product_checks AS (
    SELECT
        COUNT(*) AS products_checked,
        SUM(
            CASE
                WHEN price < 0 OR stock_quantity < 0
                    THEN 1
                ELSE 0
            END
        ) AS invalid_product_rows
    FROM products
),
employee_checks AS (
    SELECT
        COUNT(*) AS employees_checked,
        SUM(
            CASE
                WHEN manager_id = employee_id THEN 1
                ELSE 0
            END
        ) AS self_managing_employees
    FROM employees
)
SELECT
    oc.orders_checked,
    COALESCE(oc.negative_order_totals, 0)
        AS negative_order_totals,
    ic.items_checked,
    COALESCE(ic.invalid_item_rows, 0)
        AS invalid_item_rows,
    pc.products_checked,
    COALESCE(pc.invalid_product_rows, 0)
        AS invalid_product_rows,
    ec.employees_checked,
    COALESCE(ec.self_managing_employees, 0)
        AS self_managing_employees
FROM order_checks AS oc
CROSS JOIN item_checks AS ic
CROSS JOIN product_checks AS pc
CROSS JOIN employee_checks AS ec;

