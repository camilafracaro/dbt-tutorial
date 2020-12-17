 SELECT id AS payment_id, 
   orderid AS order_id,
   paymentmethod AS payment_method,
   status AS payment_status,
   {{ cents_to_dollars('amount') }} AS amount,
   created AS created_at
 FROM  {{ source('stripe', 'payment') }} 

 {{ limit_data_in_dev('_batched_at', 1000) }}