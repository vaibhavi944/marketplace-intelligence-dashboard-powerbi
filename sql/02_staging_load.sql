DROP TABLE IF EXISTS stg_orders;
DROP TABLE IF EXISTS stg_order_items;
DROP TABLE IF EXISTS stg_customers;
DROP TABLE IF EXISTS stg_products;
DROP TABLE IF EXISTS stg_sellers;
DROP TABLE IF EXISTS stg_payments;
DROP TABLE IF EXISTS stg_reviews;
DROP TABLE IF EXISTS stg_geolocation;
DROP TABLE IF EXISTS stg_category_translation;

CREATE TABLE stg_orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TEXT,
    order_approved_at TEXT,
    order_delivered_carrier_date TEXT,
    order_delivered_customer_date TEXT,
    order_estimated_delivery_date TEXT
);

CREATE TABLE stg_order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TEXT,
    price NUMERIC,
    freight_value NUMERIC
);

CREATE TABLE stg_customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix INT,
    customer_city TEXT,
    customer_state TEXT
);

CREATE TABLE stg_products (
    product_id TEXT,
    product_category_name TEXT,
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

CREATE TABLE stg_sellers (
    seller_id TEXT,
    seller_zip_code_prefix INT,
    seller_city TEXT,
    seller_state TEXT
);

CREATE TABLE stg_payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value NUMERIC
);

CREATE TABLE stg_reviews (
    review_id TEXT,
    order_id TEXT,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TEXT,
    review_answer_timestamp TEXT
);

CREATE TABLE stg_geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city TEXT,
    geolocation_state TEXT
);

CREATE TABLE stg_category_translation (
    product_category_name TEXT,
    product_category_name_english TEXT
);


COPY stg_orders
FROM 'C:/Users/vaibh/OneDrive/Desktop/End-to-End Revenue & Operations Analytics/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM stg_orders;

SELECT COUNT(*) FROM stg_category_translation;

SELECT 
    'stg_orders' AS table_name, COUNT(*) FROM stg_orders
UNION ALL
SELECT 'stg_order_items', COUNT(*) FROM stg_order_items
UNION ALL
SELECT 'stg_customers', COUNT(*) FROM stg_customers
UNION ALL
SELECT 'stg_products', COUNT(*) FROM stg_products
UNION ALL
SELECT 'stg_sellers', COUNT(*) FROM stg_sellers
UNION ALL
SELECT 'stg_payments', COUNT(*) FROM stg_payments
UNION ALL
SELECT 'stg_reviews', COUNT(*) FROM stg_reviews
UNION ALL
SELECT 'stg_geolocation', COUNT(*) FROM stg_geolocation
UNION ALL
SELECT 'stg_category_translation', COUNT(*) FROM stg_category_translation;

TRUNCATE TABLE stg_orders;
TRUNCATE TABLE stg_geolocation;

