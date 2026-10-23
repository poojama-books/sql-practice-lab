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

