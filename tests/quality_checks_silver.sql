/*
====================================================================================
Silver Layer – Data Quality Checks
====================================================================================
Overview:
    After loading the Silver layer, I run this set of validation queries to make 
    sure the data is clean, consistent, and properly standardized. These checks 
    help catch issues such as:
        • duplicate or missing key values
        • inconsistent text formatting
        • incorrect or impossible dates
        • mismatched values across related fields

Note:
    These checks don’t modify anything — they only highlight records that 
    might need attention. Ideally, most of these queries should return zero rows.
====================================================================================
*/

------------------------------------------------------------
-- Checks for: silver.crm_cust_info
------------------------------------------------------------

-- Duplicate or NULL customer IDs (should return none)
SELECT 
    cst_id,
    COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Keys with unwanted leading/trailing spaces
SELECT 
    cst_key 
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Review unique marital status values after standardization
SELECT DISTINCT 
    cst_marital_status 
FROM silver.crm_cust_info;


------------------------------------------------------------
-- Checks for: silver.crm_prd_info
------------------------------------------------------------

-- Duplicate or NULL product IDs
SELECT 
    prd_id,
    COUNT(*) 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Product names with extra spaces
SELECT 
    prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Invalid or missing cost values
SELECT 
    prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Review unique product line mappings
SELECT DISTINCT 
    prd_line 
FROM silver.crm_prd_info;

-- Start date after end date (should not happen)
SELECT 
    * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;


------------------------------------------------------------
-- Checks for: silver.crm_sales_details
------------------------------------------------------------

-- Raw validation for incorrect or non-date order values
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

-- Order date should not be after shipping/due dates
SELECT 
    * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Sales amount must equal quantity × price
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;


------------------------------------------------------------
-- Checks for: silver.erp_cust_az12
------------------------------------------------------------

-- Birthdates outside a realistic range
SELECT DISTINCT 
    bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

-- Review standardized gender values
SELECT DISTINCT 
    gen 
FROM silver.erp_cust_az12;


------------------------------------------------------------
-- Checks for: silver.erp_loc_a101
------------------------------------------------------------

-- Review country name standardization
SELECT DISTINCT 
    cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;


------------------------------------------------------------
-- Checks for: silver.erp_px_cat_g1v2
------------------------------------------------------------

-- Extra spaces in category fields
SELECT 
    * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Maintenance value consistency check
SELECT DISTINCT 
    maintenance 
FROM silver.erp_px_cat_g1v2;

