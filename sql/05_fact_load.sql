-- ===============================
-- 05_fact_load.sql (FINAL CLEAN)
-- ===============================

-- 🔥 STEP 1: CLEAR TABLES (ORDER MATTERS)
DELETE FROM fact_order_items;
DELETE FROM fact_payments;
DELETE FROM fact_orders;

-- ===============================
-- 🔥 STEP 2: LOAD FACT_ORDERS (DEDUPED)
-- ===============================
INSERT INTO fact_orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
SELECT DISTINCT ON (order_id)
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp::timestamp,
    order_approved_at::timestamp,
    order_delivered_carrier_date::timestamp,
    order_delivered_customer_date::timestamp,
    order_estimated_delivery_date::timestamp
FROM stg_orders
ORDER BY order_id, order_purchase_timestamp DESC;


-- ===============================
-- 🔥 STEP 3: LOAD FACT_PAYMENTS (AGGREGATED PER ORDER)
-- ===============================
-- This is the KEY FIX (removes inflation permanently)

INSERT INTO fact_payments (
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
SELECT
    order_id,
    1 AS payment_sequential,
    'combined' AS payment_type,
    SUM(payment_installments) AS payment_installments,
    SUM(payment_value) AS payment_value
FROM stg_payments
GROUP BY order_id;


-- ===============================
-- 🔥 STEP 4: LOAD FACT_ORDER_ITEMS (DEDUPED)
-- ===============================
INSERT INTO fact_order_items (
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
SELECT DISTINCT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date::timestamp,
    price,
    freight_value
FROM stg_order_items;


-- ===============================
-- 🔍 STEP 5: VALIDATION CHECKS
-- ===============================

-- Check payments per order (must be 1)
SELECT MAX(cnt) AS max_payments_per_order
FROM (
    SELECT order_id, COUNT(*) cnt
    FROM fact_payments
    GROUP BY order_id
) t;

-- Final Revenue Check (Delivered Only)
SELECT 
    SUM(fp.payment_value) AS total_revenue
FROM fact_orders fo
JOIN fact_payments fp 
ON fo.order_id = fp.order_id
WHERE fo.order_status = 'delivered';