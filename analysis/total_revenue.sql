SELECT SUM(amount) AS success_payments_amount
FROM {{ ref('stg_payments' ) }}
WHERE payment_method = 'success'