-- =========================
-- DIM_CUSTOMERS
-- =========================

CREATE TABLE dim_customers AS
SELECT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
FROM customers;

ALTER TABLE dim_customers
ADD PRIMARY KEY (customer_id);



-- =========================
-- DIM_PRODUCTS
-- =========================

CREATE TABLE dim_products AS
SELECT
    p.product_id,
    p.product_category_name,
    t.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM products p
LEFT JOIN category_translation t
ON p.product_category_name = t.product_category_name;

ALTER TABLE dim_products
ADD PRIMARY KEY (product_id);



-- =========================
-- DIM_SELLERS
-- =========================

CREATE TABLE dim_sellers AS
SELECT
    seller_id,
    seller_city,
    seller_state
FROM sellers;

ALTER TABLE dim_sellers
ADD PRIMARY KEY (seller_id);



-- =========================
-- DIM_ORDERS
-- =========================

CREATE TABLE dim_orders AS
SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM orders;

ALTER TABLE dim_orders
ADD PRIMARY KEY (order_id);

-- =========================
-- DIM_GEOLOCATION
-- =========================

CREATE TABLE dim_geolocation AS
SELECT
    geolocation_state,
    geolocation_city
FROM geolocation
GROUP BY
	geolocation_state,
    geolocation_city;

-- =========================
-- INDEXES FOR JOINS
-- =========================

CREATE INDEX idx_dim_orders_purchase_date
ON dim_orders(order_purchase_timestamp);

CREATE INDEX idx_dim_customers_state
ON dim_customers(customer_state);

CREATE INDEX idx_dim_products_category
ON dim_products(product_category_name_english);
