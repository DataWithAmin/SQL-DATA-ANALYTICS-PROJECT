-- Cumulative Analysis :
-- Aggregate the data progressively over time .
-- Helps to understand whether our business is growing or declining



--Calculate the total of sales per month
-- and the running total of sales over time + the moving average price
SELECT 
	date_month , 
	total_sales , 
	sum(total_sales) over(partition by date_month order by date_month) as total_running_sales,
	sum(avg_price) over(partition by date_month order by date_month) as moving_average
from 
(
	SELECT 
	 DATETRUNC(MONTH , order_date) as date_month, 
	 sum(sales_amount) as total_sales , 
	 avg(sls_price) as avg_price
	 FROM gold.fact_sales
	 where DATETRUNC(MONTH , order_date) is not null
	 GROUP BY DATETRUNC(MONTH , order_date)  
)t
