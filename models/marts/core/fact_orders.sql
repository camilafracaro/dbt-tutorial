WITH payments AS (
    SELECT order_id,
        SUM(amount) AS total_amount
    FROM {{ ref('stg_payments') }}
    WHERE payment_status = 'success'
    GROUP BY order_id
)

SELECT o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    p.total_amount
FROM {{ ref('stg_orders') }}  o
LEFT JOIN payments p 
    USING(order_id)