-- The SQL Practice Lab - MySQL solutions
-- Author: Pooja M A
-- Run novacart_mysql.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for MySQL and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 20 - Solve Problems with Subqueries
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 137 - Successful Payments Above the Average Successful Payment
-- Check Your Result: 55 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_id,
    order_id,
    payment_method,
    amount
FROM payments
WHERE payment_status = 'Successful'
  AND amount > (
      SELECT AVG(amount)
      FROM payments
      WHERE payment_status = 'Successful'
  )
ORDER BY amount DESC;

-- ----------------------------------------------------------------------
-- Exercise 138 - Employees Above Company Average Salary
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;

-- ----------------------------------------------------------------------
-- Exercise 139 - Suppliers Linked to at Least One Product
-- Check Your Result: 8 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    s.supplier_id,
    s.supplier_name,
    s.country
FROM suppliers AS s
WHERE EXISTS (
    SELECT 1
    FROM product_suppliers AS ps
    WHERE ps.supplier_id = s.supplier_id
);

-- ----------------------------------------------------------------------
-- Exercise 140 - Products With No Completed Sales in Q3 2026
-- Check Your Result: 6 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_id,
    p.product_name
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items AS oi
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE oi.product_id = p.product_id
      AND o.status = 'Completed'
      AND o.order_date >= '2026-07-01'
)
ORDER BY p.product_id;

-- ----------------------------------------------------------------------
-- Exercise 141 - Employees Who Manage at Least One Person
-- Check Your Result: 6 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    e.employee_id,
    e.employee_name
FROM employees AS e
WHERE EXISTS (
    SELECT 1
    FROM employees AS r
    WHERE r.manager_id = e.employee_id
);

-- ----------------------------------------------------------------------
-- Exercise 142 - Customers with High-Value Orders
-- Check Your Result: 9 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > 1000
);

-- ----------------------------------------------------------------------
-- Exercise 143 - Departments Above Average Salary Level
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    department_id,
    ROUND(AVG(salary), 2) AS department_average
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees
);

-- ----------------------------------------------------------------------
-- Exercise 144 - Payment Methods with Above-Average Transaction Value
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_method,
    ROUND(AVG(amount), 2) AS average_payment
FROM payments
GROUP BY payment_method
HAVING AVG(amount) > (
    SELECT AVG(amount)
    FROM payments
)
ORDER BY average_payment DESC;

-- ----------------------------------------------------------------------
-- Exercise 145 - Products with Stock Below the Overall Average
-- Check Your Result: 17 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < (
    SELECT AVG(stock_quantity * 1.0)
    FROM products
)
ORDER BY stock_quantity;

