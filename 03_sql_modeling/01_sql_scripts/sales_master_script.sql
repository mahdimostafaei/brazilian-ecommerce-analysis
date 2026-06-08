CREATE OR REPLACE VIEW sales_master AS
SELECT
    -- Fact identifiers
    fs.fact_id,
    fs.order_id,
    fs.order_item_id,

    -- Date dimension
    d.date_key,
    d.year,
    d.month,
    d.month_name,
    d.quarter,
    d.day_of_week,
    d.is_weekend,

    -- Customer dimension
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,

    -- Seller dimension
    s.seller_id,
    s.seller_city,
    s.seller_state,

    -- Product dimension
    p.product_id,
    p.product_category_name,
    p.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,

    -- Order dimension
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    -- Delivery metrics
    (o.order_delivered_customer_date::date - o.order_purchase_timestamp::date)
        AS delivery_days,

    -- Revenue metrics
    fs.price,
    fs.freight_value,
    fs.total_value,

    -- Review
    r.review_score

FROM fact_sales fs

LEFT JOIN dim_date d
    ON fs.date_key = d.date_key

LEFT JOIN dim_customers c
    ON fs.customer_id = c.customer_id

LEFT JOIN dim_products p
    ON fs.product_id = p.product_id

LEFT JOIN dim_sellers s
    ON fs.seller_id = s.seller_id

LEFT JOIN dim_orders o
    ON fs.order_id = o.order_id

LEFT JOIN order_reviews r
    ON fs.order_id = r.order_id;

SELECT * FROM sales_master LIMIT 10

