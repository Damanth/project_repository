CREATE DATABASE Amazon;
USE Amazon;
-- DROP DATABASE Amazon;
-- DROP TABLE amazon_sales;

CREATE TABLE amazon_sales (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    product_id INT NOT NULL,
    product_category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    discount_percent INT NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    discounted_price DECIMAL(10,2) NOT NULL CHECK (discounted_price >= 0),
    quantity_sold INT NOT NULL CHECK (quantity_sold > 0),
    total_revenue DECIMAL(12,2) NOT NULL CHECK (total_revenue >= 0),
    customer_region VARCHAR(50) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating BETWEEN 0 AND 5),
    review_count INT NOT NULL CHECK (review_count >= 0)
);


INSERT INTO amazon_sales (
    order_id,
    order_date,
    product_id,
    product_category,
    price,
    discount_percent,
    discounted_price,
    quantity_sold,
    total_revenue,
    customer_region,
    payment_method,
    rating,
    review_count
) VALUES
(1,'2022-01-15',2637,'Books',128.75,10,115.88,4,463.52,'North America','UPI',3.5,443),
(2,'2022-02-10',2300,'Fashion',302.60,20,242.08,5,1210.40,'Asia','Credit Card',3.7,475),
(3,'2022-03-18',3670,'Sports',495.80,20,396.64,2,793.28,'Europe','UPI',4.4,183),
(4,'2022-04-05',2522,'Books',371.95,15,316.16,4,1264.64,'Middle East','UPI',5.0,212),
(5,'2022-05-22',1717,'Beauty',201.68,0,201.68,4,806.72,'Middle East','UPI',4.6,308),
(6,'2022-06-12',1777,'Sports',385.17,30,269.62,3,808.86,'Asia','Wallet',3.8,489),
(7,'2022-07-09',4068,'Books',15.78,0,15.78,5,78.90,'Asia','UPI',1.6,415),
(8,'2022-08-14',3537,'Fashion',111.59,30,78.11,4,312.44,'Middle East','UPI',3.4,143),
(9,'2022-09-02',3262,'Books',373.62,0,373.62,4,1494.48,'Asia','Wallet',2.8,497),
(10,'2022-10-11',4174,'Sports',134.81,15,114.59,2,229.18,'Middle East','Cash on Delivery',2.0,25),
(11,'2022-11-03',4878,'Electronics',67.43,20,53.94,4,215.76,'Europe','Debit Card',4.3,426),
(12,'2022-12-27',3637,'Books',150.19,0,150.19,1,150.19,'North America','Cash on Delivery',4.4,279),
(13,'2023-01-08',3222,'Electronics',89.81,0,89.81,3,269.43,'Europe','UPI',3.6,151),
(14,'2023-02-16',4925,'Home & Kitchen',213.22,0,213.22,3,639.66,'Europe','Credit Card',1.4,239),
(15,'2023-03-21',1051,'Beauty',66.65,10,59.99,2,119.98,'North America','Debit Card',4.6,262),
(16,'2023-04-12',2101,'Books',420.00,5,399.00,2,798.00,'Asia','UPI',4.1,180),
(17,'2023-05-25',2102,'Fashion',980.00,15,833.00,1,833.00,'Europe','Credit Card',3.9,95),
(18,'2023-06-30',2103,'Electronics',1500.00,10,1350.00,1,1350.00,'North America','Wallet',4.7,210),
(19,'2023-07-11',2104,'Books',250.00,0,250.00,6,1500.00,'Asia','UPI',3.8,75),
(20,'2023-08-09',2105,'Sports',720.00,20,576.00,2,1152.00,'Middle East','Debit Card',4.0,130),
(21,'2023-09-17',2106,'Beauty',540.00,10,486.00,2,972.00,'Europe','UPI',4.5,205),
(22,'2023-10-28',2107,'Electronics',2100.00,18,1722.00,1,1722.00,'Asia','Net Banking',4.8,260),
(23,'2023-11-06',2108,'Books',330.00,5,313.50,3,940.50,'North America','Credit Card',4.2,140),
(24,'2023-12-19',2109,'Fashion',1100.00,25,825.00,2,1650.00,'Europe','UPI',3.7,88),
(25,'2024-01-01',201,'Electronics',1000.00,10,900.00,2,1800.00,'North','Credit Card',4.5,120),
(26,'2024-02-04',202,'Books',500.00,5,475.00,3,1425.00,'South','UPI',4.2,80),
(27,'2024-03-15',203,'Clothing',1500.00,20,1200.00,1,1200.00,'East','Debit Card',3.9,40),
(28,'2024-04-18',204,'Electronics',2000.00,15,1700.00,2,3400.00,'West','Credit Card',4.8,200),
(29,'2024-05-23',205,'Books',300.00,0,300.00,5,1500.00,'North','UPI',4.0,60),
(30,'2024-06-30',206,'Electronics',2500.00,10,2250.00,1,2250.00,'South','Net Banking',4.7,150);



