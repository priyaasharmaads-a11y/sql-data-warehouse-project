# 🏷️ Naming Conventions

This document summarizes the naming standards followed across all layers of the data warehouse.  
The goal is to keep everything consistent, readable, and aligned with best practices.

---

## 📌 Table of Contents
1. [General Principles](#general-principles)  
2. [Table Naming Conventions](#table-naming-conventions)  
   - [Bronze](#bronze-rules)  
   - [Silver](#silver-rules)  
   - [Gold](#gold-rules)  
3. [Column Naming Conventions](#column-naming-conventions)  
   - [Surrogate Keys](#surrogate-keys)  
   - [Technical Columns](#technical-columns)  
4. [Stored Procedures](#stored-procedure-naming-conventions)  

---

## 🧭 General Principles

- Use **snake_case** for all object names.
- Stick to **English** for naming.
- Avoid using **reserved SQL keywords** as names.
- Keep names descriptive enough to understand their purpose at a glance.

---

## 🗃️ Table Naming Conventions

### 🔹 Bronze Rules
These tables represent the raw landing zone.

- Names follow the exact format of the original source system.
- Structure:  
  **`<source>_<entity>`**
- `<source>` = upstream system (e.g., `crm`, `erp`)  
- `<entity>` = original dataset name  
- Example:  
  `crm_customer_info` → Customer info extracted exactly from CRM.

### 🔹 Silver Rules
Silver tables apply cleaning and standardization but keep the same naming logic as Bronze.

- Same pattern as Bronze:  
  **`<source>_<entity>`**
- Names stay aligned to their origin for easy traceability.
- Example:  
  `erp_loc_a101` → Cleaned version of the ERP location file.

### 🔹 Gold Rules
Gold tables represent business-friendly structures.

- Names are meaningful and aligned with analytics usage.
- Structure:  
  **`<category>_<entity>`**
- `<category>` describes the role:
  - `dim` → Dimension  
  - `fact` → Fact  
- Examples:
  - `dim_customers`  
  - `fact_sales`  

#### Glossary of Prefixes

| Prefix     | Definition                 | Example                         |
|------------|----------------------------|---------------------------------|
| `dim_`     | Dimension table            | `dim_products`                  |
| `fact_`    | Fact table                 | `fact_sales`                    |
| `report_`  | Report-level aggregated set | `report_sales_monthly`          |

---

## 📌 Column Naming Conventions

### 🔑 Surrogate Keys
Surrogate keys always end with `_key`.

- Pattern: **`<entity>_key`**
- Example:  
  `customer_key` in `dim_customers`

### ⚙ Technical Columns
Technical or metadata fields start with the prefix `dwh_`.

- Pattern: **`dwh_<attribute>`**
- Used for:
  - load timestamps  
  - batch identifiers  
  - audit-related values  
- Example:  
  `dwh_load_date` → Timestamp added during ETL.

---

## 📜 Stored Procedure Naming Conventions

Procedures that load each layer follow a straightforward pattern:

- **`load_<layer>`**
  - `<layer>` = bronze, silver, gold
- Examples:
  - `load_bronze`
  - `load_silver`

This keeps procedures easy to locate and relate directly to the part of the pipeline they maintain.

---


