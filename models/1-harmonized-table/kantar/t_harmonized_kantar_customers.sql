
{{
    config(
        materialized = 'table'
    )
}}

SELECT
    CAST(TRIM(ID) AS INT64) AS CUSTOMER_ID,
    TRIM(FIRST_NAME) AS CUSTOMER_FIRST_NAME,
    TRIM(LAST_NAME) AS CUSTOMER_LAST_NAME,
    BQ_INSERT_TIMESTAMP
FROM
    {{ source('raw_kantar', 'v_raw_kantar_customers') }}
WHERE
    BQ_INSERT_TIMESTAMP = (SELECT MAX(BQ_INSERT_TIMESTAMP) AS MAX_BQ_INSERT_TIMESTAMP FROM {{ source('raw_kantar', 'v_raw_kantar_customers') }})
