-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 27 - SQL Interview Lab
-- ======================================================================

-- ----------------------------------------------------------------------
-- Interview Challenge 1 - Find the Second-Highest Salary
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);

-- Alternative with DENSE_RANK()
WITH ranked_salaries AS (
    SELECT
        salary,
        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT DISTINCT salary
FROM ranked_salaries
WHERE salary_rank = 2;

-- ----------------------------------------------------------------------
-- Interview Challenge 2 - Find the Nth-Highest Salary
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
WITH ranked_employees AS (
    SELECT
        employee_name,
        salary,
        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT
    employee_name,
    salary
FROM ranked_employees
WHERE salary_rank = 3;

-- ----------------------------------------------------------------------
-- Interview Challenge 3 - Find Duplicate Records
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    email,
    COUNT(*) AS occurrences
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;

-- ----------------------------------------------------------------------
-- Interview Challenge 4 - Employees Earning More Than Their Managers
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    e.employee_name,
    e.salary AS employee_salary,
    m.employee_name AS manager_name,
    m.salary AS manager_salary
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

-- ----------------------------------------------------------------------
-- Interview Challenge 5 - Top Three Products in Every Category
-- Check Your Result: 21 rows
-- ----------------------------------------------------------------------
-- Solution
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category_id,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    JOIN products AS p
        ON oi.product_id = p.product_id
    WHERE o.status = 'Completed'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category_id
),
ranked_products AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY category_id
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM product_revenue
)
SELECT
    product_name,
    category_id,
    revenue,
    revenue_rank
FROM ranked_products
WHERE revenue_rank <= 3
ORDER BY category_id, revenue_rank;

-- ----------------------------------------------------------------------
-- Interview Challenge 6 - Customers with Orders but No Successful Payment
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM orders AS o
    JOIN payments AS p
        ON o.order_id = p.order_id
    WHERE o.customer_id = c.customer_id
      AND p.payment_status = 'Successful'
);

-- ----------------------------------------------------------------------
-- Interview Challenge 7 - Orders Greater Than the Customer's Previous Order
-- Check Your Result: 99 rows
-- ----------------------------------------------------------------------
-- Solution
WITH order_history AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        total_amount,
        LAG(total_amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
        ) AS previous_amount
    FROM orders
)
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    previous_amount
FROM order_history
WHERE total_amount > previous_amount
ORDER BY customer_id, order_date, order_id;

-- ----------------------------------------------------------------------
-- Interview Challenge 8 - Running Revenue Total
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date, order_id
    ) AS running_revenue
FROM orders
WHERE status = 'Completed'
ORDER BY order_date, order_id;

-- ----------------------------------------------------------------------
-- Interview Challenge 9 - Month-over-Month Revenue Growth
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_revenue AS (
    SELECT
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE status = 'Completed'
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
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
    ROUND(
        100.0 * (revenue - previous_revenue)
        / NULLIF(previous_revenue, 0),
        2
    ) AS growth_percentage
FROM comparison;

-- ----------------------------------------------------------------------
-- Interview Challenge 10 - First Order for Every Customer
-- Check Your Result: 19 rows
-- ----------------------------------------------------------------------
-- Solution
WITH ranked_orders AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
        ) AS order_position
    FROM orders
    WHERE status = 'Completed'
)
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount
FROM ranked_orders
WHERE order_position = 1;

-- ----------------------------------------------------------------------
-- Interview Challenge 11 - Find Customers Purchasing in Consecutive Months
-- Check Your Result: 13 rows
-- ----------------------------------------------------------------------
-- Solution
WITH customer_months AS (
    SELECT DISTINCT
        customer_id,
        DATEFROMPARTS(
            YEAR(order_date), MONTH(order_date), 1
        ) AS order_month
    FROM orders
    WHERE status = 'Completed'
),
comparison AS (
    SELECT
        customer_id,
        order_month,
        LAG(order_month) OVER (
            PARTITION BY customer_id
            ORDER BY order_month
        ) AS previous_month
    FROM customer_months
)
SELECT DISTINCT
    customer_id
FROM comparison
WHERE order_month = DATEADD(MONTH, 1, previous_month);

-- ----------------------------------------------------------------------
-- Interview Challenge 12 - Highest-Paid Employee in Each Department
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT
    employee_name,
    department_id,
    salary
FROM ranked_employees
WHERE salary_rank = 1;

-- ----------------------------------------------------------------------
-- Interview Challenge 13 - Products Above Their Category Average
-- Check Your Result: 10 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_name,
    p.category_id,
    p.price
FROM products AS p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products AS p2
    WHERE p2.category_id = p.category_id
);

-- ----------------------------------------------------------------------
-- Interview Challenge 14 - Revenue Contribution by Customer
-- Check Your Result: 19 rows
-- ----------------------------------------------------------------------
-- Solution
WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE status = 'Completed'
    GROUP BY customer_id
)
SELECT
    customer_id,
    revenue,
    ROUND(
        100.0 * revenue / SUM(revenue) OVER (),
        2
    ) AS revenue_share
FROM customer_revenue
ORDER BY revenue DESC;

-- ----------------------------------------------------------------------
-- Interview Challenge 15 - Detect Consecutive Revenue Declines
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_revenue AS (
    SELECT
        DATEPART(YEAR, order_date) AS order_year,
        DATEPART(MONTH, order_date) AS order_month,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE status = 'Completed'
    GROUP BY
        DATEPART(YEAR, order_date),
        DATEPART(MONTH, order_date)
),
comparison AS (
    SELECT
        order_year,
        order_month,
        revenue,
        LAG(revenue, 1) OVER (
            ORDER BY order_year, order_month
        ) AS previous_revenue,
        LAG(revenue, 2) OVER (
            ORDER BY order_year, order_month
        ) AS two_months_back
    FROM monthly_revenue
)
SELECT
    order_year,
    order_month,
    two_months_back,
    previous_revenue,
    revenue
FROM comparison
WHERE revenue < previous_revenue
  AND previous_revenue < two_months_back
ORDER BY order_year, order_month;

