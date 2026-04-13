-- =====================================================================
-- DIM TABLES LOAD SCRIPT
-- Purpose : Truncate and reload all dimension tables from staging
-- Strategy: TRUNCATE first → safe re-runnable loads, no duplicate risk
-- Order   : Independent dims first (customers, products, sellers,
--           category, geography) before any dependent fact tables
-- =====================================================================


-- =====================================================================
-- 1. dim_customers
-- Source : stg_customers
-- PK     : customer_id
-- =====================================================================
TRUNCATE TABLE dim_customers;

INSERT INTO dim_customers (
    customer_id,
    customer_unique_id,
    zip_code_prefix,
    city,
    state
)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM stg_customers;

SELECT 'dim_customers' AS table_name, COUNT(*) AS row_count FROM dim_customers;


-- =====================================================================
-- 2. dim_products
-- Source : stg_products
-- PK     : product_id
-- =====================================================================
TRUNCATE TABLE dim_products;

INSERT INTO dim_products (
    product_id,
    category_name,
    name_length,
    description_length,
    photos_qty,
    weight_g,
    length_cm,
    height_cm,
    width_cm
)
SELECT DISTINCT
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM stg_products;

SELECT 'dim_products' AS table_name, COUNT(*) AS row_count FROM dim_products;


-- =====================================================================
-- 3. dim_sellers
-- Source : stg_sellers
-- PK     : seller_id
-- =====================================================================
TRUNCATE TABLE dim_sellers;

INSERT INTO dim_sellers (
    seller_id,
    zip_code_prefix,
    city,
    state
)
SELECT DISTINCT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM stg_sellers;

SELECT 'dim_sellers' AS table_name, COUNT(*) AS row_count FROM dim_sellers;


-- =====================================================================
-- 4. dim_category
-- Source : stg_category_translation
-- PK     : category_name
-- =====================================================================
TRUNCATE TABLE dim_category;

INSERT INTO dim_category (
    category_name,
    category_name_english
)
SELECT DISTINCT
    product_category_name,
    product_category_name_english
FROM stg_category_translation;

SELECT 'dim_category' AS table_name, COUNT(*) AS row_count FROM dim_category;


-- =====================================================================
-- 5. dim_geography
-- Source : stg_geolocation
-- PK     : zip_code_prefix
-- Note   : Multiple lat/lng rows per zip → averaged for one clean row
-- =====================================================================
TRUNCATE TABLE dim_geography;

INSERT INTO dim_geography (
    zip_code_prefix,
    latitude,
    longitude,
    city,
    state
)
SELECT
    geolocation_zip_code_prefix,
    AVG(geolocation_lat)   AS latitude,
    AVG(geolocation_lng)   AS longitude,
    MIN(geolocation_city)  AS city,
    MIN(geolocation_state) AS state
FROM stg_geolocation
GROUP BY geolocation_zip_code_prefix;

SELECT 'dim_geography' AS table_name, COUNT(*) AS row_count FROM dim_geography;


-- =====================================================================
-- END OF DIM LOAD SCRIPT
-- =====================================================================