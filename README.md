# 📦 Data Warehouse & Analytics Project

Welcome to my **SQL-based Data Warehouse & Analytics Project**!  
This repository documents my journey of building a complete data warehouse using SQL Server — from raw source files all the way to analytical models in the Gold layer.

This project helped me understand practical data engineering concepts such as ETL, Medallion Architecture, data modeling, normalization, quality checks, and SQL-driven analytics.

---

## 🧱 Data Architecture (Medallion)

This project follows the widely used **Medallion Architecture**:

### 🔹 **Bronze Layer**
Raw data exactly as received from CRM & ERP CSV files.  
Serves as the landing zone without transformations.

### 🔹 **Silver Layer**
Cleaned, standardized, and enriched data prepared for analysis.  
Includes:
- data quality fixes  
- consistent data types  
- removing duplicates  
- normalization  
- metadata columns  

### 🔹 **Gold Layer**
Business-ready data modeled in a **star schema**.  
Contains:
- Dimension views (Customers, Products)  
- Fact view (Sales)  
- Final analytical model  

---

## 📘 Project Overview

This end-to-end project includes:

### ✔ Data Architecture  
Designing and documenting a modern warehouse using Medallion layers.

### ✔ ETL Pipelines (SQL Only)  
Extracting, transforming, and loading CRM & ERP datasets into SQL Server.

### ✔ Data Modeling  
Creating dimension + fact views optimized for reporting and downstream analytics.

### ✔ Analytics  
Using SQL queries to analyze:
- customer behavior  
- product performance  
- sales patterns  

---

## 🎯 Skills Demonstrated

This project highlights hands-on experience in:

- SQL Development  
- Data Cleaning & Standardization  
- ETL Logic  
- Schema Design (Star Schema)  
- Data Modeling  
- Data Architecture Fundamentals  
- Quality Checks  
- Version Control & Documentation  

---

## 🛠 Tools & Technologies Used

- **SQL Server Express** – Warehouse engine  
- **SSMS** – Main development environment  
- **DrawIO** – Architecture diagrams, data models & flows  
- **Notion** – Project planning & task tracking  
- **GitHub** – Version control & documentation  
- **CSV datasets** – CRM & ERP raw data  

Everything is built in **SQL only** — no ETL tools or external processing.

---

## 🚀 Project Requirements

### 🔷 Data Engineering

**Goal:**  
Build a consolidated SQL data warehouse that merges CRM & ERP datasets for analytics.

**Key Activities:**
- Importing data from CSV files  
- Creating Bronze → Silver → Gold layers  
- Applying business rules  
- Documenting transformations and data models  

### 🔷 Data Analytics

Analytical queries performed on the Gold layer to extract insights around:
- Customer segments  
- Sales trends  
- Product performance  

---

## 📂 Repository Structure

data-warehouse-project/
│
├── datasets/                     # CRM & ERP raw CSV files
│
├── docs/                         # Architecture, diagrams, catalogs, documentation
│   ├── data_architecture.drawio
│   ├── data_flow.drawio
│   ├── data_models.drawio
│   ├── etl.drawio
│   ├── data_catalog.md
│   ├── naming-conventions.md
│
├── scripts/
│   ├── bronze/                   # Raw data loading scripts
│   ├── silver/                   # Cleaning & transformation logic
│   ├── gold/                     # Business-ready dimension & fact views
│
├── tests/                        # Quality checks for Silver & Gold layers
│
├── README.md                     # Project overview
├── LICENSE
└── .gitignore


---

## 📜 License

This project is licensed under the **MIT License**.  
You may modify, use, or share it with attribution.

---

## 🔗 Connect With Me

If you'd like to follow my work or connect professionally, feel free to reach out:

**LinkedIn**  
[![LinkedIn](www.linkedin.com/in/priya-sharma-96a577253)




## About Me

Hi! I’m **Priya Santosh Sharma**, currently working towards becoming a strong Data Analyst / Data Scientist.
I enjoy breaking down concepts, building real-world projects, and improving my skills step by step.
This project is part of my learning roadmap where I combine SQL, data engineering fundamentals, and analytics to understand how real businesses work with data.



