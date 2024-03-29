
SELECT
    CUSTOMERS.CUSTOMER_FIRST_NAME,
    CUSTOMERS.CUSTOMER_LAST_NAME,
    COALESCE(COUNT(ORDERS.ORDER_SK), 0) AS NUMBER_OF_ORDERS,
    MAX(ORDERS.ORDER_DATE) AS MOST_RECENT_ORDER_DATE,
    MIN(ORDERS.ORDER_DATE) AS FIRST_ORDER_DATE
FROM
    {{ ref('t_domain_kantar_fact_orders') }} ORDERS
    LEFT OUTER JOIN {{ ref('t_domain_kantar_dim_customers') }} CUSTOMERS ON (CUSTOMERS.CUSTOMER_SK = ORDERS.CUSTOMER_SK)
GROUP BY
    1, 2
