#**Olist Marketplace — SQL + Power BI Business Analysis**

*End-to-End Data Analytics Case Study (2016–2018)*
*By Debjyoti Sengupta*

---

##**Project Overview**

This project analyzes the **Brazilian Olist Marketplace dataset**, containing over **100k e-commerce orders**, to understand:

* Marketplace growth
* Customer behavior
* Seller performance
* Delivery efficiency
* Review score impact
* Logistics & freight behavior
* Category-wise revenue trends

The project replicates a **real Business Analyst workflow** using:

* **SQL** for transformations & KPI creation
* **Power BI** for dashboards
* **Business interpretation** for insights

---

#**Repository Structure**

```
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
```

---

#**SQL Queries Used in the Project**

##**Monthly Orders (Trend Analysis)**

```sql
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1;
```

###  *Result Used in Dashboard*

* Orders grew from **4 per month in 2016** → **7000+ per month in 2018**
* Peak demand months: **Nov–Jan**
* Indicates strong seasonal effects (Black Friday & holiday season)

---

## **Category Freight Summary**

```sql
SELECT
    p.product_category_name_english,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight_value,
    COUNT(*) AS total_orders
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY 1
ORDER BY avg_freight_value DESC;
```

### *Result Used in Dashboard*

* **Furniture, electronics & heavy items** have highest freight
* Indicates weight/volume impact on logistics cost

---

##**Seller Revenue Summary (Top Sellers)**

```sql
SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY 1
ORDER BY total_revenue DESC;
```

### *Result Used in Dashboard*

* Top 10 sellers contribute **25–30%** of total marketplace GMV
* Marketplace follows a **long-tail distribution**

---

## ** State-wise Delivery Time**

```sql
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
```

### *Result Used in Dashboard*

* Northern states have **longer delivery time**
* Southeast states (SP, RJ, MG) get **faster delivery** due to better logistics

---

## **City-level Order Distribution**

```sql
SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY total_orders DESC;
```

### *Result Used in Dashboard*

* **São Paulo** leads massively
* Indicates urban concentration of online shopping

---

## **Review Score Distribution**

```sql
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;
```

### *Result Used in Dashboard*

* Majority of reviews are **4 or 5 stars**
* Low-scoring reviews correlate with **late deliveries**

---

## **Review Score vs Delivery Delay**

```sql
SELECT
    r.review_score,
    d.delay_days
FROM review_delay_analysis d
JOIN order_reviews r ON d.order_id = r.order_id
WHERE r.review_score IS NOT NULL;
```

### Insights:

* Orders delivered **early or on-time** get **4.3–4.7 average rating**
* Orders delayed **>15 days** get **2.0–2.5 ratings**

---

# **Dashboard 1 — Business Performance Overview**


### **KPIs Included:**

* Monthly Orders Trend
* Delivery Status Breakdown
* Top Product Categories by Revenue
* Average Delay Days
* Average Review Score
* Payment Method Breakdown

### **Key Insights**

* Order volume increased **400%** from 2016 to 2018
* **72%** of deliveries are **on-time or early**
* **Credit card** is the dominant payment method
* Categories like *bed/bath*, *electronics*, *health & beauty* dominate revenue
* Delivery delays strongly influence customer review score

---

# **Dashboard 2 — Customer & Logistics Overview**


### **KPIs Included:**

* Seller Revenue Distribution
* Top Customer Cities
* Average Freight Value by Category
* Review Score Distribution
* Average Delivery Time by State
* Delay Bucket vs Review Score

### **Key Insights**

* São Paulo, Rio, Belo Horizonte = **major demand hubs**
* Heavy categories → **highest freight**
* Delivery time shows logistic inequality across states
* Very late deliveries correlate with **poor customer satisfaction**

---

# **Data Model (Conceptual)**

```
orders
 ├── order_items (1:many)
 │     └── products
 │     └── sellers
 ├── order_payments
 ├── order_reviews
 └── customers
        └── geolocation
```

This structure enables multi-table joins for:

* revenue aggregation
* freight cost analysis
* review sentiment
* delivery delay analysis
* customer distribution

---

#  **Business Conclusions**

✔ Olist experienced **rapid growth** (5× in 2 years)
✔ Delivery performance has the **strongest effect** on customer satisfaction
✔ Freight cost optimization needed for heavy categories
✔ Sellers follow a **long-tail** distribution; few sellers contribute bulk of sales
✔ Urban concentration (SP, RJ) drives majority of revenue
✔ Northern states show logistical underperformance

---

#  **Tools Used**

| Task          | Tools                    |
| ------------- | ------------------------ |
| SQL querying  | SQLite + DB Browser      |
| Data modeling | SQL joins / aggregations |
| Dashboarding  | Power BI                 |
| Documentation | GitHub README            |

---

