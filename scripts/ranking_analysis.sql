-- Which 5 Products generate the highest revenue 

SELECT TOP 5 p.product_name , sum(s.sales_amount) revenue FROM gold.fact_sales as s  
LEFT JOIN gold.dim_products as p 
on s.product_key = p.product_key  
GROUP BY p.product_name 
ORDER BY revenue DESC


-- What are the worst performing products in terms of sales ?

SELECT TOP 20 p.product_name , sum(s.sales_amount) total_sales FROM gold.fact_sales as s
LEFT JOIN gold.dim_products as p  on p.product_key = s.product_key GROUP BY p.product_name ORDER BY total_sales



-- Which 5 Subcategories generate the highest revenue 

SELECT TOP 5 p.subcategory , sum(s.sales_amount) revenue FROM gold.fact_sales as s  
LEFT JOIN gold.dim_products as p 
on s.product_key = p.product_key  
GROUP BY p.subcategory
ORDER BY revenue DESC


-- WORK WITH WINDOW FUNCTIONS 
SELECT
*
FROM
   (
	SELECT TOP 5 p.product_name , sum(s.sales_amount) revenue , 
	ROW_NUMBER() OVER (ORDER BY sum(s.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales as s  
	LEFT JOIN gold.dim_products as p 
	on s.product_key = p.product_key  
	GROUP BY p.product_name 
	)T
WHERE rank_products <= 5


-- THE 3 CUSTOMERS WITH THE FEWEST ORDERS PLACED
SELECT TOP 3 
c.customer_key , 
c.first_name , 
c.last_name ,
COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key , 
c.first_name , 
c.last_name
ORDER BY total_orders
