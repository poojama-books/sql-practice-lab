-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

-- ======================================================================
-- CHAPTER 4 - Retrieve the Right Data
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 1 - Customer Directory
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    email
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 2 - Product Catalogue
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    price,
    stock_quantity
FROM products;

-- ----------------------------------------------------------------------
-- Exercise 3 - Employee Overview
-- Check Your Result: 16 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_name AS employee,
    salary AS annual_salary,
    hire_date AS joined_on
FROM employees;

-- ----------------------------------------------------------------------
-- Exercise 4 - Supplier Countries
-- Check Your Result: 8 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT DISTINCT country
FROM suppliers;

-- ----------------------------------------------------------------------
-- Exercise 5 - Payment Methods
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT DISTINCT payment_method
FROM payments;

-- ----------------------------------------------------------------------
-- Exercise 6 - Explore the Payments Table
-- Check Your Result: 180 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT *
FROM payments;

-- ======================================================================
-- CHAPTER 5 - Ask Better Questions with WHERE
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 7 - Completed Orders
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE status = 'Completed';

-- ----------------------------------------------------------------------
-- Exercise 8 - Orders Above 1,000
-- Check Your Result: 9 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    status,
    total_amount
FROM orders
WHERE total_amount > 1000;

-- ----------------------------------------------------------------------
-- Exercise 9 - Low Stock Alert
-- Check Your Result: 8 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 20;

-- ----------------------------------------------------------------------
-- Exercise 10 - Large Completed Orders
-- Check Your Result: 21 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE status = 'Completed'
  AND total_amount > 600;

-- ----------------------------------------------------------------------
-- Exercise 11 - Customers from Selected Countries
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_name,
    country,
    email
FROM customers
WHERE country IN ('Canada', 'Germany', 'Spain');

-- ----------------------------------------------------------------------
-- Exercise 12 - Mid-Range Salaries
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_name,
    salary
FROM employees
WHERE salary BETWEEN 70000 AND 90000;

-- ----------------------------------------------------------------------
-- Exercise 13 - Customer Name Search
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_name LIKE 'S%';

-- ----------------------------------------------------------------------
-- Exercise 14 - Orders That Are Not Cancelled
-- Check Your Result: 189 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    status
FROM orders
WHERE status <> 'Cancelled';

-- Alternative
SELECT
    order_id,
    order_date,
    status
FROM orders
WHERE NOT status = 'Cancelled';

-- ----------------------------------------------------------------------
-- Exercise 15 - Missing Customer Email Addresses
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name
FROM customers
WHERE email IS NULL;

-- ======================================================================
-- CHAPTER 6 - Sort, Rank and Focus the Result
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 16 - Products by Price
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    price
FROM products
ORDER BY price ASC;

-- ----------------------------------------------------------------------
-- Exercise 17 - Highest-Paid Employees First
-- Check Your Result: 16 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_name,
    salary
FROM employees
ORDER BY salary DESC;

-- ----------------------------------------------------------------------
-- Exercise 18 - Newest Customers
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    signup_date
FROM customers
ORDER BY signup_date DESC;

-- ----------------------------------------------------------------------
-- Exercise 19 - Lowest Stock First
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    stock_quantity
FROM products
ORDER BY stock_quantity ASC;

-- ----------------------------------------------------------------------
-- Exercise 20 - Sort Customers by Location
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_name,
    country,
    city
FROM customers
ORDER BY country ASC, city ASC;

-- ----------------------------------------------------------------------
-- Exercise 21 - Five Largest Successful Payments
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT TOP 5
    payment_id,
    order_id,
    payment_method,
    amount
FROM payments
WHERE payment_status = 'Successful'
ORDER BY amount DESC;

-- ----------------------------------------------------------------------
-- Exercise 22 - Latest Five Orders
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT TOP 5
    order_id,
    order_date,
    status,
    total_amount
FROM orders
ORDER BY order_date DESC;

-- ----------------------------------------------------------------------
-- Exercise 23 - Largest Completed Orders
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT TOP 3
    order_id,
    order_date,
    total_amount
FROM orders
WHERE status = 'Completed'
ORDER BY total_amount DESC;

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

