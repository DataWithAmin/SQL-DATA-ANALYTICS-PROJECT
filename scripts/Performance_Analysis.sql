-- Performance Analysis
-- Comparing the current value to a target value . 
-- Helps measure success and compare performance .


/* Analyze the yearly performance of products by comparing their sales to both the average sales
performance of the product and the previous year sales */ 

WITH yearly_product_sales AS (
SELECT
YEAR(f.order_date) AS order_year , 
p.product_name , 
SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
GROUP BY 
YEAR(f.order_date) , 
p.product_name
)
SELECT 
order_year ,
product_name , 
current_sales ,
AVG(current_sales) OVER (PARTITION BY product_name) avg_sales ,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) as diff_avg ,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 then 'Above Average' 
     WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 then 'Below Average'
     ELSE 'Avg'
END avg_change, 
--Year Over Year Analysis !
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) as py_sales ,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) as diff_py , 
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 then 'Increasing' 
     WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 then 'Decreasing'
     ELSE 'No Change'
END py_change
FROM yearly_product_sales
