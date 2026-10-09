CREATE DATABASE mzansi_retail;
USE mzansi_retail;
SHOW DATABASES;
CREATE TABLE customers (
customer_id VARCHAR(10) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
gender VARCHAR(10),
age INT,
province VARCHAR(50),
customer_segment VARCHAR(20),
join_date DATE
);

DESCRIBE customers;

CREATE TABLE products (
product_id VARCHAR(10) PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
unit_price DECIMAL(10,2)
);
DESCRIBE products;

CREATE TABLE stores (
store_id VARCHAR(10) PRIMARY KEY,
store_name VARCHAR(100),
city VARCHAR(50),
province VARCHAR(50),
region VARCHAR(50)
);

DESCRIBE stores;

CREATE TABLE orders (
order_id VARCHAR(10) PRIMARY KEY,
customer_id VARCHAR(10),
product_id VARCHAR(10),
store_id VARCHAR(10),
order_date DATE,
quantity INT,
unit_price DECIMAL(10,2),
discount DECIMAL(5,2)
);

DESCRIBE orders;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),

ADD CONSTRAINT fk_orders_product
FOREIGN KEY (product_id)
REFERENCES products(product_id),

ADD CONSTRAINT fk_orders_store
FOREIGN KEY (store_id)
REFERENCES stores(store_id);

SHOW CREATE TABLE orders;

INSERT INTO customers
(customer_id, first_name, last_name, gender, age, province, customer_segment, join_date)
VALUES
('C0001', 'Thabo', 'Mokoena', 'Male', 32, 'Free State', 'Standard', '2024-01-15'),
('C0002', 'Lerato', 'Dlamini', 'Female', 27, 'Gauteng', 'Premium', '2024-02-20'),
('C0003', 'Sipho', 'Nkosi', 'Male', 41, 'KwaZulu-Natal', 'Standard', '2024-03-10'),
('C0004', 'Amahle', 'Ndlovu', 'Female', 35, 'Western Cape', 'Premium', '2024-04-05'),
('C0005', 'Kabelo', 'Molefe', 'Male', 29, 'North West', 'Standard', '2024-05-18'),
('C0006', 'Naledi', 'Maseko', 'Female', 24, 'Mpumalanga', 'Standard', '2024-06-12'),
('C0007', 'Bongani', 'Zulu', 'Male', 38, 'KwaZulu-Natal', 'Premium', '2024-07-22'),
('C0008', 'Palesa', 'Mokoena', 'Female', 31, 'Free State', 'Standard', '2024-08-14'),
('C0009', 'Mandla', 'Khumalo', 'Male', 45, 'Gauteng', 'Premium', '2024-09-03'),
('C0010', 'Zanele', 'Mthembu', 'Female', 28, 'Eastern Cape', 'Standard', '2024-10-11');

SELECT *
FROM customers;

SELECT province, COUNT(*) AS customer_count
FROM customers
GROUP BY province;

INSERT INTO products
(product_id, product_name, category, unit_price)
VALUES
('P0001', 'Samsung 55 Inch TV', 'Electronics', 8999.99),
('P0002', 'Apple AirPods', 'Electronics', 2499.99),
('P0003', 'Nike Running Shoes', 'Clothing', 1499.99),
('P0004', 'Levi Jeans', 'Clothing', 999.99),
('P0005', 'Philips Blender', 'Home & Garden', 899.99),
('P0006', 'Russell Hobbs Kettle', 'Home & Garden', 699.99),
('P0007', 'Apple iPhone 15', 'Electronics', 15999.99),
('P0008', 'Adidas Hoodie', 'Clothing', 1199.99),
('P0009', 'Defy Microwave', 'Home & Garden', 1799.99),
('P0010', 'JBL Bluetooth Speaker', 'Electronics', 1999.99);

SELECT *
FROM products;

SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category;

USE mzansi_retail;

INSERT INTO stores
(store_id, store_name, city, province, region)
VALUES
('S001', 'Rosebank Store', 'Johannesburg', 'Gauteng', 'Gauteng'),
('S002', 'Gateway Store', 'Durban', 'KwaZulu-Natal', 'KwaZulu-Natal'),
('S003', 'Canal Walk Store', 'Cape Town', 'Western Cape', 'Western Cape'),
('S004', 'Menlyn Store', 'Pretoria', 'Gauteng', 'Gauteng'),
('S005', 'Bloemfontein Store', 'Bloemfontein', 'Free State', 'Free State');

SELECT * FROM stores;

