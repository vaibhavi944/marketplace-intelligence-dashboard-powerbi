-- =====================
-- DIMENSION TABLES
-- =====================

CREATE TABLE dim_customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    zip_code_prefix INT,
    city TEXT,
    state TEXT
);

CREATE TABLE dim_products (
    product_id TEXT PRIMARY KEY,
    category_name TEXT,
    name_length INT,
    description_length INT,
    photos_qty INT,
    weight_g INT,
    length_cm INT,
    height_cm INT,
    width_cm INT
);

CREATE TABLE dim_sellers (
    seller_id TEXT PRIMARY KEY,
    zip_code_prefix INT,
    city TEXT,
    state TEXT
);

CREATE TABLE dim_geography (
    zip_code_prefix INT,
    latitude NUMERIC,
    longitude NUMERIC,
    city TEXT,
    state TEXT
);

CREATE TABLE dim_category (
    category_name TEXT PRIMARY KEY,
    category_name_english TEXT
);

-- Date dimension (we will populate later)
CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    quarter INT,
    month_name TEXT
);

-- =====================
-- FACT TABLES
-- =====================

CREATE TABLE fact_orders (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE fact_order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC
);

CREATE TABLE fact_payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value NUMERIC
);