-- ======================================================================
-- CHAPTER 8 - Clean and Transform Data
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 32 - Standardize Customer Names
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_name,
    UPPER(customer_name) AS standardized_name
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 33 - Standardize Email Addresses
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    LOWER(email) AS email
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 34 - Remove Extra Spaces
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    TRIM(customer_name) AS cleaned_name
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 35 - Long Product Names
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    LEN(product_name) AS name_length
FROM products
WHERE LEN(product_name) > 20
ORDER BY name_length DESC;

-- ----------------------------------------------------------------------
-- Exercise 36 - Customer Location Label
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_name,
    CONCAT(city, ', ', country) AS location
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 37 - Price Including Sales Tax
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_name,
    price,
    ROUND(price * 1.08, 2) AS price_with_tax
FROM products;

-- ----------------------------------------------------------------------
-- Exercise 38 - Clean Missing Email Values
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    COALESCE(email, 'No Email Available') AS email
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 39 - Stock Cover Ratio
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    product_name,
    stock_quantity,
    ROUND(
        CAST(stock_quantity AS DECIMAL(10, 2)) / 40,
        2
    ) AS stock_cover_ratio
FROM products
ORDER BY stock_cover_ratio, product_id;

-- ----------------------------------------------------------------------
-- Exercise 40 - Build a Clean Customer Report
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    UPPER(TRIM(customer_name)) AS customer_name,
    LOWER(COALESCE(email, 'no email available')) AS email,
    country
FROM customers;

-- ======================================================================
-- CHAPTER 9 - Measure What Matters
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 41 - Count Website Sessions
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS total_sessions
FROM website_sessions;

-- ----------------------------------------------------------------------
-- Exercise 42 - Count Completed Orders
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'Completed';

-- ----------------------------------------------------------------------
-- Exercise 43 - Total Successful Collections
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    SUM(amount) AS total_collected
FROM payments
WHERE payment_status = 'Successful';

-- ----------------------------------------------------------------------
-- Exercise 44 - Average Employee Salary
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;

-- ----------------------------------------------------------------------
-- Exercise 45 - Earliest Customer Signup
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    MIN(signup_date) AS first_signup_date
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 46 - Most Recent Successful Payment
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    MAX(payment_date) AS latest_successful_payment
FROM payments
WHERE payment_status = 'Successful';

-- ----------------------------------------------------------------------
-- Exercise 47 - Total Units Sold
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;

-- ----------------------------------------------------------------------
-- Exercise 48 - Average Product Price
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ROUND(AVG(price), 2) AS average_product_price
FROM products;

-- ----------------------------------------------------------------------
-- Exercise 49 - Salary Range
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;

-- ----------------------------------------------------------------------
-- Exercise 50 - Customer Email Coverage
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS total_customers,
    COUNT(email) AS customers_with_email
FROM customers;

-- ----------------------------------------------------------------------
-- Exercise 51 - Successful Payment Summary
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS successful_payments,
    SUM(amount) AS total_collected,
    ROUND(AVG(amount), 2) AS average_payment,
    MIN(amount) AS smallest_payment,
    MAX(amount) AS largest_payment
FROM payments
WHERE payment_status = 'Successful';

-- ----------------------------------------------------------------------
-- Exercise 52 - Count Active Payment Methods
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(DISTINCT payment_method) AS active_payment_methods
FROM payments
WHERE payment_status = 'Successful';

-- ======================================================================
-- CHAPTER 10 - Group the Business
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 53 - Order Count per Customer
-- Check Your Result: 20 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC, customer_id;

-- ----------------------------------------------------------------------
-- Exercise 54 - Most Recent Customer Signup by Country
-- Check Your Result: 18 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    country,
    MAX(signup_date) AS latest_signup_date
FROM customers
GROUP BY country
ORDER BY latest_signup_date DESC;

-- ----------------------------------------------------------------------
-- Exercise 55 - Average Order Value by Date
-- Check Your Result: 191 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
order_date,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- ----------------------------------------------------------------------
-- Exercise 56 - Revenue by Payment Method
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_method,
    SUM(amount) AS total_amount
FROM payments
WHERE payment_status = 'Successful'
GROUP BY payment_method
ORDER BY total_amount DESC;

-- ----------------------------------------------------------------------
-- Exercise 57 - Products by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    category_id,
    COUNT(*) AS total_products
FROM products
GROUP BY category_id
ORDER BY total_products DESC;

-- ----------------------------------------------------------------------
-- Exercise 58 - Average Product Price by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    category_id,
    ROUND(AVG(price), 2) AS average_price
