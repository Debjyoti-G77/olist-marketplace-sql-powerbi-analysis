Olist Marketplace — SQL + Power BI Business Analysis
End-to-End Data Analytics Case Study (2016–2018)
Author: Debjyoti Sengupta
1. Project Overview

This project analyzes the Brazilian Olist Marketplace dataset containing over 100,000 e-commerce orders from 2016–2018.
The goal is to identify key marketplace trends and patterns across:

Marketplace growth over time

Customer distribution

Seller performance

Delivery speed and delays

Review score behavior

Freight and logistics efficiency

Product category performance

This reflects a real Business Analyst workflow, involving:

Data extraction and transformation using SQL

KPI creation and business-driven analysis

Dashboard building using Power BI

Insight generation and reporting

2. Repository Structure
/sql
    monthly_orders.sql
    category_freight_summary.sql
    seller_revenue_summary.sql
    review_delay_analysis.sql
    city_orders_summary.sql
    state_delivery_time_summary.sql
    review_score_distribution.sql

/powerbi
    Olist_Marketplace_Dashboard.pbix

/dashboards
    dashboard_1.png
    dashboard_2.png

README.md

3. Data Model (Conceptual)
orders
 ├── order_items (one-to-many)
 │     ├── products
 │     └── sellers
 ├── order_payments
 ├── order_reviews
 └── customers
        └── geolocation


The structure supports analysis of:

Revenue and seller performance

Freight and logistics trends

Customer satisfaction

Delivery delays

Category-level sales

Geographic distribution

4. SQL Queries and Insights
4.1 Monthly Orders (Trend Analysis)
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1;

Findings

Orders grew from 4 orders/month (2016) to 7,000+ orders/month (2018)

Strong seasonality observed between November–January

Marketplace experienced rapid year-over-year scaling

4.2 Category Freight Summary
SELECT
    p.product_category_name_english,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight_value,
    COUNT(*) AS total_orders
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY 1
ORDER BY avg_freight_value DESC;

Findings

Furniture, electronics, and bulky product categories show highest freight

Freight pricing strongly correlates with product weight/size

4.3 Seller Revenue Summary
SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY 1
ORDER BY total_revenue DESC;

Findings

Top 10 sellers contribute 25–30% of total marketplace revenue

Marketplace displays a long-tail seller distribution

4.4 State-wise Delivery Time
SELECT
    c.customer_state,
    ROUND(AVG(
        JULIANDAY(o.order_delivered_customer_date) -
        JULIANDAY(o.order_purchase_timestamp)
    ), 2) AS avg_delivery_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY 1
ORDER BY avg_delivery_days DESC;

Findings

Northern states experience slower delivery times

Southeastern states (SP, RJ, MG) benefit from robust logistics networks

4.5 City-Level Order Distribution
SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY total_orders DESC;

Findings

São Paulo is the clear market leader in terms of orders

Major metropolitan regions drive the majority of sales

4.6 Review Score Distribution
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

Findings

Majority of customer reviews are 4 or 5 stars

Negative reviews strongly tied to delivery issues

4.7 Review Score vs Delivery Delay
SELECT
    r.review_score,
    d.delay_days
FROM review_delay_analysis d
JOIN order_reviews r ON d.order_id = r.order_id
WHERE r.review_score IS NOT NULL;

Findings

On-time deliveries receive 4.3–4.7 average rating

Severe delays (>15 days) reduce ratings to 2.0–2.5

Delivery performance is the primary driver of customer satisfaction

5. Dashboard 1 — Business Performance Overview
Included KPIs

Monthly Orders Trend

Delivery Status Breakdown

Top Product Categories by Revenue

Average Delay Days

Payment Method Distribution

Average Review Score

Key Insights
Area	Insight
Order Growth	Over 4× growth between 2016–2018
Delivery Performance	72% of orders delivered on-time or early
Payment Methods	Credit card dominates payment share
Category Revenue	Bed/bath, electronics, and health & beauty lead
Customer Ratings	Strong correlation with delivery speed

Dashboard file: dashboards/dashboard_1.png

6. Dashboard 2 — Customer and Logistics Overview
Included KPIs

Seller Revenue Distribution

Top Customer Cities

Average Freight by Category

Review Score Distribution

Delivery Time by State

Delay Bucket vs Review Score

Key Insights
Area	Insight
Customer Geography	São Paulo, Rio de Janeiro, and Belo Horizonte lead orders
Freight Behavior	Heaviest/bulkiest items have highest freight
Delivery Inequality	Northern states face slowest deliveries
Review Behavior	Late deliveries produce lowest customer ratings

Dashboard file: dashboards/dashboard_2.png

7. Business Conclusions

The marketplace saw strong and consistent growth from 2016–2018.

Delivery performance is the most influential factor affecting customer satisfaction.

Freight costs for heavy categories present optimization opportunities.

Revenue follows a long-tail distribution with a small group of high-performing sellers.

Sales are geographically concentrated in major metropolitan cities.

Regional delivery challenges affect customer experience and ratings.

8. Tools Used
Task	Tools
SQL Querying	SQLite, DB Browser
Data Modeling	SQL joins and aggregations
Dashboarding	Power BI
Documentation	GitHub README
9. Author

Debjyoti Sengupta
