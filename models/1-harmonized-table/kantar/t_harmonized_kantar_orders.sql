
{{
    config(
        materialized = 'incremental',
        unique_key = 'ORDER_ID',
        incremental_strategy = 'merge'
    )
}}

SELECT
    CAST(TRIM(ID) AS INT64) AS ORDER_ID,
    CAST(TRIM(CUSTOMER_ID) AS INT64) AS CUSTOMER_ID,
    CAST(TRIM(ORDER_DATE) AS DATE) AS ORDER_DATE,
    UPPER(TRIM(STATUS)) AS ORDER_STATUS,
    BQ_INSERT_TIMESTAMP
FROM
    {{ source('raw_kantar', 'v_raw_kantar_orders') }}
{% if is_incremental() %}
    WHERE
        BQ_INSERT_TIMESTAMP > (SELECT MAX(BQ_INSERT_TIMESTAMP) AS MAX_BQ_INSERT_TIMESTAMP FROM {{ this }})
{% endif %}
