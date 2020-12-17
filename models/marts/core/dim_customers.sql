with customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        SUM(total_amount) AS lifetime_value

    from {{ ref('fact_orders') }}

    group by 1

)

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        EMP.employee_id IS NOT NULL AS is_employee,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.lifetime_value, 0) as lifetime_value

    from {{ ref('stg_customers')}} customers

    left join customer_orders 
        using (customer_id)

    LEFT JOIN {{ ref( 'employees') }} EMP
      USING(customer_id)
