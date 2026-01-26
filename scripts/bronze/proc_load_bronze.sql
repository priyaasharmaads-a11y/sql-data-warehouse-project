/* 
===============================================================
               STORED PROCEDURE: Load Bronze Layer
===============================================================
Purpose:
    Loads raw data from external CSV files into the Bronze 
    schema tables. This procedure is responsible for 
    refreshing the Bronze layer as part of the daily or 
    scheduled ingestion cycle.

Actions Performed:
    - Truncates Bronze tables prior to loading
    - Uses BULK INSERT to load source CSV files into Bronze tables
    - Logs progress using PRINT statements
    - Captures start and end timestamps
    - Computes load duration using DATEDIFF for:
          • each individual table
          • total Bronze batch load

Parameters:
    None.
    This stored procedure does not accept input parameters 
    and does not return any values.

Usage:
    EXEC bronze.load_bronze;

Notes:
    Data is ingested exactly as received (no transformations).
    All data quality checks and cleaning will be handled 
    in the Silver layer.
===============================================================
*/



EXEC  bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME , @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
            SET @batch_start_time = GETDATE();
            PRINT '=========================================';
            PRINT 'Loading bronze layer';
            PRINT '=========================================';

            PRINT '-----------------------------------------';
            PRINT 'Loading CRM tables';
            PRINT '-----------------------------------------';
            
            SET @start_time = GETDATE();
            PRINT '>> Truncating table - bronze.crm_cust_info<<';
            TRUNCATE TABLE bronze.crm_cust_info;
            PRINT '>> Inserting data into - bronze.crm_cust_info<<';
            BULK INSERT bronze.crm_cust_info
            FROM 'C:\DwH PROJ\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
            WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
            );
            SET @end_time = GETDATE();
            PRINT '>>load duration: ' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'Seconds';
            PRINT '-------------------------------------------------------------------------------------------';

            SET @start_time = GETDATE();
            PRINT '>> Truncating table - bronze.crm_prd_info<<';
            TRUNCATE TABLE bronze.crm_prd_info;
            PRINT '>> Inserting data into - bronze.crm_prd_info<<';
            BULK INSERT bronze.crm_prd_info
            FROM 'C:\DwH PROJ\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
            WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
            );
            SET @end_time = GETDATE();
            PRINT '>>load duration: ' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'Seconds';
            PRINT '-------------------------------------------------------------------------------------------';



            SET @start_time = GETDATE();
            PRINT '>> Truncating table - bronze.crm_sales_details<<';
            TRUNCATE TABLE bronze.crm_sales_details;
            PRINT '>> Inserting data into - bronze.crm_sales_details<<';
            BULK INSERT bronze.crm_sales_details
            FROM 'C:\DwH PROJ\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
            WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
            );
            SET @end_time = GETDATE();
            PRINT '>>load duration: ' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'Seconds';
            PRINT '-------------------------------------------------------------------------------------------';

            
            
            PRINT '-----------------------------------------';
            PRINT 'Loading ERP tables';
            PRINT '-----------------------------------------';
            
            SET @start_time = GETDATE();
            PRINT '>> Truncating table - bronze.erp_CUST_AZ12<<';
            TRUNCATE TABLE bronze.erp_CUST_AZ12;
            PRINT '>> Inserting data into - bronze.erp_CUST_AZ12<<';
            BULK INSERT bronze.erp_CUST_AZ12
            FROM 'C:\DwH PROJ\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
            WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
            );
            SET @end_time = GETDATE();
            PRINT '>>load duration: ' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'Seconds';
            PRINT '-------------------------------------------------------------------------------------------';


            
            SET @start_time = GETDATE();
            PRINT '>> Truncating table - bronze.erp_LOC_A101 <<';
            TRUNCATE TABLE bronze.erp_LOC_A101;
            PRINT '>> Inserting data into - bronze.erp_LOC_A101<<';
            BULK INSERT bronze.erp_LOC_A101
            FROM 'C:\DwH PROJ\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
            WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
            );
            SET @end_time = GETDATE();
            PRINT '>>load duration: ' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'Seconds';
            PRINT '-------------------------------------------------------------------------------------------';



            
            SET @start_time = GETDATE();
            PRINT '>> Truncating table - bronze.erp_PX_CAT_G1V2<<';
            TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
            PRINT '>> Inserting data into - bronze.erp_PX_CAT_G1V2 <<';
            BULK INSERT bronze.erp_PX_CAT_G1V2
            FROM 'C:\DwH PROJ\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
            WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
            );
            SET @end_time = GETDATE();
            PRINT '>>load duration: ' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'Seconds';
            PRINT '-------------------------------------------------------------------------------------------';
            SET @batch_end_time = GETDATE();
            PRINT'=================================================='
            PRINT'Loading brone layer is completed';
            PRINT '>> Total load duration: ' + CAST(DATEDIFF(second,@batch_start_time, @batch_end_time) AS NVARCHAR) + 'Seconds';
            PRINT'=================================================='

        END TRY
        
        BEGIN CATCH
        PRINT '======================================================================='
        PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
        PRINT'Error Message' + ERROR_MESSAGE();
        PRINT'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '======================================================================='
        END CATCH

END
