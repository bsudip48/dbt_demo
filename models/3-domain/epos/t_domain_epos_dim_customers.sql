
{{
    config(
        materialized = 'table'
    )
}}

WITH
    REFERENCE_DATASET AS
        (
            SELECT
                *
            FROM
                {{ ref('t_domain_nielsen_dim_customers') }}
        )

SELECT
    *
FROM
    REFERENCE_DATASET

UNION ALL

SELECT
    *
FROM
    {{ ref('t_domain_kantar_dim_customers') }}
WHERE
    CUSTOMER_SK NOT IN (SELECT DISTINCT CUSTOMER_SK FROM REFERENCE_DATASET)
