-- Explore all Objects in the Database 

Select * FROM INFORMATION_SCHEMA.TABLES

-- Explore All Columns in the database

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'dim_customers'

-- Explore All countries our customers come from

SELECT DISTINCT country FROM gold.dim_customers

-- Explore All Categories ´the major Divisions´

SELECT DISTINCT category , subcategory , product_name FROM gold.dim_products
ORDER BY 1,2,3


-- Find the date of the first and last order 

SELECT
MIN(order_date) first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year,MIN(order_date) , MAX(order_date)) as order_range_months
FROM gold.fact_sales

-- Find the youngest customer 

SELECT 
MIN(birthday) OldestCustomer ,
DATEDIFF(year ,MIN(birthday) , GETDATE()) ,
MAX(birthday) YoungestCustomer , 
DATEDIFF(year ,MAX(birthday) , GETDATE())
FROM gold.dim_customers


--Find the Total Sales
select sum(sales_amount) as total_sales from gold.fact_sales
--Find how many Items are sold 
select sum(quantity) as total_quantity from gold.fact_sales
--Find the average selling price 
select avg(sls_price) as average_price from gold.fact_sales
--Find the Total number of Orders
select count(distinct order_number) as total_orders from gold.fact_sales
--Find the total number of Products
select count(distinct product_key) as total_products from gold.dim_products
--Find the the Total number of customers
select count(customer_id) as total_customers FROM gold.dim_customers
--Find the total number of customers that has placed an order
select count(distinct customer_key)  as Total_customers_with_order 
FROM gold.fact_sales


-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(sls_price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;


