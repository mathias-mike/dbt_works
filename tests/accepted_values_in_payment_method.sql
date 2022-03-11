SELECT payment_method
FROM {{ ref('stg_payments') }}
WHERE payment_method NOT IN ('credit_card', 'coupon', 'bank_transfer', 'gift_card')
