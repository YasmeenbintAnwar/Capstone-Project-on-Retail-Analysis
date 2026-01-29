SELECT *
FROM sales_data_sample
LIMIT 10;
SELECT *
FROM sales_data_sample
WHERE status = 'Shipped';
SELECT *
FROM sales_data_sample
WHERE dealsize = 'Large';
SELECT SUM(sales) AS total_sales
FROM sales_data_sample;
SELECT productline;
SELECT AVG(sales) AS average_order_value
FROM sales_data_sample;
SELECT year_id,
       SUM(sales) AS yearly_sales
FROM sales_data_sample
GROUP BY year_id
ORDER BY year_id;
CREATE TABLE products (
    product_code VARCHAR(50),
    product_line VARCHAR(100)
);
INSERT INTO products
SELECT DISTINCT productcode, productline
FROM sales_data_sample;
CREATE TABLE customers (
    full_name VARCHAR(100),
    company_name VARCHAR(100),
    phone VARCHAR(30),
    city VARCHAR(50),
    state VARCHAR(50)
);
INSERT INTO customers (full_name, company_name, phone, city, state)
SELECT DISTINCT
       `Full Name`,
       `Company Name`,
       phone,
       city,
       state
FROM sales_data_sample;
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    status VARCHAR(50),
    year INT,
    deal_size VARCHAR(30),
    product_code VARCHAR(50),
    full_name VARCHAR(100),
    quantity INT,
    sales DECIMAL(10,2)
);
INSERT INTO orders
SELECT
    `ORDER ID`,
    STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i'),
    STATUS,
    YEAR_ID,
    DEALSIZE,
    PRODUCTCODE,
    `FULL NAME`,
    QUANTITY,
    SALES
FROM sales_data_sample;
SELECT p.product_line,
       SUM(o.sales) AS total_sales
FROM orders o
JOIN products p
ON o.product_code = p.product_code
GROUP BY p.product_line;
SELECT c.full_name,
       SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c
ON o.full_name = c.full_name
GROUP BY c.full_name;
SELECT c.city,
       SUM(o.sales) AS total_sales;
CREATE VIEW final_sales_analysis AS
SELECT 
    o.order_id,
    o.order_date,
    o.year,
    p.product_line,
    c.city,
    c.state,
    o.deal_size,
    o.quantity,
    o.sales
FROM orders o
JOIN products p ON o.product_code = p.product_code
JOIN customers c ON o.full_name = c.full_name;















