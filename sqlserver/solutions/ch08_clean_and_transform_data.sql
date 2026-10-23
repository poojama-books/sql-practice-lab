-- The SQL Practice Lab - SQL Server solutions
-- Author: Pooja M A
-- Run novacart_sqlserver.sql (in this folder) first to create the NovaCart tables.
-- Every query in this file is written for SQL Server and runs as-is.
-- Each problem shows its Check Your Result row count from the book.

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

