WITH daily AS (
    SELECT order_date,
      {% for order_status in ['returned', 'completed', 'return_pending', 'shipped', 'placed'] -%}
      SUM(CASE WHEN status = {{ order_status}} THEN 1 ELSE 0 END) AS {{ order_status }}_total,
      {% endfor -%}
      COUNT(*) AS num_orders
    FROM {{ ref( 'stg_orders' ) }}
    GROUP BY order_date
)
SELECT *,
  LAG(order_num) OVER (ORDER BY order_date) AS previous_day_orders
FROM daily