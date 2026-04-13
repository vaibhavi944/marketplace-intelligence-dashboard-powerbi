SELECT 
    SUM(price + freight_value) AS total_item_revenue
FROM fact_order_items;

SELECT 
    SUM(payment_value) AS total_payment_revenue
FROM fact_payments;


SELECT COUNT(*)
FROM fact_orders fo
LEFT JOIN fact_order_items fi
ON fo.order_id = fi.order_id
WHERE fi.order_id IS NULL;

SELECT 
    order_status,
    COUNT(*) AS order_count
FROM fact_orders
GROUP BY order_status
ORDER BY order_count DESC;


