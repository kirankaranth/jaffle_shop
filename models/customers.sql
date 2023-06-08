WITH customer_orders AS (

  {#test comment#}
  SELECT 
    customer_id,
    min(order_date) AS first_order,
    max(order_date) AS most_recent_order,
    count(order_id) AS number_of_orders
  
  FROM orders
  
  GROUP BY customer_id

),

payments AS (

  {#test comment#}
  SELECT * 
  
  FROM {{ ref('stg_payments')}}

),

customer_payments AS (

  {#test comment#}
  SELECT 
    orders.customer_id,
    sum(amount) AS total_amount
  
  FROM payments
  LEFT JOIN orders
     ON payments.order_id = orders.order_id
  
  GROUP BY customer_id

),

customers AS (

  {#test comment#}
  SELECT * 
  
  FROM {{ ref('stg_customers')}}

),

customers AS (

  {#test comment#}
  SELECT * 
  
  FROM {{ ref('stg_customers')}}

),

final AS (

  {#test comment#}
  SELECT 
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order,
    customer_orders.most_recent_order,
    customer_orders.number_of_orders,
    customer_payments.total_amount AS customer_lifetime_value
  
  FROM customers
  LEFT JOIN customer_orders
     ON customers.customer_id = customer_orders.customer_id
  LEFT JOIN customer_payments
     ON customers.customer_id = customer_payments.customer_id

)

SELECT *

FROM final
