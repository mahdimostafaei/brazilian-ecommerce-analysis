CREATE OR REPLACE VIEW kpi_delivery_performance AS
SELECT
    sm.order_id,
    sm.customer_state,
    
    sm.order_purchase_timestamp::date AS purchase_date,
    sm.order_delivered_customer_date::date AS delivered_date,
    sm.order_estimated_delivery_date::date AS estimated_delivery_date,

    (sm.order_delivered_customer_date::date - sm.order_purchase_timestamp::date)
        AS delivery_days,

    (sm.order_estimated_delivery_date::date - sm.order_purchase_timestamp::date)
        AS estimated_delivery_days,

    CASE
        WHEN sm.order_delivered_customer_date::date > sm.order_estimated_delivery_date::date
        THEN 1
        ELSE 0
    END AS late_delivery_flag

FROM sales_master sm

WHERE sm.order_status = 'delivered'
GROUP BY
    sm.order_id,
    sm.customer_state,
    sm.order_purchase_timestamp,
    sm.order_delivered_customer_date,
    sm.order_estimated_delivery_date,
    sm.order_status;

