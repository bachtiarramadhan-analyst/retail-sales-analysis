-- ========================================================
-- ============== EXPLORATORY DATA ANALYSIS ===============

-- Total Revenue
SELECT 
	SUM(sales_amount) AS Total_Revenue
FROM retail_sales_clean rsc;

-- Total Transaction
SELECT 
	COUNT(transaction_id) AS Total_Transaction
FROM retail_sales_clean rsc;

-- Revenue by Category
SELECT
	category,
	ROUND(SUM(sales_amount),2) AS Revenue
FROM retail_sales_clean rsc
GROUP BY category
ORDER BY Revenue DESC;

-- Revenue by Region
SELECT 
	region,
	ROUND(SUM(sales_amount),2) AS Revenue
FROM retail_sales_clean rsc 
GROUP BY region 
ORDER BY Revenue DESC;

-- Revenue by Sales Channel
SELECT
	sales_channel,
	ROUND(SUM(sales_amount),2) AS Revenue
FROM retail_sales_clean rsc 
GROUP BY sales_channel 
ORDER BY Revenue DESC;

-- Revenue by Payment Method
SELECT
	rsc.payment_method,
	ROUND(SUM(sales_amount),2) AS Revenue
FROM retail_sales_clean rsc 
GROUP BY payment_method  
ORDER BY Revenue DESC;

-- Revenue by Customer Segments
SELECT
	rsc.customer_segment,
	ROUND(SUM(sales_amount),2) AS Revenue
FROM retail_sales_clean rsc 
GROUP BY customer_segment  
ORDER BY Revenue DESC;

-- Revenue by Age Group
SELECT
	rsc.customer_age_group,
	ROUND(SUM(sales_amount),2) AS Revenue
FROM retail_sales_clean rsc 
GROUP BY customer_age_group  
ORDER BY Revenue DESC;

-- Revenue by Month di Tahun 2024
SELECT
	rsc.Month_Name, 
	ROUND(SUM(sales_amount),2) AS Revenue
FROM retail_sales_clean rsc 
WHERE rsc."Year" = 2024
GROUP BY Month_Name  
ORDER BY Revenue DESC;

-- Revenue by Month di Tahun 2025
SELECT
	rsc.Month_Name, 
	ROUND(SUM(sales_amount),2) AS Revenue
FROM retail_sales_clean rsc 
WHERE rsc."Year" = 2025
GROUP BY Month_Name  
ORDER BY Revenue DESC;

SELECT *
from retail_sales_clean rsc 

-- Weekday vs Weekend
SELECT
    day_type,
    ROUND(SUM(sales_amount),2) AS total_sales
FROM retail_sales_clean
GROUP BY day_type;
