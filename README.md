# E-commerce Sales Analysis — SQL Portfolio Project

## Objective

Analyze an e-commerce dataset to understand order performance, revenue, customers, products, sales channels, payments, time trends, and discounts, then turn the analysis into business recommendations.

## Dataset

Four related tables were analyzed:

- `customers` — 1,000 customers
- `products` — 60 products
- `orders` — 5,000 orders
- `order_items` — approximately 8,700 product-line records

### Data grain

- Customers: one row per customer
- Products: one row per product
- Orders: one row per order
- Order items: one row per product line within an order

## Data quality

Validation checks found:

- No NULL values in the checked fields
- No duplicate primary IDs
- No inconsistent categorical values
- Dates were consistently formatted as `YYYY-MM-DD`
- No invalid quantities, prices, or discounts
- No broken customer or product relationships

No unnecessary source-data modifications were made.

## Revenue definition

For the final business analysis:

**Revenue = quantity × unit price × (1 − discount_pct)**

Only orders with `order_status = 'Completed'` are treated as revenue.

Completed revenue: **$823,479.68**

## Key findings

1. **Order completion:** 83.26% of orders were completed, 10.28% cancelled, and 6.46% returned.

2. **Channel:** Website generated the most completed revenue ($392,925.29) and completed orders (1,978). Its AOV ($198.65) was very similar to Mobile App ($197.88) and Marketplace ($195.01), so its revenue lead was mainly volume-driven.

3. **Categories:** Beauty generated the most completed category revenue ($197,057.70), followed by Electronics ($190,414.94) and Home ($187,707.48). Beauty also had the highest completed revenue per unit at $98.19.

4. **Products:** Water Bottle was the top product by completed revenue at $45,534.94, followed by Body Lotion ($41,443.64) and Gym Gloves ($40,242.37).

5. **Customers:** Regular customers generated the most completed segment revenue ($326,568.31). Loyal customers remained an important high-value segment because of their stronger purchase frequency and individual customer value.

6. **Discounts:** Higher discount levels were associated with lower sales volume and revenue in the dataset. This does not establish causation.

7. **Time:** Completed monthly revenue was relatively stable during 2025. July had the highest completed revenue ($73,068.98), while December had the lowest ($64,878.42).

## Recommendations

- Protect and improve the Website channel.
- Investigate cancelled and returned orders.
- Use category-specific merchandising and pricing strategies.
- Focus retention efforts on Loyal customers.
- Test discounts rather than assuming larger discounts create demand.
- Monitor monthly revenue and AOV for changes in customer purchasing behavior.

## SQL skills demonstrated

- SELECT, WHERE, GROUP BY, ORDER BY
- Aggregate functions
- CASE expressions
- JOINs
- DISTINCT
- Subqueries
- Date conversion and date grouping
- Data validation and quality checks
- Business metric calculation
- Analytical interpretation

## Project structure

```text
ecommerce-sql-analysis/
├── README.md
├── sql/
│   ├── 01_data_exploration.sql
│   ├── 02_data_cleaning.sql
│   └── 03_analysis.sql
└── insights/
    ├── key_findings.md
    └── recommendations.md
