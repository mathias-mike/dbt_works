WITH payments AS (
    SELECT id AS payment_id,
        orderid AS order_id,
        paymentmethod AS payment_method,
        status, 
        amount / 100 AS amount, -- Amount is stored in cents and we want to convert to dollar
        created as created_at
    FROM {{ source('stripe', 'payment') }}
)

SELECT *
FROM payments