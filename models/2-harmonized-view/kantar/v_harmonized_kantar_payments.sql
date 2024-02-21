
{{
    config(
        materialized = 'view'
    )
}}

SELECT
    *
FROM
    {{ ref('t_harmonized_kantar_payments') }}
