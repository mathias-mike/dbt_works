-- Refund have a negative amount, so total amount should always be >= 0

SELECT order_id, sum(amount) AS total_amount
FROM {{ ref('stg_payments') }}
GROUP BY 1
HAVING total_amount < 0 -- same as "NOT (total_amount >= 0)"