INSERT INTO orders
(order_id, customer_id, product_id, store_id, order_date, quantity, unit_price, discount)
VALUES
('O0001', 'C0001', 'P0001', 'S001', '2025-01-10', 1, 8999.99, 0.05),
('O0002', 'C0002', 'P0007', 'S004', '2025-01-15', 1, 15999.99, 0.10),
('O0003', 'C0003', 'P0003', 'S002', '2025-01-22', 2, 1499.99, 0.00),
('O0004', 'C0004', 'P0002', 'S003', '2025-02-05', 1, 2499.99, 0.05),
('O0005', 'C0005', 'P0005', 'S005', '2025-02-12', 2, 899.99, 0.00),
('O0006', 'C0006', 'P0008', 'S004', '2025-02-20', 1, 1199.99, 0.10),
('O0007', 'C0007', 'P0009', 'S002', '2025-03-03', 1, 1799.99, 0.00),
('O0008', 'C0008', 'P0010', 'S001', '2025-03-14', 2, 1999.99, 0.05),
('O0009', 'C0009', 'P0004', 'S004', '2025-03-25', 1, 999.99, 0.00),
('O0010', 'C0010', 'P0006', 'S005', '2025-04-02', 3, 699.99, 0.05);

SELECT * FROM orders;

SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    p.product_name,
    p.category,
    s.store_name,
    s.city,
    o.order_date,
    o.quantity,
    o.unit_price,
    o.discount
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products AS p
    ON o.product_id = p.product_id
JOIN stores AS s
    ON o.store_id = s.store_id;
    
    SELECT
    order_id,
    quantity,
    unit_price,
    discount,
    ROUND( quantity * unit_price * (1 - discount),
    2
    ) AS revenue
    FROM orders;
    
    SELECT 
    ROUND(SUM(quantity * unit_price * (1 - discount)),
    2
    ) AS total_revenue
    FROM orders;
    
    SELECT 
    COUNT(*) AS total_orders
    FROM orders;
    
    SELECT 
    ROUND(SUM(quantity * unit_price * (1 - discount))
    / COUNT(*),
    2
    ) AS average_order_value
    FROM orders;
    
    SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    ROUND(
        SUM(quantity * unit_price * (1 - discount)),
        2
    ) AS monthly_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(quantity * unit_price * (1 - discount)) AS monthly_revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)

SELECT
    order_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        (
            monthly_revenue
            - LAG(monthly_revenue) OVER (ORDER BY order_month)
        )
        / LAG(monthly_revenue) OVER (ORDER BY order_month)
        * 100,
        2
    ) AS mom_growth_percentage
FROM monthly_revenue
ORDER BY order_month;

INSERT INTO orders
(order_id, customer_id, product_id, store_id, order_date, quantity, unit_price, discount)
VALUES
('O0011', 'C0001', 'P0003', 'S001', '2025-04-10', 1, 1499.99, 0.00),
('O0012', 'C0002', 'P0002', 'S004', '2025-04-18', 1, 2499.99, 0.05),
('O0013', 'C0003', 'P0005', 'S002', '2025-05-03', 2, 899.99, 0.00),
('O0014', 'C0004', 'P0007', 'S003', '2025-05-11', 1, 15999.99, 0.10),
('O0015', 'C0005', 'P0008', 'S005', '2025-05-20', 2, 1199.99, 0.05),
('O0016', 'C0006', 'P0010', 'S004', '2025-06-02', 1, 1999.99, 0.00),
('O0017', 'C0007', 'P0001', 'S002', '2025-06-15', 1, 8999.99, 0.10),
('O0018', 'C0008', 'P0004', 'S001', '2025-06-28', 2, 999.99, 0.00),
('O0019', 'C0009', 'P0006', 'S004', '2025-07-05', 1, 699.99, 0.05),
('O0020', 'C0010', 'P0009', 'S005', '2025-07-19', 1, 1799.99, 0.00),

