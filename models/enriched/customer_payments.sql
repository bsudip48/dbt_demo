
SELECT
    CUSTOMERS.ID AS CUSTOMER_ID,
    CUSTOMERS.FIRST_NAME,
    CUSTOMERS.LAST_NAME,
    PAYMENTS.paymentmethod AS PAYMENT_METHOD,
    COALESCE(SUM(PAYMENTS.amount), 0) AS TOTAL_AMOUNT
FROM
    {{ source('raw_nielsen', 'customers') }} CUSTOMERS
    LEFT OUTER JOIN {{ source('raw_nielsen', 'orders') }} ORDERS ON (ORDERS.USER_ID = CUSTOMERS.ID)
    INNER JOIN {{ source('raw_nielsen', 'payments') }} PAYMENTS ON (PAYMENTS.orderid = ORDERS.ID)
GROUP BY
    1, 2, 3, 4