FROM products
GROUP BY category_id
ORDER BY average_price DESC;

-- ----------------------------------------------------------------------
-- Exercise 59 - Employees by Department
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;

-- ----------------------------------------------------------------------
-- Exercise 60 - Average Salary by Department
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    department_id,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department_id
ORDER BY average_salary DESC;

-- ----------------------------------------------------------------------
-- Exercise 61 - Website Sessions by Traffic Source
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    traffic_source,
    COUNT(*) AS total_sessions
FROM website_sessions
GROUP BY traffic_source
ORDER BY total_sessions DESC;

-- ----------------------------------------------------------------------
-- Exercise 62 - Website Sessions by Device and Source
-- Check Your Result: 15 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    device_type,
    traffic_source,
    COUNT(*) AS total_sessions
FROM website_sessions
GROUP BY
    device_type,
    traffic_source
ORDER BY
    device_type,
    total_sessions DESC;

-- ----------------------------------------------------------------------
-- Exercise 63 - Order Summary by Status
-- Check Your Result: 4 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    status,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_value,
    ROUND(AVG(total_amount), 2) AS average_value,
    MIN(total_amount) AS smallest_order,
    MAX(total_amount) AS largest_order
FROM orders
GROUP BY status
ORDER BY total_value DESC;

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

-- ======================================================================
-- CHAPTER 12 - SQL Through Time
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 72 - Orders After a Given Date
-- Check Your Result: 184 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    status,
    total_amount
FROM orders
WHERE order_date >= '2025-01-01';

-- ----------------------------------------------------------------------
-- Exercise 73 - Payments in the Second Quarter of 2026
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_id,
    order_id,
    payment_date,
    amount
FROM payments
WHERE payment_date >= '2026-04-01'
  AND payment_date < '2026-07-01'
ORDER BY payment_date, payment_id;

-- ----------------------------------------------------------------------
-- Exercise 74 - Customers Who Joined in 2025
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    signup_date
FROM customers
WHERE YEAR(signup_date) = 2025;

-- ----------------------------------------------------------------------
-- Exercise 75 - Identify the Order Month
-- Check Your Result: 207 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    MONTH(order_date) AS order_month
FROM orders;

-- ----------------------------------------------------------------------
-- Exercise 76 - Recent Customer Registrations
-- Check Your Result: depends on the day you run it (uses today's date)
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    customer_name,
    signup_date
FROM customers
WHERE signup_date >= DATEADD(DAY, -30, CAST(GETDATE() AS DATE));

-- Try it: add a test customer, run the solution again, then run the clean-up
/*
INSERT INTO customers
(customer_name, city, country, email, signup_date)
VALUES
('Test Customer', 'Pune', 'India',
 'test.customer@example.com', DATEADD(DAY, -5, CAST(GETDATE() AS DATE)));
*/

-- Clean-up: remove the test customer
/*
DELETE FROM customers
WHERE customer_name = 'Test Customer';
*/

-- ----------------------------------------------------------------------
-- Exercise 77 - Customer Tenure at the Reporting Date
-- Check Your Result: 26 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_name,
    signup_date,
    DATEDIFF(DAY, signup_date, '2026-09-30') AS days_as_customer
FROM customers
ORDER BY days_as_customer DESC;

-- ----------------------------------------------------------------------
-- Exercise 78 - Long-Serving Employees
-- Check Your Result: 6 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    employee_id,
    employee_name,
    hire_date
FROM employees
WHERE hire_date < '2020-01-01';

-- ----------------------------------------------------------------------
-- Exercise 79 - Orders from a Specific Month
-- Check Your Result: 2 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE YEAR(order_date) = 2025
  AND MONTH(order_date) = 3;

-- ----------------------------------------------------------------------
-- Exercise 80 - Payment Delay
-- Check Your Result: 180 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    o.order_date,
    p.payment_date,
    DATEDIFF(DAY, o.order_date, p.payment_date) AS days_to_payment
FROM orders AS o
JOIN payments AS p
    ON o.order_id = p.order_id;

-- ----------------------------------------------------------------------
-- Exercise 81 - Identify Weekend Website Sessions
-- Check Your Result: 23 rows
-- ----------------------------------------------------------------------
-- Solution
SET DATEFIRST 1;
SELECT
    session_id,
    session_date,
    customer_id
FROM website_sessions
WHERE DATEPART(weekday, session_date) IN (6, 7);

-- ======================================================================
-- CHAPTER 13 - Build Time-Based Reports
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 82 - Daily Successful Collections
-- Check Your Result: 136 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_date,
    COUNT(*) AS payments,
    SUM(amount) AS collected_amount
FROM payments
WHERE payment_status = 'Successful'
GROUP BY payment_date
ORDER BY payment_date;

-- ----------------------------------------------------------------------
-- Exercise 83 - Monthly Order Count
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Exercise 84 - Monthly Order Volume by Status
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END)
        AS completed_orders,
    SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END)
        AS pending_orders,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END)
        AS cancelled_orders,
    SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END)
        AS returned_orders
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Exercise 85 - Monthly Customer Signups
-- Check Your Result: 18 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(signup_date) AS signup_year,
    MONTH(signup_date) AS signup_month,
    COUNT(*) AS new_customers
