# Sales_analysis_view
CREATE VIEW sales_analysis_view AS
SELECT
    o.order_id,
    o.order_date,
    
    c.customer_id,
    c.first_name,
    c.last_name,
    c.gender,
    c.age,
    c.province AS customer_province,
    c.customer_segment,
    
    p.product_id,
    p.product_name,
    p.category,
    
    s.store_id,
    s.store_name,
    s.city,
    s.province AS store_province,
    s.region,
    
    o.quantity,
    o.unit_price,
    o.discount,
    
    ROUND(
        o.quantity * o.unit_price * (1 - o.discount),
        2
    ) AS revenue

FROM orders AS o

JOIN customers AS c
    ON o.customer_id = c.customer_id

JOIN products AS p
    ON o.product_id = p.product_id

JOIN stores AS s
    ON o.store_id = s.store_id;
    
    SELECT *
FROM sales_analysis_view;

SELECT COUNT(*) AS total_rows
FROM sales_analysis_view;

# customer_churn_view

CREATE VIEW customer_churn_view AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.gender,
    c.age,
    c.province,
    c.customer_segment,
    c.join_date,
    MAX(o.order_date) AS last_order_date,

    DATEDIFF(
        '2025-12-31',
        MAX(o.order_date)
    ) AS days_inactive,

    CASE
        WHEN DATEDIFF(
            '2025-12-31',
            MAX(o.order_date)
        ) > 90
        THEN 'Churned'
        ELSE 'Active'
    END AS customer_status

FROM customers AS c

LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id

GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.gender,
    c.age,
    c.province,
    c.customer_segment,
    c.join_date;
    
     SELECT *
FROM customer_churn_view;

# verify_churn_model_view

SELECT
    customer_status,
    COUNT(*) AS customer_count
FROM customer_churn_view
GROUP BY customer_status;

