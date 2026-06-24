-- ========================================================
-- ============== FEATURE ENGINEERING =====================

-- Membuat Tahun saja
ALTER TABLE retail_sales_clean 
ADD COLUMN Year INTEGER;

UPDATE retail_sales_clean 
SET Year = CAST(STRFTIME("%Y", transaction_date) AS INTEGER);

-- Membuat Num_Bulan
ALTER TABLE retail_sales_clean
ADD COLUMN month_num INTEGER;

UPDATE retail_sales_clean
SET month_num = CAST(strftime('%m', transaction_date) AS INTEGER);

-- Membuat Bulan saja
ALTER TABLE retail_sales_clean 
ADD COLUMN Month_Name TEXT;

UPDATE retail_sales_clean
SET month_name =
CASE strftime('%m', transaction_date)
    WHEN '01' THEN 'January'
    WHEN '02' THEN 'February'
    WHEN '03' THEN 'March'
    WHEN '04' THEN 'April'
    WHEN '05' THEN 'May'
    WHEN '06' THEN 'June'
    WHEN '07' THEN 'July'
    WHEN '08' THEN 'August'
    WHEN '09' THEN 'September'
    WHEN '10' THEN 'October'
    WHEN '11' THEN 'November'
    WHEN '12' THEN 'December'
END;
	
-- Membuat Quarter
ALTER TABLE retail_sales_clean
ADD COLUMN Quarter TEXT;

UPDATE retail_sales_clean
SET Quarter = 
CASE 
	WHEN CAST(STRFTIME('%m', transaction_date) AS INTEGER) BETWEEN 1 AND 3 THEN 'Q1'
	WHEN CAST(STRFTIME('%m', transaction_date) AS INTEGER) BETWEEN 4 AND 6 THEN 'Q2'
	WHEN CAST(STRFTIME('%m', transaction_date) AS INTEGER) BETWEEN 7 AND 9 THEN 'Q3'
	ELSE 'Q4'
END


-- Membuat Day_Name
ALTER TABLE retail_sales_clean
ADD COLUMN Day_Name TEXT;

UPDATE retail_sales_clean
SET day_name =
CASE strftime('%w', transaction_date)
    WHEN '1' THEN 'Monday'
    WHEN '2' THEN 'Tuesday'
    WHEN '3' THEN 'Wednesday'
    WHEN '4' THEN 'Thursday'
    WHEN '5' THEN 'Friday'
    WHEN '6' THEN 'Saturday'
    WHEN '0' THEN 'Sunday'
END;

-- Membuat Day_Num
ALTER TABLE retail_sales_clean
ADD COLUMN Day_Num INTEGER;

UPDATE retail_sales_clean
SET Day_Num =
CASE strftime('%w', transaction_date)
    WHEN '1' THEN 1  -- Monday
    WHEN '2' THEN 2  -- Tuesday
    WHEN '3' THEN 3  -- Wednesday
    WHEN '4' THEN 4  -- Thursday
    WHEN '5' THEN 5  -- Friday
    WHEN '6' THEN 6  -- Saturday
    WHEN '0' THEN 7  -- Sunday
END;

-- Membuat Day Type
ALTER TABLE retail_sales_clean
ADD COLUMN day_type TEXT;

UPDATE retail_sales_clean
SET day_type =
CASE
    WHEN strftime('%w', transaction_date) IN ('0','6')
    THEN 'Weekend'
    ELSE 'Weekday'
END;

-- Membuat Kategori Discount 
ALTER TABLE retail_sales_clean 
ADD COLUMN Category_Discount TEXT;

UPDATE retail_sales_clean 
SET Category_Discount =
CASE
	WHEN discount_pct <= 0 THEN 'No Discount'
	WHEN discount_pct <= 10 THEN 'Low Discount'
	WHEN discount_pct <= 20 THEN 'Medium Discount'
	ELSE 'High Discount'
END;

select Category_Discount, discount_pct
from retail_sales_clean rsc 
limit 20;