FROM customers
GROUP BY
    YEAR(signup_date),
    MONTH(signup_date)
ORDER BY signup_year, signup_month;

-- ----------------------------------------------------------------------
-- Exercise 86 - Seasonal Order Activity
-- Check Your Result: 12 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    MONTH(order_date) AS month_number,
    DATENAME(month, order_date) AS month_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    MONTH(order_date),
    DATENAME(month, order_date)
ORDER BY month_number;

-- ----------------------------------------------------------------------
-- Exercise 87 - Order Activity by Day of Week
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ((DATEPART(weekday, order_date) + @@DATEFIRST - 2) % 7) + 1
        AS day_number,
    DATENAME(weekday, order_date) AS day_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY
    ((DATEPART(weekday, order_date) + @@DATEFIRST - 2) % 7) + 1,
    DATENAME(weekday, order_date)
ORDER BY day_number;

-- ----------------------------------------------------------------------
-- Exercise 88 - Monthly Payment Activity
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(payment_date) AS payment_year,
    MONTH(payment_date) AS payment_month,
    COUNT(*) AS total_payments
FROM payments
GROUP BY
    YEAR(payment_date),
    MONTH(payment_date)
ORDER BY payment_year, payment_month;

-- ----------------------------------------------------------------------
-- Exercise 89 - Monthly Website Sessions
-- Check Your Result: 30 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(session_date) AS session_year,
    MONTH(session_date) AS session_month,
    COUNT(*) AS total_sessions
FROM website_sessions
GROUP BY
    YEAR(session_date),
    MONTH(session_date)
ORDER BY session_year, session_month;

-- ----------------------------------------------------------------------
-- Exercise 90 - Completed vs Cancelled Orders by Month
-- Check Your Result: 44 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    status,
    COUNT(*) AS total_orders
FROM orders
WHERE status IN ('Completed', 'Cancelled')
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    status
ORDER BY order_year, order_month, status;

-- ----------------------------------------------------------------------
-- Exercise 91 - Monthly Average Order Value
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed'
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY order_year, order_month;

-- ======================================================================
-- CHAPTER 14 - Build a Business Report
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 92 - Payment Status Health Report
-- Check Your Result: 4 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_status,
    COUNT(*) AS payment_count,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS average_payment
FROM payments
GROUP BY payment_status
ORDER BY total_amount DESC;

-- ----------------------------------------------------------------------
-- Exercise 93 - Monthly Sales Summary
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed'
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Exercise 94 - Inventory Position by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    category_id,
    COUNT(*) AS product_count,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(SUM(price * stock_quantity), 2) AS inventory_value
FROM products
GROUP BY category_id
ORDER BY inventory_value DESC;

-- ----------------------------------------------------------------------
-- Exercise 95 - Inventory Risk Report
-- Check Your Result: 10 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    product_id,
    product_name,
    stock_quantity,
    price,
    stock_quantity * price AS inventory_value
FROM products
WHERE stock_quantity < 25
ORDER BY stock_quantity ASC;

-- ----------------------------------------------------------------------
-- Exercise 96 - Customer Signup Quality Report
-- Check Your Result: 3 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    YEAR(signup_date) AS signup_year,
    COUNT(*) AS total_customers,
    COUNT(email) AS customers_with_email,
    COUNT(*) - COUNT(email) AS missing_email,
    MIN(signup_date) AS first_signup,
    MAX(signup_date) AS latest_signup
