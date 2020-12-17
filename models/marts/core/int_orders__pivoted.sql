{%- call statement('payments_query', fetch_result=True) -%}

SELECT payment_method
FROM {{ ref('stg_payments') }}
GROUP BY payment_method
ORDER BY 1

{%- endcall -%}

{%- set payments = load_result('payments_query') -%}
{%- set payments_data = payments['data'] -%}

SELECT order_id,

{% for payment in payments_data %}
  SUM(CASE payment_method WHEN '{{payment[0]}}' THEN amount ELSE 0 END ) AS {{payment[0]}}_amount, 
{% endfor %}
  SUM(amount) as total_amount
FROM {{ ref('stg_payments') }}
WHERE payment_status = 'success'
GROUP BY order_id