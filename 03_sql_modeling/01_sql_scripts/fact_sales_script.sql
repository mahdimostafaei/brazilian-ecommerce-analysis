-- 1. Create the Fact Table structure
CREATE TABLE fact_sales (
    fact_id BIGSERIAL PRIMARY KEY,
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    customer_id VARCHAR(50),
    date_key DATE,
    price NUMERIC(10, 2),
    freight_value NUMERIC(10, 2),
    total_value NUMERIC(10, 2)
);

-- 2. Populate the table using a JOIN
INSERT INTO fact_sales (order_id, order_item_id, product_id, seller_id, customer_id, date_key, price, freight_value, total_value)
SELECT 
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    o.customer_id,
    o.order_purchase_timestamp::DATE AS date_key,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS total_value
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id;

-- 3. Add Indexes for fast analytical performance
CREATE INDEX idx_fact_sales_date ON fact_sales(date_key);
CREATE INDEX idx_fact_sales_customer ON fact_sales(customer_id);
CREATE INDEX idx_fact_sales_product ON fact_sales(product_id);

--adding a seller index

CREATE INDEX IF NOT EXISTS idx_fact_sales_seller ON fact_sales(seller_id);
SELECT indexname FROM pg_indexes WHERE tablename = 'fact_sales';

ALTER TABLE fact_sales
ADD COLUMN review_score INT;

UPDATE fact_sales fs
SET review_score = r.review_score
FROM order_reviews r
WHERE fs.order_id = r.order_id;

SELECT * FROM fact_sales LIMIT 5
