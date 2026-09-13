-- E-commerce SQL Analysis
-- 02_data_cleaning.sql
-- These are validation checks. No source data required modification because
-- the dataset passed the checks.

-- 1. NULL checks
SELECT
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(first_name IS NULL) AS null_first_name,
    SUM(last_name IS NULL) AS null_last_name,
    SUM(email IS NULL) AS null_email,
    SUM(city IS NULL) AS null_city,
    SUM(customer_segment IS NULL) AS null_customer_segment,
    SUM(signup_date IS NULL) AS null_signup_date,
    SUM(acquisition_channel IS NULL) AS null_acquisition_channel
FROM customers;

SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(order_date IS NULL) AS null_order_date,
    SUM(sales_channel IS NULL) AS null_sales_channel,
    SUM(payment_method IS NULL) AS null_payment_method,
    SUM(order_status IS NULL) AS null_order_status
FROM orders;

SELECT
    SUM(order_item_id IS NULL) AS null_order_item_id,
    SUM(order_id IS NULL) AS null_order_id,
    SUM(product_id IS NULL) AS null_product_id,
    SUM(quantity IS NULL) AS null_quantity,
    SUM(unit_price IS NULL) AS null_unit_price,
    SUM(discount_pct IS NULL) AS null_discount_pct
FROM order_items;

-- 2. Duplicate ID checks
SELECT customer_id, COUNT(*) AS row_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS row_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) AS row_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT order_item_id, COUNT(*) AS row_count
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;

-- 3. Categorical consistency
SELECT DISTINCT order_status FROM orders;
SELECT DISTINCT sales_channel FROM orders;
SELECT DISTINCT payment_method FROM orders;
SELECT DISTINCT category FROM products;

-- 4. Date validation
SELECT
    order_date,
    STR_TO_DATE(order_date, '%Y-%m-%d') AS converted_date
FROM orders
LIMIT 10;

-- 5. Numeric and relationship validation
SELECT COUNT(*) AS invalid_quantity_rows
FROM order_items
WHERE quantity <= 0;

SELECT COUNT(*) AS invalid_product_price_rows
FROM products
WHERE unit_price <= 0;

SELECT COUNT(*) AS invalid_discount_rows
FROM order_items
WHERE discount_pct < 0 OR discount_pct > 1;

SELECT COUNT(*) AS broken_customer_links
FROM orders
LEFT JOIN customers
    ON orders.customer_id = customers.customer_id
WHERE customers.customer_id IS NULL;

SELECT COUNT(*) AS broken_product_links
FROM order_items
LEFT JOIN products
    ON order_items.product_id = products.product_id
WHERE products.product_id IS NULL;