FROM customers
GROUP BY YEAR(signup_date)
ORDER BY signup_year;

-- ----------------------------------------------------------------------
-- Exercise 97 - Website Traffic Report
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    traffic_source,
    COUNT(*) AS total_sessions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT customer_id), 2)
        AS sessions_per_customer
FROM website_sessions
GROUP BY traffic_source
ORDER BY total_sessions DESC;

-- ----------------------------------------------------------------------
-- Exercise 98 - Department Workforce Summary
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    department_id,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id
ORDER BY employee_count DESC;

-- ----------------------------------------------------------------------
-- Exercise 99 - High-Activity Customer Report
-- Check Your Result: 14 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    COUNT(*) AS completed_orders,
    SUM(total_amount) AS total_spent,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed'
GROUP BY customer_id
HAVING COUNT(*) >= 5
ORDER BY total_spent DESC;

-- ----------------------------------------------------------------------
-- Exercise 100 - Executive Customer Snapshot
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS total_customers,
    COUNT(email) AS customers_with_email,
    COUNT(DISTINCT country) AS countries,
    MIN(signup_date) AS first_signup,
    MAX(signup_date) AS latest_signup
FROM customers;

-- ======================================================================
-- CHAPTER 15 - Connect Related Tables
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 101 - Website Sessions with Customer Names
-- Check Your Result: 75 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ws.session_id,
    ws.session_date,
    c.customer_name,
    ws.traffic_source
FROM website_sessions AS ws
INNER JOIN customers AS c
    ON ws.customer_id = c.customer_id
ORDER BY ws.session_date, ws.session_id;

-- ----------------------------------------------------------------------
-- Exercise 102 - Products with Category Names
-- Check Your Result: 27 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_name,
    c.category_name,
    p.price
FROM products AS p
INNER JOIN categories AS c
    ON p.category_id = c.category_id;

-- ----------------------------------------------------------------------
-- Exercise 103 - Employees with Department Names
-- Check Your Result: 16 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    e.employee_name,
    d.department_name,
    e.salary
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id;

-- ----------------------------------------------------------------------
-- Exercise 104 - Orders with Payment Details
-- Check Your Result: 180 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    o.order_date,
    p.payment_method,
    p.payment_status,
    p.amount
FROM orders AS o
INNER JOIN payments AS p
    ON o.order_id = p.order_id;

-- ----------------------------------------------------------------------
-- Exercise 105 - Completed Orders with Customer Details
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    o.order_id,
    c.customer_name,
    c.country,
    o.order_date,
    o.total_amount
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.status = 'Completed';

-- ----------------------------------------------------------------------
-- Exercise 106 - Product Sales Details
-- Check Your Result: 384 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_value
FROM order_items AS oi
INNER JOIN products AS p
    ON oi.product_id = p.product_id;

-- ----------------------------------------------------------------------
-- Exercise 107 - Customer Payment Report
-- Check Your Result: 180 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_name,
    o.order_id,
    p.payment_date,
    p.payment_method,
    p.amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN payments AS p
    ON o.order_id = p.order_id;

-- ----------------------------------------------------------------------
-- Exercise 108 - Product Revenue by Category
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id
INNER JOIN categories AS c
    ON p.category_id = c.category_id
WHERE o.status = 'Completed'
GROUP BY c.category_name
ORDER BY total_revenue DESC;

-- ----------------------------------------------------------------------
-- Exercise 109 - Customer Website Activity
-- Check Your Result: 15 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(ws.session_id) AS session_count,
    MAX(ws.session_date) AS latest_session
FROM customers AS c
JOIN website_sessions AS ws
    ON c.customer_id = ws.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY latest_session DESC;

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

-- ======================================================================
-- CHAPTER 18 - Avoid the Duplicate Row Trap
-- ======================================================================

-- ----------------------------------------------------------------------
-- Exercise 128 - Count Customers Correctly
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(DISTINCT c.customer_id) AS ordering_customers
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- ----------------------------------------------------------------------
-- Exercise 129 - Calculate Average Order Value at the Order Grain
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE status = 'Completed';

-- Incorrect Approach (for comparison - do not run)
/*
SELECT
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';
*/

