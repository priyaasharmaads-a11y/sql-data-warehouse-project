/* 
=====================================================
    Initialize Data Warehouse Database & Schemas
    File: init_database.sql

    Purpose:
    - Drops existing DataWarehouse database (if exists)
    - Creates a fresh DataWarehouse database
    - Creates bronze, silver, and gold schemas
=====================================================
*/

-- Always start in master for DB-level operations
USE master;
GO

-- Drop database if it already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

-- Switch to the new database
USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
