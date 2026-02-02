/*
====================================================================================
Gold Layer – Data Quality Checks
====================================================================================
Overview:
    These checks help verify that the Gold layer views are structured correctly and
    that the relationships between fact and dimension views are valid. This includes:
        • making sure surrogate keys are unique,
        • confirming that fact records correctly match dimension records,
        • validating overall model integrity before using the data for reporting.

Note:
    Ideally, all checks should return zero results. Any unexpected rows highlight
    mismatches that may need to be examined further.
====================================================================================
*/

------------------------------------------------------------
-- Validate gold.dim_customers
------------------------------------------------------------

-- Expectation: customer_key should be unique in the customer dimension
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


------------------------------------------------------------
-- Validate gold.dim_products
------------------------------------------------------------

-- Expectation: product_key should be unique for every product record
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


------------------------------------------------------------
-- Validate gold.fact_sales relationships
------------------------------------------------------------

-- Ensures each fact row correctly links to existing dimension records
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL 
   OR c.customer_key IS NULL;
