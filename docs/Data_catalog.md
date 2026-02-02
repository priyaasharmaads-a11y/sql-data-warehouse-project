#  Gold Layer – Data Catalog

## Overview
The Gold Layer contains business-ready data models created from the Silver Layer.  
These **dimension views** and **fact views** are designed for reporting, analysis, and dashboarding.  
They combine cleaned and standardized data into a star-schema style structure.

---

##  1. `gold.dim_customers`

**Purpose:**  
Enriched customer information combining CRM and ERP sources.

### Columns

| Column Name      | Data Type     | Description |
|------------------|---------------|-------------|
| **customer_key**     | INT           | Surrogate key generated for analytics. |
| **customer_id**      | INT           | CRM customer identifier. |
| **customer_number**  | NVARCHAR(50)  | Customer code from CRM. |
| **first_name**       | NVARCHAR(50)  | Customer's first name. |
| **last_name**        | NVARCHAR(50)  | Customer's last name. |
| **country**          | NVARCHAR(50)  | Country derived from ERP location. |
| **marital_status**   | NVARCHAR(50)  | Cleaned marital status. |
| **gender**           | NVARCHAR(50)  | Final gender value after merging CRM + ERP sources. |
| **birthdate**        | DATE          | Customer's date of birth. |
| **create_date**      | DATE          | Customer creation date from CRM. |

---

##  2. `gold.dim_products`

**Purpose:**  
Product-level information enriched with category details from ERP.

### Columns

| Column Name        | Data Type     | Description |
|--------------------|---------------|-------------|
| **product_key**        | INT           | Surrogate key generated for analytics. |
| **product_id**         | INT           | CRM product ID. |
| **product_number**     | NVARCHAR(50)  | Cleaned product identifier. |
| **product_name**       | NVARCHAR(50)  | Name of the product. |
| **category_id**        | NVARCHAR(50)  | Category identifier derived from product key. |
| **category**           | NVARCHAR(50)  | High-level product category from ERP. |
| **subcategory**        | NVARCHAR(50)  | Detailed category for the product. |
| **maintenance**        | NVARCHAR(50)  | Maintenance classification from ERP. |
| **cost**               | INT           | Base cost of the product. |
| **product_line**       | NVARCHAR(50)  | Normalized line name (Road, Mountain, etc.). |
| **start_date**         | DATE          | Start date used to identify active products. |

---

##  3. `gold.fact_sales`

**Purpose:**  
Transaction-level sales data linked to product and customer dimensions.

### Columns

| Column Name     | Data Type     | Description |
|-----------------|---------------|-------------|
| **order_number**   | NVARCHAR(50)  | Sales order identifier. |
| **product_key**    | INT           | Surrogate key referencing `gold.dim_products`. |
| **customer_key**   | INT           | Surrogate key referencing `gold.dim_customers`. |
| **order_date**     | DATE          | Date the order was placed. |
| **shipping_date**  | DATE          | Date the order shipped. |
| **due_date**       | DATE          | Payment due date. |
| **sales_amount**   | INT           | Total value of the sale. |
| **quantity**       | INT           | Units sold. |
| **price**          | INT           | Unit price after transformations. |


