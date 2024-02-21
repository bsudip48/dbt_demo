
{{
    config(
        materialized = 'view'
    )
}}

SELECT
    *
FROM
    {{ ref('t_harmonized_nielsen_orders') }}