('O0021', 'C0001', 'P0007', 'S001', '2025-08-02', 1, 15999.99, 0.10),
('O0022', 'C0002', 'P0008', 'S004', '2025-08-14', 1, 1199.99, 0.00),
('O0023', 'C0003', 'P0010', 'S002', '2025-08-27', 2, 1999.99, 0.05),
('O0024', 'C0004', 'P0003', 'S003', '2025-09-04', 1, 1499.99, 0.00),
('O0025', 'C0005', 'P0005', 'S005', '2025-09-18', 3, 899.99, 0.10),
('O0026', 'C0006', 'P0002', 'S004', '2025-10-01', 1, 2499.99, 0.05),
('O0027', 'C0007', 'P0009', 'S002', '2025-10-13', 1, 1799.99, 0.00),
('O0028', 'C0008', 'P0001', 'S001', '2025-11-05', 1, 8999.99, 0.15),
('O0029', 'C0009', 'P0003', 'S004', '2025-11-21', 2, 1499.99, 0.05),
('O0030', 'C0010', 'P0007', 'S005', '2025-12-10', 1, 15999.99, 0.10);

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    ROUND(
        SUM(quantity * unit_price * (1 - discount)),
        2
    ) AS monthly_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(quantity * unit_price * (1 - discount)) AS monthly_revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)

SELECT
    order_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        (
            monthly_revenue
            - LAG(monthly_revenue) OVER (ORDER BY order_month)
        )
        / LAG(monthly_revenue) OVER (ORDER BY order_month)
        * 100,
        2
    ) AS mom_growth_percentage
FROM monthly_revenue
ORDER BY order_month;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_orders DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    MAX(o.order_date) AS last_order_date
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY last_order_date;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    MAX(o.order_date) AS last_order_date,
    DATEDIFF(
        '2025-12-31',
        MAX(o.order_date)
    ) AS days_inactive
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY days_inactive DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
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
    c.last_name

ORDER BY days_inactive DESC;

WITH customer_activity AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        MAX(o.order_date) AS last_order_date,
        DATEDIFF(
            '2025-12-31',
            MAX(o.order_date)
        ) AS days_inactive
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT
    customer_id,
    first_name,
    last_name,
    last_order_date,
    days_inactive,
    CASE
        WHEN days_inactive > 90 THEN 'Churned'
        ELSE 'Active'
    END AS customer_status
FROM customer_activity
ORDER BY days_inactive DESC;

WITH customer_activity AS (
    SELECT
        c.customer_id,
        MAX(o.order_date) AS last_order_date,
        DATEDIFF(
            '2025-12-31',
            MAX(o.order_date)
        ) AS days_inactive
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)

SELECT
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN days_inactive > 90 THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN days_inactive > 90 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS churn_rate
FROM customer_activity;

WITH customer_activity AS (
    SELECT
        c.customer_id,
        MAX(o.order_date) AS last_order_date,
        DATEDIFF(
            '2025-12-31',
            MAX(o.order_date)
        ) AS days_inactive
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)

SELECT
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN days_inactive <= 90 THEN 1
            ELSE 0
        END
    ) AS active_customers,

    ROUND(
        SUM(
            CASE
                WHEN days_inactive <= 90 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS retention_rate

FROM customer_activity;

SELECT
    s.region,
    ROUND(
        SUM(
            o.quantity * o.unit_price * (1 - o.discount)
        ),
        2
    ) AS total_revenue
FROM orders AS o
JOIN stores AS s
    ON o.store_id = s.store_id
GROUP BY s.region
ORDER BY total_revenue DESC;

SELECT
    s.region,
    COUNT(o.order_id) AS total_orders,
    ROUND(
        SUM(
            o.quantity * o.unit_price * (1 - o.discount)
        ),
        2
    ) AS total_revenue
FROM orders AS o
JOIN stores AS s
    ON o.store_id = s.store_id
GROUP BY s.region
ORDER BY total_revenue DESC;

SELECT
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity_sold,
    ROUND(
        SUM(
            o.quantity * o.unit_price * (1 - o.discount)
        ),
        2
    ) AS total_revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

SELECT
    COUNT(*) AS total_orders,
    ROUND(
        SUM(
            quantity * unit_price * (1 - discount)
        ),
        2
    ) AS total_revenue
FROM orders;

SELECT
    ROUND(
        SUM(
            quantity * unit_price * (1 - discount)
        ) / COUNT(*),
        2
    ) AS average_order_value
FROM orders;


SELECT
    s.region,
    COUNT(o.order_id) AS total_orders,
    ROUND(
        SUM(
            o.quantity * o.unit_price * (1 - o.discount)
        ),
        2
    ) AS total_revenue
FROM orders AS o
JOIN stores AS s
    ON o.store_id = s.store_id
GROUP BY s.region
ORDER BY total_revenue DESC;

SELECT
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity_sold,
    ROUND(
        SUM(
            o.quantity * o.unit_price * (1 - o.discount)
        ),
        2
    ) AS total_revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

