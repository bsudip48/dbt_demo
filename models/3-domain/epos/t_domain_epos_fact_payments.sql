
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
                {{ ref('t_domain_nielsen_fact_payments') }}
        )

SELECT
    *
FROM
    REFERENCE_DATASET

UNION ALL

SELECT
    *
FROM
    {{ ref('t_domain_kantar_fact_payments') }}
WHERE
    PAYMENT_SK NOT IN (SELECT DISTINCT PAYMENT_SK FROM REFERENCE_DATASET)
