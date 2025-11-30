# Olist Marketplace — SQL + Power BI Business Analysis  
### End-to-End Data Analytics Case Study (2016–2018)  
**Author:** Debjyoti Sengupta  

---

## 1. Project Overview

This project analyzes the Brazilian **Olist Marketplace** dataset, which contains over **100,000 e-commerce orders** between 2016 and 2018.

Goals:

- Understand marketplace growth over time  
- Analyze customer and seller distribution  
- Measure delivery speed and delays  
- Study review score behaviour  
- Evaluate freight and logistics efficiency  
- Compare category-wise revenue and freight

The workflow is designed to mimic a **Business Analyst** project:

- Use **SQL** for data extraction and KPI creation  
- Use **Power BI** for dashboards  
- Translate numbers into **business insights**

---

## 2. Repository Structure

```text
/sql
        olist1.sql
        olist2.sql

/powerbi
    Olist_Marketplace_Dashboard.pbix

/dashboards
    dashboard_1.png
    dashboard_2.png

## 3. Dashboard 1 – Business Performance Overview

File: dashboards/dashboard_1.png

Visuals

Monthly orders trend

Delivery status breakdown (on-time vs late vs not delivered)

Payment method distribution

Top revenue-generating product categories

Average delay days

Average review score

Key Findings

Order volume increased by more than 400% from 2016 to 2018.

Credit card is the most commonly used payment method.

Over 70% of orders are delivered on time or earlier.

Categories including health & beauty, bed/bath, electronics generate the highest sales.

Delivery performance has a visible impact on average review score.

## 4. Dashboard 2 – Customer and Logistics Overview

File: dashboards/dashboard_2.png

Visuals

Seller revenue ranking

Top customer cities by order volume

Average freight value by category

Review score distribution

Average delivery days by state

Average review score by delay bucket

Key Findings

Major cities such as São Paulo and Rio de Janeiro are core demand centers.

Heavy / bulky product categories yield higher freight costs.

Delivery performance varies across states, suggesting unequal logistics efficiency.

Very late deliveries correspond to noticeably lower review scores.

## 5. Business Conclusions

The marketplace experienced rapid growth between 2016 and 2018.

Delivery performance is the strongest driver of customer satisfaction.

Freight optimization opportunities exist, particularly for heavy categories.

Seller performance shows a long-tail pattern, with a few high-impact sellers.

Urban regions dominate online order volume, especially São Paulo.

State-level delivery times highlight where logistics investment could yield improvement.

## 6. Tools Used
Task	Tools
SQL querying	SQLite, DB Browser
Data modelling	SQL joins and aggregations
Dashboarding	Power BI
Documentation	GitHub README / Markdown

## 7. Author

Debjyoti Sengupta
MSc Data Science
