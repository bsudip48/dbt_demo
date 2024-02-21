
{%- set payment_methods = get_column_values(ref('t_domain_kantar_fact_payments'), 'PAYMENT_METHOD', 'ASC') -%}

SELECT
    ORDERS.ORDER_DATE,
    SUM(PAYMENTS.PAYMENT_AMOUNT) AS TOTAL_ORDER_VALUE,
    COUNT(DISTINCT PAYMENTS.PAYMENT_SK) AS NUM_PAYMENTS,
    COUNT(DISTINCT PAYMENTS.PAYMENT_METHOD) AS NUM_PAYMENT_METHODS,
    {%- for payment_method in payment_methods %}
        SUM(CASE WHEN PAYMENTS.PAYMENT_METHOD = '{{payment_method}}' THEN PAYMENTS.PAYMENT_AMOUNT END) AS {{payment_method}}_amount
        {%- if not loop.last %},{% endif -%}
    {% endfor %}
FROM
    {{ ref('t_domain_kantar_fact_payments') }} PAYMENTS
    INNER JOIN {{ ref('t_domain_kantar_fact_orders') }} ORDERS ON (ORDERS.ORDER_SK = PAYMENTS.ORDER_SK)
GROUP BY
    1
