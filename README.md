Olist Marketplace — SQL + Power BI Business Analysis

End-to-End Data Analytics Case Study (2016–2018)
By Debjyoti Sengupta

Project Overview

This project analyzes the Brazilian Olist Marketplace dataset, containing over 100k e-commerce orders, to understand:

Marketplace growth

Customer behavior

Seller performance

Delivery efficiency

Review score impact

Logistics and freight behavior

Category-wise revenue trends

The project replicates a real Business Analyst workflow using:

SQL for transformations, aggregations, and KPI creation

Power BI for dashboard construction

Business interpretation for insights and conclusions

Repository Structure
/sql
    ├── monthly_orders.sql
    ├── category_freight_summary.sql
    ├── seller_revenue_summary.sql
    ├── review_delay_analysis.sql
    ├── city_orders_summary.sql
    ├── state_delivery_time_summary.sql
    ├── review_score_distribution.sql

/powerbi
    ├── Olist_Marketplace_Dashboard.pbix

/dashboards
    ├── dashboard_1.png
    ├── dashboard_2.png

README.md

SQL Queries Used in the Project

Below are the main SQL queries used to generate the datasets for analysis and dashboards.

Monthly Orders (Trend Analysis)
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1;


Insights Used in Dashboard

Orders increased from 4 per month in 2016 to over 7,000 per month in 2018

Strong seasonal pattern with peaks around November to January

Indicates holiday and promotional effects on demand

Category Freight Summary
SELECT
    p.product_category_name_english,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight_value,
    COUNT(*) AS total_orders
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY 1
ORDER BY avg_freight_value DESC;


Insights Used in Dashboard

Furniture, electronics, and heavy product categories have the highest freight costs

Suggests weight and volume-based logistics pricing

Seller Revenue Summary
SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY 1
ORDER BY total_revenue DESC;


Insights Used in Dashboard

Top 10 sellers contribute approximately 25–30 percent of total GMV

Revenue follows a long-tail distribution pattern

State-wise Delivery Time
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


Insights Used in Dashboard

Northern states have significantly longer delivery times

Southeastern states such as SP, RJ, and MG receive faster deliveries due to stronger logistics networks

City-Level Order Distribution
SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY total_orders DESC;


Insights Used in Dashboard

São Paulo has the highest order volume by a wide margin

Purchases are heavily concentrated in metropolitan areas

Review Score Distribution
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;


Insights Used in Dashboard

Most reviews are rated 4 or 5

Low review scores correlate strongly with late deliveries

Review Score vs Delivery Delay
SELECT
    r.review_score,
    d.delay_days
FROM review_delay_analysis d
JOIN order_reviews r ON d.order_id = r.order_id
WHERE r.review_score IS NOT NULL;


Insights

On-time or early deliveries receive average scores between 4.3 and 4.7

Very late deliveries (more than 15 days) drop average ratings to 2.0–2.5

Dashboard 1 — Business Performance Overview

KPIs Displayed

Monthly Orders Trend

Delivery Status Breakdown

Top Product Categories by Revenue

Average Delay Days

Average Review Score

Payment Method Breakdown

Key Insights

Order volume increased more than fourfold from 2016 to 2018

Seventy-two percent of deliveries are on-time or early

Credit card is the primary payment method used by customers

Categories such as bed/bath, electronics, and health and beauty generate the most revenue

Delivery delay is a major factor influencing customer review scores

Dashboard 2 — Customer and Logistics Overview

KPIs Displayed

Seller Revenue Distribution

Top Customer Cities

Average Freight Value by Category

Review Score Distribution

Average Delivery Time by State

Delay Bucket vs Review Score

Key Insights

São Paulo, Rio de Janeiro, and Belo Horizonte are the largest demand centers

Heavy product categories incur higher freight charges

Delivery time varies significantly by region

Significant delay results in lower customer satisfaction and lower ratings

Data Model (Conceptual)
orders
 ├── order_items (one-to-many)
 │     └── products
 │     └── sellers
 ├── order_payments
 ├── order_reviews
 └── customers
        └── geolocation


This data model enables analysis of:

Revenue across sellers and products

Freight cost patterns

Customer satisfaction and review behavior

Delivery speed and delay patterns

Geographic distribution of customers

Business Conclusions

Olist experienced strong growth between 2016 and 2018

Delivery performance is the most influential factor affecting customer satisfaction

Freight cost optimization could improve margins in heavy product categories

A small group of sellers contributes a large share of total sales

Online purchases are concentrated in major cities

Northern states face slower delivery times due to logistical limitations

Tools Used
Task	Tools
SQL querying	SQLite, DB Browser
Data modeling	SQL joins and aggregations
Dashboarding	Power BI
Documentation	GitHub README
