
{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge'
    )
}}

SELECT
    CAST(TRIM(id) AS INT64) AS PAYMENT_ID,
    CAST(TRIM(orderid) AS INT64) AS ORDER_ID,
    UPPER(TRIM(paymentmethod)) AS PAYMENT_METHOD,
    UPPER(TRIM(status)) AS PAYMENT_STATUS,
    CAST(TRIM(amount) AS FLOAT64) AS PAYMENT_AMOUNT,
    BQ_INSERT_TIMESTAMP
FROM
    {{ source('raw_kantar', 'v_raw_kantar_payments') }}
{% if is_incremental() %}
    WHERE
        BQ_INSERT_TIMESTAMP > (SELECT MAX(BQ_INSERT_TIMESTAMP) AS MAX_BQ_INSERT_TIMESTAMP FROM {{ this }})
{% endif %}
