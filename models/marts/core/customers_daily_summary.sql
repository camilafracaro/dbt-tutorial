SELECT
    {{ dbt_utils.surrogate_key(['customer_id', 'order_date'] ) }} AS id,
    customer_id,
    order_date,
    COUNT(*) AS num_orders

FROM {{ ref('stg_orders') }}
GROUP BY 1, 2, 3