-- ----------------------------------------------------------------------
-- Exercise 130 - Calculate Average Selling Price Correctly
-- Check Your Result: 23 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    ROUND(AVG(oi.unit_price), 2) AS simple_average_price,
    ROUND(
        SUM(oi.quantity * oi.unit_price) / SUM(oi.quantity),
        2
    ) AS average_selling_price
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY average_selling_price DESC;

-- ----------------------------------------------------------------------
-- Exercise 131 - Avoid Inflated Customer Revenue
-- Check Your Result: 19 rows
-- ----------------------------------------------------------------------
-- Correct query
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name;

-- Incorrect Approach (for comparison - do not run)
/*
SELECT
    c.customer_name,
    SUM(o.total_amount)
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name;
*/

-- ----------------------------------------------------------------------
-- Exercise 132 - Count Products Correctly After a Supplier Join
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    cat.category_name,
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT p.product_id) AS products_with_suppliers
FROM categories AS cat
JOIN products AS p
    ON cat.category_id = p.category_id
JOIN product_suppliers AS ps
    ON p.product_id = ps.product_id
GROUP BY cat.category_name
ORDER BY joined_rows DESC;

-- ----------------------------------------------------------------------
-- Exercise 133 - Compare Row Count and Unique Order Count
-- Check Your Result: 1 row
-- ----------------------------------------------------------------------
-- Solution
SELECT
    COUNT(*) AS joined_row_count,
    COUNT(DISTINCT o.order_id) AS unique_order_count
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;

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

-- ======================================================================
-- CHAPTER 23 - Running Totals, Previous Values and Trends
-- ======================================================================

-- ----------------------------------------------------------------------
-- Analyst Challenge 8 - Running Successful Payments by Payment Method
-- Check Your Result: 146 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    payment_method,
    payment_id,
    order_id,
    payment_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY payment_method
        ORDER BY payment_date, payment_id
    ) AS running_collected
FROM payments
WHERE payment_status = 'Successful'
ORDER BY
    payment_method,
    payment_date,
    payment_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 9 - Cumulative Customer Signups by Month
-- Check Your Result: 18 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_signups AS (
    SELECT
        YEAR(signup_date) AS signup_year,
        MONTH(signup_date) AS signup_month,
        COUNT(*) AS new_customers
    FROM customers
    GROUP BY
        YEAR(signup_date),
        MONTH(signup_date)
)
SELECT
    signup_year,
    signup_month,
    new_customers,
    SUM(new_customers) OVER (
        ORDER BY signup_year, signup_month
    ) AS cumulative_customers
FROM monthly_signups
ORDER BY signup_year, signup_month;

-- ----------------------------------------------------------------------
-- Analyst Challenge 10 - Change in Monthly Website Sessions
-- Check Your Result: 30 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_sessions AS (
    SELECT
        DATEPART(year, session_date) AS session_year,
        DATEPART(month, session_date) AS session_month,
        COUNT(*) AS sessions
    FROM website_sessions
    GROUP BY
        DATEPART(year, session_date),
        DATEPART(month, session_date)
)
SELECT
    session_year,
    session_month,
    sessions,
    LAG(sessions) OVER (
        ORDER BY session_year, session_month
    ) AS previous_sessions,
    sessions - LAG(sessions) OVER (
        ORDER BY session_year, session_month
    ) AS session_change
FROM monthly_sessions
ORDER BY session_year, session_month;

-- ----------------------------------------------------------------------
-- Analyst Challenge 11 - Month-over-Month Growth in Successful Payment Count
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_payments AS (
    SELECT
        YEAR(payment_date)  AS payment_year,
        MONTH(payment_date) AS payment_month,
        COUNT(*)            AS successful_payments
    FROM
        payments
    WHERE
        payment_status = 'Successful'
    GROUP BY
        YEAR(payment_date),
        MONTH(payment_date)
),
comparison AS (
    SELECT
        payment_year,
        payment_month,
        successful_payments,
        LAG(successful_payments) OVER (
            ORDER BY payment_year, payment_month
        ) AS previous_payments
    FROM
        monthly_payments
)
SELECT
    payment_year,
    payment_month,
    successful_payments,
    previous_payments,
    ROUND(
        100.0 * (successful_payments - previous_payments)
        / NULLIF(previous_payments, 0),
        2
    ) AS growth_percentage
FROM
    comparison
ORDER BY
    payment_year,
    payment_month;

