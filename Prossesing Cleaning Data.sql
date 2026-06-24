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

