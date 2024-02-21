
{{
    config(
        materialized = 'table'
    )
}}

SELECT
    MD5('NIELSEN' || 'CUSTOMER' || CUSTOMER_FIRST_NAME || CUSTOMER_LAST_NAME) AS CUSTOMER_SK,
    CUSTOMER_ID AS SOURCE_CUSTOMER_ID,
    CUSTOMER_FIRST_NAME,
    CUSTOMER_LAST_NAME
FROM
    {{ ref('v_harmonized_nielsen_customers') }}
