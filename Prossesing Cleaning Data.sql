-- ========================================================
-- PROJECT	: RETAIL SALES ANALIS
-- TOOLS	: SQL (SQLITE)
-- AUTHOR	: BACHTIAR RAMADHAN
-- ========================================================


-- ========================================================
-- ============== PROSSESING DATA =========================

-- Membuat Data baru agar tidak mengubah Data lama
CREATE TABLE retail_sales_clean AS
SELECT *
FROM retail_sales_raw_csv;

-- Mengecek Row sebelum melakukan Prossesing
SELECT COUNT(*) Jumlah_Row
FROM retail_sales_raw_csv rsrc;
SELECT COUNT(*) Jumlah_Row
FROM retail_sales_clean rsc;

-- Mengecek Missing Value
SELECT *
FROM retail_sales_clean
WHERE transaction_id IS NULL
   OR transaction_date IS NULL
   OR customer_id IS NULL
   OR customer_gender IS NULL
   OR customer_age_group IS NULL
   OR customer_segment IS NULL
   OR product_id IS NULL
   OR product_name IS NULL
   OR category IS NULL
   OR brand IS NULL
   OR quantity IS NULL
   OR unit_price IS NULL
   OR discount_pct IS NULL
   OR sales_amount IS NULL
   OR payment_method IS NULL
   OR sales_channel IS NULL
   OR region IS NULL;

-- Mengecek Duplicated
SELECT 
	transaction_id,
	COUNT(*) Data_duplicated
FROM retail_sales_clean rsc 
GROUP BY rsc.transaction_id 
HAVING COUNT (*) > 1;

-- Mengecek Transaction_date, apakah sudah sesuai atau belum
SELECT DISTINCT 
	SUBSTR(transaction_date, 1, 4) AS Tahun
FROM retail_sales_clean rsc
ORDER BY Tahun;

SELECT DISTINCT
	SUBSTR(transaction_date, 6, 2) AS Bulan
FROM retail_sales_clean rsc 
ORDER BY Bulan;

SELECT DISTINCT 
	SUBSTR(transaction_date, 9, 2) AS Tanggal
FROM retail_sales_clean rsc 
ORDER BY Tanggal;

-- Menghapus Spasi yang berlebihan
UPDATE retail_sales_clean
SET
    transaction_id = TRIM(transaction_id),
    transaction_date = TRIM(transaction_date),
    customer_id = TRIM(customer_id),
    customer_gender = TRIM(customer_gender),
    customer_age_group = TRIM(customer_age_group),
    customer_segment = TRIM(customer_segment),
    product_id = TRIM(product_id),
    product_name = TRIM(product_name),
    category = TRIM(category),
    brand = TRIM(brand),
    payment_method = TRIM(payment_method),
    sales_channel = TRIM(sales_channel),
    region = TRIM(region);
select transaction_date
from retail_sales_clean rsc 

-- Validasi Data
SELECT COUNT(*)
FROM retail_sales_clean;

SELECT DISTINCT category
FROM retail_sales_clean;

SELECT DISTINCT region
FROM retail_sales_clean;

SELECT DISTINCT sales_channel
FROM retail_sales_clean;

SELECT DISTINCT payment_method
FROM retail_sales_clean;

-- Data Quality Check
SELECT *
FROM retail_sales_clean
WHERE quantity <= 0;

SELECT *
FROM retail_sales_clean
WHERE unit_price <= 0;

SELECT *
FROM retail_sales_clean
WHERE sales_amount <= 0;

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

SELECT
    transaction_date,
    year,
    month_num,
    month_name,
    quarter,
    day_name,
    day_type
FROM retail_sales_clean
LIMIT 20;