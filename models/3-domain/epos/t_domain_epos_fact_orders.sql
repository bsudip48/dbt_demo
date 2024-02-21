
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
                {{ ref('t_domain_nielsen_fact_orders') }}
        )

SELECT
    *
FROM
    REFERENCE_DATASET

UNION ALL

SELECT
    *
FROM
    {{ ref('t_domain_kantar_fact_orders') }}
WHERE
    ORDER_SK NOT IN (SELECT DISTINCT ORDER_SK FROM REFERENCE_DATASET)
