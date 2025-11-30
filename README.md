Olist Marketplace — SQL + Power BI Business Analysis
End-to-End Data Analytics Case Study (2016–2018)
Author: Debjyoti Sengupta
1. Project Overview

This project analyzes the Brazilian Olist Marketplace dataset, which contains over 100,000 e-commerce orders collected between 2016 and 2018.

The objective is to identify key marketplace trends across:

Marketplace growth over time

Customer distribution

Seller performance

Delivery speed and delays

Review score behavior

Freight and logistics efficiency

Category-wise revenue trends

The project follows a complete Business Analyst workflow:

SQL for data extraction and transformation

KPI building and analysis

Visualization using Power BI

Business insight summarization

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

3. Data Model Overview
orders
 ├── order_items
 │     ├── products
 │     └── sellers
 ├── order_payments
 ├── order_reviews
 └── customers
        └── geolocation


This schema enables analysis of:

Customer location distribution

Delivery performance

Review satisfaction behavior

Product-level sales

Seller revenue ranking

4. SQL Workflows and Key Insights

Below are essential SQL transformations used for building dashboards and KPIs.

4.1 Monthly Orders Trend
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1;

Insight

Orders increased from approximately 4 per month in 2016 to more than 7000 per month in 2018.

Strong seasonal spikes during November–January.

4.2 Category Freight Summary
SELECT
    p.product_category_name_english,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight_value,
    COUNT(*) AS total_orders
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY 1
ORDER BY avg_freight_value DESC;

Insight

Bulky items such as furniture and home appliances have the highest freight costs.

4.3 Seller Revenue Summary
SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY 1
ORDER BY total_revenue DESC;

Insight

Top sellers contribute 25–30% of total marketplace revenue.

Revenue is long-tail distributed.

4.4 Delivery Time by State
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

Insight

Northern regions show significantly higher delivery times.

Southeastern states such as SP, RJ, MG have the fastest delivery.

4.5 City-Level Order Distribution
SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY total_orders DESC;

Insight

São Paulo dominates in terms of number of orders.

Major Brazilian cities drive most marketplace activity.

4.6 Review Score Distribution
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

Insight

Most customers give 4 and 5 stars.

Lower scores are mainly due to delivery-related issues.

4.7 Review Score vs Delivery Delay
SELECT
    r.review_score,
    d.delay_days
FROM review_delay_analysis d
JOIN order_reviews r ON d.order_id = r.order_id
WHERE r.review_score IS NOT NULL;

Insight

Orders delivered on time receive 4.3–4.7 ratings on average.

Orders delayed more than 15 days receive approximately 2-star ratings.

5. Dashboard 1 — Business Performance Overview
Visuals Included

Monthly Order Trend

Delivery Status Breakdown

Payment Method Distribution

Top Product Categories by Revenue

Average Delay Days

Average Review Score

Key Insights

Order volume increased more than 400% between 2016–2018.

Credit card is the dominant payment method.

Over 70% of deliveries are on-time or early.

Health, beauty, electronics, and home-related categories lead revenue.

Customer satisfaction strongly correlates with delivery timeliness.

Dashboard file: dashboards/dashboard_1.png

6. Dashboard 2 — Customer and Logistics Overview
Visuals Included

Seller Revenue Ranking

Top Customer Cities

Average Freight by Category

Review Score Distribution

Average Delivery Days by State

Delay Bucket vs Review Score

Key Insights

Major cities such as São Paulo and Rio de Janeiro account for a large portion of orders.

Heavy items incur higher logistics costs.

Delivery performance varies significantly across states.

Very late deliveries result in substantially lower customer ratings.

Dashboard file: dashboards/dashboard_2.png

7. Business Conclusions

Olist Marketplace showed rapid growth between 2016 and 2018.

Delivery performance has the strongest impact on customer satisfaction.

Freight cost optimization is necessary for heavy item categories.

Seller performance follows a long-tail distribution.

Urban areas dominate order volume.

State-wise logistics vary significantly, requiring infrastructure improvements.

8. Tools Used
Task	Tools
SQL Querying	SQLite, DB Browser
Data Modeling	SQL Joins, Aggregations
Dashboarding	Power BI
Documentation	GitHub README
9. Author

Debjyoti Sengupta
MSc Data Science
