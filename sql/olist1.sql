select * from customers limit 5;

pragma table_info(orders);

create table monthly_orders as
SELECT strftime('%Y-%m',order_purchase_timestamp) AS order_month,
count(order_id) AS total_orders
from orders
group by order_month
order by order_month;

create table category_level_sales as
select p.product_category_name,t.product_category_name_english,
sum(oi.price) as total_sales,
count(oi.order_id) as total_orders
from order_items as oi
left join products p on oi.product_id=p.product_id
left join product_category_name_translation t on p.product_category_name=t.product_category_name
group by 
p.product_category_name,t.product_category_name_english
order by 
total_sales DESC;

create table payment_breakdown as
SELECT 
    payment_type,
    COUNT(*) AS payment_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM order_payments), 2) AS payment_percentage,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY payment_count DESC;



-- 1) Drop old table if it exists
DROP TABLE IF EXISTS delivery_performance;

-- 2) Recreate it with correct delay + delivery time
CREATE TABLE delivery_performance AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_estimated_delivery_date,
    o.order_delivered_customer_date,

    -- Actual delivery time in days (purchase -> delivered)
    CAST(
        JULIANDAY(o.order_delivered_customer_date) 
        - JULIANDAY(o.order_purchase_timestamp)
        AS INTEGER
    ) AS actual_delivery_days,

    -- Delay = delivered - estimated (negative = early, positive = late)
    CAST(
        JULIANDAY(o.order_delivered_customer_date) 
        - JULIANDAY(o.order_estimated_delivery_date)
        AS INTEGER
    ) AS delay_days,

    -- On-time / Late flag
    CASE 
        WHEN o.order_delivered_customer_date IS NULL THEN 'Not delivered'
        WHEN JULIANDAY(o.order_delivered_customer_date) 
             - JULIANDAY(o.order_estimated_delivery_date) <= 0 
            THEN 'On-time'
        ELSE 'Late'
    END AS delivery_status

FROM orders o
WHERE o.order_purchase_timestamp IS NOT NULL;

select * from delivery_performance
LIMIT 10;

-- 1) Drop if exists
DROP TABLE IF EXISTS city_orders_summary;

