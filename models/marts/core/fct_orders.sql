WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
), payments AS (
    SELECT * FROM {{ ref('stg_payments') }}
), order_payments AS (
    SELECT order_id,
        SUM (
            CASE WHEN status = 'success' THEN amount END
        ) AS amount
    FROM payments
    GROUP BY 1
), final AS (
    SELECT o.order_id,
        o.customer_id,
        o.order_date,
        COALESCE(op.amount, 0) as amount
    FROM orders o
    LEFT JOIN order_payments op USING (order_id)
)

SELECT *
FROM  final