# Retail Data Analysis & Modeling using Amazon Redshift & dbt Cloud
This project demonstrates a full end-to-end Data Engineering workflow, from data generation and warehousing in **Amazon Redshift** to transformation and modeling using **dbt Cloud**. The goal is to transform raw retail data into actionable business insights like Customer Segmentation and Sales Trends.

#  Project Overview :
In this project, I moved away from using ready-made datasets. Instead, I manually architected the schema and populated the data using SQL scripts to deeply understand how Cloud Data Warehouses handle complex queries and storage.


# Key Features:

  - **Custom Data Generation:** Designed and populated Dimension and Fact tables (Customers, Products, Sales).  
  - **Cloud Data Warehousing:** Optimized environment setup in Amazon Redshift.  
  - **Modular Transformations:** Leveraged dbt Cloud for building a multi-layered data architecture.  
  - **CI/CD Integration:** Integrated dbt with GitHub for version control and code reliability.
  - **Data Quality:** Implementation of testing and lineage tracking.


# 🏗️ Architecture & Workflow :

 **1.Data Warehousing (Amazon Redshift)**
     Created the foundational infrastructure on AWS.
     - **SQL Scripts:** Defined the schema for the retail domain.
     - **Entity-Relationship:** Developed Fact tables for transactions and Dimension tables for entities like Customers and Products.

 **2.Data Transformation (dbt Cloud)**
    I followed the best practices for dbt modeling by splitting the logic into distinct layers:

    - **Staging Layer:** Focuses on cleaning, renaming, and casting types from raw data.
    - **Marts Layer (Business Logic): * Customer Segmentation:** Analyzing customer behavior.
    - **Monthly Sales Trends:** Calculating KPIs for business growth.

 **3.Version Control & Reliability**
    - Connected dbt Cloud to **GitHub** to maintain a clean commit history.
    - Used dbt's **Data Lineage** features to visualize the flow from raw source tables to final BI-ready models.

 # 📁 Repository Structure:

```
├── analyses/         # Analytical SQL queries
├── macros/           # Reusable dbt macros
├── models/
│   ├── staging/      # Cleaned & prepared raw data
│   └── marts/        # Business-facing models (Gold layer)
├── seeds/            # CSV files loaded into the warehouse
├── snapshots/        # Tracking slowly changing dimensions (SCD)
├── tests/            # Custom data quality tests
├── dbt_project.yml   # dbt configuration file
└── redshift.sql      # Initial DDL and DML scripts for Redshift

```

--- 
 
# Data Lineage:
![photo_6021356609705020303_w](https://github.com/user-attachments/assets/d1a1c166-bd60-4272-9071-a837d5538f5d)

---

# 💡 Key Learnings:
  **Cloud Cost Management:** Learning how to manage and optimize Redshift clusters efficiently.
  
  **Data Lineage:** Understanding the critical importance of tracking data flow for troubleshooting and transparency.
  
  **Modular SQL:** Writing code using dbt.


 # 🛠️ Tools Used:
   **Database:** Amazon Redshift
    
   **Transformation:** dbt Cloud
    
   **Version Control:** Git & GitHub
    
   **Language:** SQL 


   ## 🌟 About Me:


Hi there! I'm **AbdelRahman Alaa**,  **Data Engineer**. 

Let's stay in touch! Feel free to connect with me on LinkedIn:

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/abdelrahman1alaa )







 