select * from amazon_sales;

-- Data Definition Language queries 

DESCRIBE amazon_sales;

ALTER TABLE amazon_sales ADD shipping_cost DECIMAL(8,2) DEFAULT 0 CHECK (shipping_cost >= 0);

ALTER TABLE amazon_sales MODIFY product_category VARCHAR(100);

CREATE INDEX idx_order_date ON amazon_sales(order_date);

CREATE INDEX idx_category_region ON amazon_sales(product_category, customer_region);

ALTER TABLE amazon_sales ADD CONSTRAINT chk_rating CHECK (rating BETWEEN 0 AND 10);

ALTER TABLE amazon_sales RENAME COLUMN customer_region TO region;

ALTER TABLE amazon_sales DROP COLUMN shipping_cost;

RENAME TABLE amazon_sales TO amazon_sales_data;

SELECT * from amazon_sales_data;

DROP TABLE amazon_sales_data;

-- Data Manipulation Language queries 

INSERT INTO amazon_sales (
    order_id, order_date, product_id, product_category,
    price, discount_percent, discounted_price,
    quantity_sold, total_revenue,
    customer_region, payment_method,
    rating, review_count
)
VALUES
(16,'2023-06-15',5001,'Electronics',250.00,10,225.00,2,450.00,'Asia','UPI',4.2,120);

SELECT * FROM amazon_sales;

UPDATE amazon_sales SET discount_percent = 5 WHERE product_category = 'Beauty';

UPDATE amazon_sales SET total_revenue = discounted_price * quantity_sold WHERE order_id = 5; 

UPDATE amazon_sales SET rating = rating + 0.2 WHERE rating < 4;

DELETE FROM amazon_sales WHERE rating <= 2;

SELECT order_id, product_category, total_revenue FROM amazon_sales WHERE customer_region = 'Asia';

UPDATE amazon_sales SET payment_method = 'Digital Wallet' WHERE payment_method IN('UPI','Wallet');

START TRANSACTION;

UPDATE amazon_sales
SET discount_percent = 15
WHERE product_category = 'Books';

DELETE FROM amazon_sales
WHERE review_count = 0;

ROLLBACK;
-- COMMIT;

CREATE INDEX idx_order_date ON amazon_sales(order_date);
CREATE INDEX idx_category_region ON amazon_sales(product_category, customer_region);


-- Daily Revenue Summary
-- Performance Note:
-- Uses index on order_date (idx_order_date).
-- Expect range scan + GROUP BY aggregation.

EXPLAIN ANALYZE
SELECT 
	order_date, 
    SUM(total_revenue) AS daily_revenue,
    SUM(quantity_sold) AS total_units
FROM amazon_sales
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY order_date
ORDER BY order_date;

SELECT 
	order_date, 
    SUM(total_revenue) AS daily_revenue,
    SUM(quantity_sold) AS total_units
FROM amazon_sales
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY order_date
ORDER BY order_date;



-- Revenue by Category and Region
-- Performance Note:
-- Composite index (product_category, customer_region)
-- helps filtering + grouping.

EXPLAIN ANALYZE
SELECT 
    product_category,
    customer_region,
    SUM(total_revenue) AS revenue
FROM amazon_sales
WHERE product_category = 'Electronics'
GROUP BY product_category, customer_region;

SELECT 
    product_category,
    customer_region,
    SUM(total_revenue) AS revenue
FROM amazon_sales
WHERE product_category = 'Electronics'
GROUP BY product_category, customer_region;



-- Join: Category Performance
-- Performance Note:
-- Derived table aggregation executed first,
-- then hash/merge join on product_category.

EXPLAIN ANALYZE
SELECT a.order_id,
       a.product_category,
       a.total_revenue,
       c.avg_category_revenue
FROM amazon_sales a
JOIN (
    SELECT product_category,
           AVG(total_revenue) AS avg_category_revenue
    FROM amazon_sales
    GROUP BY product_category
) c
ON a.product_category = c.product_category;

SELECT a.order_id,
       a.product_category,
       a.total_revenue,
       c.avg_category_revenue
FROM amazon_sales a
JOIN (
    SELECT product_category,
           AVG(total_revenue) AS avg_category_revenue
    FROM amazon_sales
    GROUP BY product_category
) c
ON a.product_category = c.product_category;



-- Self Join (Same Region)
-- Performance Note:
-- Potentially expensive O(n²) comparison.
-- Index on region reduces scan cost.

