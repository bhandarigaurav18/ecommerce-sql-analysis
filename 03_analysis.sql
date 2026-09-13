-- E-commerce SQL Analysis
-- 03_analysis.sql
-- Revenue definition used in this project:
-- Revenue = completed-order sales after discounts.
-- discount_pct is stored as a decimal (0.05 = 5%).

-- 1. Completed revenue
SELECT
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ),
        2
    ) AS completed_revenue
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
WHERE orders.order_status = 'Completed';

-- 2. Completed revenue by channel
SELECT
    orders.sales_channel,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ),
        2
    ) AS completed_revenue
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
WHERE orders.order_status = 'Completed'
GROUP BY orders.sales_channel
ORDER BY completed_revenue DESC;

-- 3. Completed orders by channel
SELECT
    sales_channel,
    COUNT(*) AS completed_orders
FROM orders
WHERE order_status = 'Completed'
GROUP BY sales_channel
ORDER BY completed_orders DESC;

-- 4. Completed AOV by channel
SELECT
    orders.sales_channel,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ) / COUNT(DISTINCT orders.order_id),
        2
    ) AS completed_aov
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
WHERE orders.order_status = 'Completed'
GROUP BY orders.sales_channel
ORDER BY completed_aov DESC;

-- 5. Revenue by category
SELECT
    products.category,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ),
        2
    ) AS revenue
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.category
ORDER BY revenue DESC;

-- 6. Units sold by category
SELECT
    products.category,
    SUM(order_items.quantity) AS units_sold
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.category
ORDER BY units_sold DESC;

-- 7. Revenue per unit by category
SELECT
    products.category,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ) / SUM(order_items.quantity),
        2
    ) AS revenue_per_unit
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.category
ORDER BY revenue_per_unit DESC;

-- 8. Top products by revenue
SELECT
    products.product_name,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ),
        2
    ) AS revenue
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.product_name
ORDER BY revenue DESC
LIMIT 10;

-- 9. Top products by units sold
SELECT
    products.product_name,
    SUM(order_items.quantity) AS units_sold
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.product_name
ORDER BY units_sold DESC
LIMIT 10;

-- 10. Customers with orders
SELECT COUNT(DISTINCT customer_id) AS customers_with_orders
FROM orders;

-- 11. Top customers by spending
SELECT
    orders.customer_id,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ),
        2
    ) AS total_spending
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY orders.customer_id
ORDER BY total_spending DESC
LIMIT 10;

-- 12. Customer segment performance
SELECT
    customers.customer_segment,
    COUNT(DISTINCT orders.customer_id) AS customers,
    COUNT(DISTINCT orders.order_id) AS orders,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ),
        2
    ) AS revenue
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY customers.customer_segment
ORDER BY revenue DESC;

-- 13. Revenue per customer by segment
SELECT
    customers.customer_segment,
    COUNT(DISTINCT customers.customer_id) AS customers,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ) / COUNT(DISTINCT customers.customer_id),
        2
    ) AS revenue_per_customer
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY customers.customer_segment
ORDER BY revenue_per_customer DESC;

-- 14. Orders per customer by segment
SELECT
    customers.customer_segment,
    COUNT(DISTINCT orders.order_id) AS total_orders,
    COUNT(DISTINCT customers.customer_id) AS customers,
    ROUND(
        COUNT(DISTINCT orders.order_id) * 1.0
        / COUNT(DISTINCT customers.customer_id),
        2
    ) AS orders_per_customer
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_segment
ORDER BY orders_per_customer DESC;

-- 15. Discount distribution
SELECT
    discount_pct,
    COUNT(*) AS total_items
FROM order_items
GROUP BY discount_pct
ORDER BY discount_pct;

-- 16. Discount vs sales
SELECT
    discount_pct,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(quantity * unit_price * (1 - discount_pct)),
        2
    ) AS revenue
FROM order_items
GROUP BY discount_pct
ORDER BY discount_pct;

-- 17. Average discount by category
SELECT
    products.category,
    ROUND(AVG(order_items.discount_pct) * 100, 2) AS average_discount
FROM products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY products.category
ORDER BY average_discount DESC;

-- 18. Monthly revenue
SELECT
    DATE_FORMAT(STR_TO_DATE(orders.order_date, '%Y-%m-%d'), '%Y-%m') AS month,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ),
        2
    ) AS revenue
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY month
ORDER BY month;

-- 19. Monthly AOV
SELECT
    DATE_FORMAT(STR_TO_DATE(orders.order_date, '%Y-%m-%d'), '%Y-%m') AS month,
    ROUND(
        SUM(
            order_items.quantity
            * order_items.unit_price
            * (1 - order_items.discount_pct)
        ) / COUNT(DISTINCT orders.order_id),
        2
    ) AS average_order_value
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY month
ORDER BY month;