-- ----------------------------------------------------------------------
-- Analyst Challenge 12 - Customer Running Spend
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS cumulative_spend
FROM orders
WHERE status = 'Completed'
ORDER BY customer_id, order_date, order_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 13 - Compare Each Purchase with the Previous One
-- Check Your Result: 150 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS previous_order_value
FROM orders
WHERE status = 'Completed'
ORDER BY customer_id, order_date, order_id;

-- ----------------------------------------------------------------------
-- Analyst Challenge 14 - Classify Monthly Revenue Trend
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_revenue AS (
    SELECT
        YEAR(order_date)  AS order_year,
        MONTH(order_date) AS order_month,
        SUM(total_amount) AS revenue
    FROM
        orders
    WHERE
        status = 'Completed'
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
    FROM
        monthly_revenue
)
SELECT
    order_year,
    order_month,
    revenue,
    previous_revenue,
    CASE
        WHEN previous_revenue IS NULL THEN 'No Prior Period'
        WHEN revenue > previous_revenue THEN 'Growth'
        WHEN revenue < previous_revenue THEN 'Decline'
        ELSE 'No Change'
    END AS trend
FROM
    comparison
ORDER BY
    order_year,
    order_month;

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

-- ======================================================================
-- CHAPTER 25 - Business Case Challenges
-- ======================================================================

-- ----------------------------------------------------------------------
-- Business Case 1 - Identify the Most Valuable Customers
-- Check Your Result: 10 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT TOP 10
    c.customer_id,
    c.customer_name,
    c.country,
    COUNT(*) AS completed_orders,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.country
ORDER BY total_revenue DESC;

-- ----------------------------------------------------------------------
-- Business Case 2 - Find Customers at Risk of Churn
-- Check Your Result: 2 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    MAX(o.order_date) AS last_order_date,
    COUNT(*) AS completed_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.country
HAVING MAX(o.order_date) < '2025-01-01'
ORDER BY last_order_date;

-- ----------------------------------------------------------------------
-- Business Case 3 - Find the Strongest Product Categories
-- Check Your Result: 7 rows
-- ----------------------------------------------------------------------
-- Solution
WITH category_sales AS (
    SELECT
        c.category_name,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    JOIN products AS p
        ON oi.product_id = p.product_id
    JOIN categories AS c
        ON p.category_id = c.category_id
    WHERE o.status = 'Completed'
    GROUP BY c.category_name
)
SELECT
    category_name,
    units_sold,
    revenue,
    ROUND(
        100.0 * revenue / SUM(revenue) OVER (),
        2
    ) AS revenue_share_percentage
FROM category_sales
ORDER BY revenue DESC;

-- ----------------------------------------------------------------------
-- Business Case 4 - Detect Declining Monthly Revenue
-- Check Your Result: 14 rows
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
    revenue - previous_revenue AS revenue_change
FROM comparison
WHERE revenue < previous_revenue
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Business Case 5 - Identify Products Requiring Attention
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS product_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE p.stock_quantity < 20
  AND o.status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name,
    p.stock_quantity
HAVING SUM(oi.quantity) >= 15
ORDER BY units_sold DESC;

-- ----------------------------------------------------------------------
-- Business Case 6 - Compare Traffic Sources
-- Check Your Result: 5 rows
-- ----------------------------------------------------------------------
-- Solution
WITH source_sessions AS (
    SELECT
        traffic_source,
        COUNT(*) AS total_sessions
    FROM website_sessions
    GROUP BY traffic_source
)
SELECT
    traffic_source,
    total_sessions,
    ROUND(
        100.0 * total_sessions
        / SUM(total_sessions) OVER (),
        2
    ) AS session_share,
    RANK() OVER (
        ORDER BY total_sessions DESC
    ) AS source_rank
FROM source_sessions
ORDER BY source_rank;

-- ----------------------------------------------------------------------
-- Business Case 7 - Find High-Value Repeat Customers
-- Check Your Result: 9 rows
-- ----------------------------------------------------------------------
-- Solution
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(*) AS completed_orders,
    SUM(o.total_amount) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(*) >= 3
   AND SUM(o.total_amount) > 3000
ORDER BY total_spent DESC;

