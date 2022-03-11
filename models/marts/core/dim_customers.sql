WITH 
customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

orders AS (
    SELECT * FROM {{ ref('fct_orders') }}
),

customer_orders AS (
    SELECT customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date,
        COUNT(order_id) as number_of_orders
    FROM orders
    GROUP BY 1
), 

final AS (
    SELECT c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.last_order_date,
        COALESCE(co.number_of_orders, 0) AS number_of_orders
    FROM customers c
    LEFT JOIN customer_orders co
    ON c.customer_id = co.customer_id -- Can use "USING (customer_id)"  instead of ON clause
)

SELECT *
FROM final