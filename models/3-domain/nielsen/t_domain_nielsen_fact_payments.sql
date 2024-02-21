
{{
    config(
        materialized = 'table'
    )
}}

SELECT
    MD5('NIELSEN' || 'PAYMENTS' || PAYMENTS.PAYMENT_METHOD || PAYMENTS.PAYMENT_STATUS || PAYMENTS.PAYMENT_AMOUNT) AS PAYMENT_SK,
    PAYMENTS.PAYMENT_ID AS SOURCE_PAYMENT_ID,
    DIM_ORDER.ORDER_SK,
    PAYMENTS.ORDER_ID AS SOURCE_ORDER_ID,
    PAYMENTS.PAYMENT_METHOD,
    PAYMENTS.PAYMENT_STATUS,
    PAYMENTS.PAYMENT_AMOUNT
FROM
    {{ ref('v_harmonized_nielsen_payments') }} PAYMENTS
    INNER JOIN {{ ref('t_domain_nielsen_fact_orders') }} DIM_ORDER ON (DIM_ORDER.SOURCE_ORDER_ID = PAYMENTS.ORDER_ID)