-- ----------------------------------------------------------------------
-- Business Case 8 - Build a Compact Executive Sales View
-- Check Your Result: 33 rows
-- ----------------------------------------------------------------------
-- Solution
WITH monthly_summary AS (
    SELECT
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        COUNT(*) AS completed_orders,
        SUM(total_amount) AS revenue,
        ROUND(AVG(total_amount), 2) AS average_order_value,
        COUNT(DISTINCT customer_id) AS unique_customers
    FROM orders
    WHERE status = 'Completed'
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
),
comparison AS (
    SELECT
        *,
        LAG(revenue) OVER (
            ORDER BY order_year, order_month
        ) AS previous_revenue
    FROM monthly_summary
)
SELECT
    order_year,
    order_month,
    completed_orders,
    revenue,
    average_order_value,
    unique_customers,
    previous_revenue,
    ROUND(
        100.0 * (revenue - previous_revenue)
        / NULLIF(previous_revenue, 0),
        2
    ) AS growth_percentage
FROM comparison
ORDER BY order_year, order_month;

-- ======================================================================
-- CHAPTER 26 - Debug the Query
-- ======================================================================

-- ----------------------------------------------------------------------
-- Debug Challenge 1 - The NULL Comparison
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    customer_id,
    customer_name
FROM customers
WHERE email = NULL;
*/

-- Correct query
SELECT
    customer_id,
    customer_name
FROM customers
WHERE email IS NULL;

-- ----------------------------------------------------------------------
-- Debug Challenge 2 - The Missing GROUP BY
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    status,
    SUM(total_amount) AS revenue
FROM orders;
*/

-- Correct query
SELECT
    status,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY status;

-- ----------------------------------------------------------------------
-- Debug Challenge 3 - WHERE or HAVING?
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    customer_id,
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'Completed'
  AND COUNT(*) >= 5
GROUP BY customer_id;
*/

-- Correct query
SELECT
    customer_id,
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'Completed'
GROUP BY customer_id
HAVING COUNT(*) >= 5;

-- ----------------------------------------------------------------------
-- Debug Challenge 4 - The Wrong Join
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    o.order_id,
    c.customer_name
FROM orders AS o
JOIN customers AS c
    ON o.order_id = c.customer_id;
*/

-- Correct query
SELECT
    o.order_id,
    c.customer_name
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id;

-- ----------------------------------------------------------------------
-- Debug Challenge 5 - Inflated Revenue
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    SUM(o.total_amount) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';
*/

-- Correct query
SELECT
    SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed';

-- If product-level revenue is required
SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';

-- ----------------------------------------------------------------------
-- Debug Challenge 6 - LEFT JOIN That Became an INNER JOIN
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
  AND o.order_id IS NULL;
*/

-- Correct query
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
   AND o.status = 'Completed'
WHERE o.order_id IS NULL;

-- ----------------------------------------------------------------------
-- Debug Challenge 7 - Counting Orders Instead of Customers
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    COUNT(customer_id) AS ordering_customers
FROM orders;
*/

-- Correct query
SELECT
    COUNT(DISTINCT customer_id) AS ordering_customers
FROM orders;

-- ----------------------------------------------------------------------
-- Debug Challenge 8 - Month Grouping Across Years
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    MONTH(order_date) AS order_month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY MONTH(order_date);
*/

-- Correct query
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY order_year, order_month;

-- ----------------------------------------------------------------------
-- Debug Challenge 9 - Ranking Without a Partition
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
SELECT
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;
*/

-- Correct query
SELECT
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

-- ----------------------------------------------------------------------
-- Debug Challenge 10 - Incorrect Percentage Calculation
-- ----------------------------------------------------------------------
-- Broken query (for comparison - do not run)
/*
WITH category_sales AS (
    SELECT
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    JOIN products AS p
        ON oi.product_id = p.product_id
    JOIN categories AS c
        ON p.category_id = c.category_id
    WHERE o.status = 'Completed'
    GROUP BY c.category_name
)
SELECT
    category_name,
    revenue,
    revenue / SUM(revenue) * 100 AS revenue_share
FROM category_sales;
*/

-- Correct query
WITH category_sales AS (
    SELECT
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    JOIN products AS p
        ON oi.product_id = p.product_id
    JOIN categories AS c
        ON p.category_id = c.category_id
    WHERE o.status = 'Completed'
    GROUP BY c.category_name
)
SELECT
    category_name,
    revenue,
    ROUND(
        100.0 * revenue / SUM(revenue) OVER (),
        2
    ) AS revenue_share
FROM category_sales
ORDER BY revenue DESC;

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

