CREATE TABLE customers_clean (
    customer_id              VARCHAR(50) PRIMARY KEY,
    customer_unique_id       VARCHAR(50),
    customer_zip_code_prefix CHAR(5),
    customer_city            TEXT,
    customer_state           CHAR(2),
    city_normalized          TEXT
);


CREATE TABLE orders_clean (
    order_id                      VARCHAR(50) PRIMARY KEY,
    customer_id                   VARCHAR(50),
    order_status                  TEXT,
    order_purchase_timestamp      TIMESTAMP,
    order_approved_at             TIMESTAMP,
    order_delivered_carrier_date  TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE geolocation_clean (
	geo_id                      BIGSERIAL PRIMARY KEY,
	geolocation_zip_code_prefix CHAR(5),
	geolocation_lat             DOUBLE PRECISION,
	geolocation_lng             DOUBLE PRECISION,
	geolocation_city            TEXT,
	geolocation_state           TEXT,
	city_normalized             TEXT
);

CREATE TABLE order_payments_clean (
	order_id             VARCHAR(50),
	payment_sequential   SMALLINT,
	payment_type         TEXT,
	payment_installments SMALLINT,
	payment_value        DOUBLE PRECISION,

	PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE order_reviews (
	order_review_id         BIGSERIAL PRIMARY KEY,
	review_id               VARCHAR(50),
	order_id                VARCHAR(50),
	review_score            SMALLINT,
	review_comment_title    TEXT,
	review_comment_message  TEXT,
	review_creation_date    TIMESTAMP,
	review_answer_timestamp TIMESTAMP
);

CREATE TABLE products (
	product_id                 VARCHAR(50) PRIMARY KEY,
	product_category_name      TEXT,
	product_name_lenght        INT,
	product_description_lenght INT,
	product_photos_qty         INT,
	product_weight_g           INT,
	product_length_cm          INT,
	product_height_cm          INT,
	product_width_cm           INT
);

CREATE TABLE sellers (
seller_id              VARCHAR(50) PRIMARY KEY,
seller_zip_code_prefix CHAR(5),
seller_city            TEXT,
seller_state           TEXT,
city_normalized        TEXT
);

CREATE TABLE category_translation (
	product_category_name         TEXT,
	product_category_name_english TEXT
);

CREATE TABLE order_items (
order_id            VARCHAR(50),
order_item_id       INT,
product_id          VARCHAR(50),
seller_id           VARCHAR(50),
shipping_limit_date TIMESTAMP,
price               DOUBLE PRECISION,
freight_value       DOUBLE PRECISION,
PRIMARY KEY (order_id, order_item_id)
);

ALTER TABLE order_payments_clean RENAME TO order_payments