EXPLAIN ANALYZE
SELECT a.order_id,
       b.order_id AS compared_order,
       a.customer_region
FROM amazon_sales a
JOIN amazon_sales b
ON a.customer_region = b.customer_region
AND a.order_id < b.order_id;

SELECT a.order_id,
       b.order_id AS compared_order,
       a.customer_region
FROM amazon_sales a
JOIN amazon_sales b
ON a.customer_region = b.customer_region
AND a.order_id < b.order_id;



-- Window Function: Revenue Rank
-- Performance Note:
-- Requires sorting within each category partition.
-- Large datasets benefit from category index.

EXPLAIN ANALYZE
SELECT order_id,
       product_category,
       total_revenue,
       RANK() OVER (
           PARTITION BY product_category
           ORDER BY total_revenue DESC
       ) AS revenue_rank
FROM amazon_sales;

SELECT order_id,
       product_category,
       total_revenue,
       RANK() OVER (
           PARTITION BY product_category
           ORDER BY total_revenue DESC
       ) AS revenue_rank
FROM amazon_sales;


-- Running Revenue Total
-- Performance Note:
-- Full ordered scan required.
-- Sorting cost dominates runtime.

EXPLAIN ANALYZE
SELECT order_date,
	   total_revenue,
       SUM(total_revenue) OVER(
           ORDER BY order_date
       ) AS running_revenue
FROM amazon_sales;

SELECT order_date,
	   total_revenue,
       SUM(total_revenue) OVER(
           ORDER BY order_date
       ) AS running_revenue
FROM amazon_sales;



-- Moving Average (Window Frame)
-- Performance Note:
-- Uses sliding window computation.
-- Efficient but still requires ordered dataset.

EXPLAIN ANALYZE
SELECT order_id,
       order_date,
       AVG(total_revenue) OVER (
           ORDER BY order_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moving_avg
FROM amazon_sales;

SELECT order_id,
       order_date,
       AVG(total_revenue) OVER (
           ORDER BY order_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moving_avg
FROM amazon_sales;



-- CTE: High Revenue Orders
-- Performance Note:
-- Filter pushed down before aggregation.
-- Efficient sequential/index scan expected.

EXPLAIN ANALYZE
WITH high_sales AS (
    SELECT *
    FROM amazon_sales
    WHERE total_revenue > 500
)
SELECT product_category,
       COUNT(*) AS high_sales_orders
FROM high_sales
GROUP BY product_category;

WITH high_sales AS (
    SELECT *
    FROM amazon_sales
    WHERE total_revenue > 500
)
SELECT product_category,
       COUNT(*) AS high_sales_orders
FROM high_sales
GROUP BY product_category;



-- TOP-N: Highest Revenue Orders
-- Performance Note:
-- ORDER BY + LIMIT triggers Top-N heap optimization.
-- Index on total_revenue would further improve.

EXPLAIN ANALYZE
SELECT *
FROM amazon_sales
ORDER BY total_revenue DESC
LIMIT 3;

SELECT *
FROM amazon_sales
ORDER BY total_revenue DESC
LIMIT 3;



-- TOP Rated Products (Filtered)
-- Performance Note:
-- Filter reduces rows before sorting.
-- Index on review_count improves performance.

EXPLAIN ANALYZE
SELECT order_id,
       rating,
       review_count
FROM amazon_sales
WHERE review_count > 100
ORDER BY rating DESC
LIMIT 5;

SELECT order_id,
       rating,
       review_count
FROM amazon_sales
WHERE review_count > 100
ORDER BY rating DESC
LIMIT 5;



-- Revenue Contribution (% of Total)
-- Performance Note:
-- Window aggregation over entire dataset.
-- Requires full scan but computed once.

EXPLAIN ANALYZE
SELECT order_id,
       total_revenue,
       ROUND(
           total_revenue /
           SUM(total_revenue) OVER () * 100, 2
       ) AS revenue_percent
FROM amazon_sales;

SELECT order_id,
       total_revenue,
       ROUND(
           total_revenue /
           SUM(total_revenue) OVER () * 100, 2
       ) AS revenue_percent
FROM amazon_sales;



-- Category Revenue Contribution
-- Performance Note:
-- Partitioned window aggregation.
-- Sorting per category partition required.

EXPLAIN ANALYZE
SELECT order_id,
       product_category,
       total_revenue,
       ROUND(
           total_revenue /
           SUM(total_revenue) OVER (PARTITION BY product_category) * 100, 2
       ) AS category_revenue_percent
FROM amazon_sales;

SELECT order_id,
       product_category,
       total_revenue,
       ROUND(
           total_revenue /
           SUM(total_revenue) OVER (PARTITION BY product_category) * 100, 2
       ) AS category_revenue_percent
FROM amazon_sales;