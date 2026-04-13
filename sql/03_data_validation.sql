SELECT order_id, COUNT(*)
FROM stg_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT customer_id, COUNT(*)
FROM stg_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*)
FROM stg_products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS missing_customers
FROM stg_orders
WHERE customer_id IS NULL;

SELECT COUNT(*) AS missing_products
FROM stg_order_items
WHERE product_id IS NULL;

SELECT COUNT(*) AS missing_order_id
FROM stg_payments
WHERE order_id IS NULL;

SELECT 
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    MIN(freight_value) AS min_freight,
    MAX(freight_value) AS max_freight
FROM stg_order_items;

SELECT 
    MIN(payment_value),
    MAX(payment_value)
FROM stg_payments;


SELECT COUNT(*)
FROM stg_orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

SELECT 
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date
FROM stg_orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

SELECT COUNT(*)
FROM stg_orders
WHERE order_delivered_customer_date < order_purchase_timestamp;
DELETE FROM stg_orders
WHERE order_id = 'order_id';



