CREATE TABLE city_orders_summary AS
SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_city;



CREATE TABLE category_freight_summary AS
SELECT
    t.product_category_name_english AS product_category_name_english,
    AVG(oi.freight_value)          AS avg_freight,
    COUNT(*)                       AS item_count
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY
    t.product_category_name_english;



CREATE TABLE seller_revenue_summary AS
SELECT
    seller_id,
    SUM(price + freight_value)      AS total_revenue,
    COUNT(DISTINCT order_id)        AS total_orders,
    COUNT(*)                        AS total_items
FROM order_items
GROUP BY
    seller_id;

	


CREATE TABLE review_score_distribution AS
SELECT
    review_score,
    COUNT(review_id) AS total_reviews
FROM order_reviews
GROUP BY
    review_score
ORDER BY
    review_score;


	


CREATE TABLE review_delay_analysis AS
SELECT
    r.review_id,
    r.order_id,
    r.review_score,
    CAST(
        JULIANDAY(o.order_delivered_customer_date)
        - JULIANDAY(o.order_estimated_delivery_date)
        AS INTEGER
    ) AS delay_days
FROM order_reviews r
JOIN orders o
    ON r.order_id = o.order_id
WHERE
    o.order_delivered_customer_date IS NOT NULL;





CREATE TABLE state_delivery_time_summary AS
SELECT
    c.customer_state,
    AVG(
        JULIANDAY(o.order_delivered_customer_date)
        - JULIANDAY(o.order_purchase_timestamp)
    ) AS avg_delivery_days,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE
    o.order_delivered_customer_date IS NOT NULL
GROUP BY
    c.customer_state;

	
PRAGMA table_info(review_delay_analysis);

DROP TABLE IF EXISTS review_delay_distribution;

CREATE TABLE review_delay_distribution AS
SELECT
    order_id,
    review_score,
    delay_days,

    CASE
        WHEN delay_days IS NULL THEN 'Unknown'
        WHEN delay_days <= -5 THEN 'Early (<= -5 days)'
        WHEN delay_days BETWEEN -4 AND 0 THEN 'On-time (-4 to 0 days)'
        WHEN delay_days BETWEEN 1 AND 5 THEN 'Slightly Late (1–5 days)'
        WHEN delay_days BETWEEN 6 AND 15 THEN 'Late (6–15 days)'
        WHEN delay_days > 15 THEN 'Very Late (> 15 days)'
        ELSE 'Unknown'
    END AS delay_bucket

FROM review_delay_analysis
WHERE review_score IS NOT NULL;

