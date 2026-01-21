-- Creating Schema 
CREATE SCHEMA RETAIL;

--**************************************************************
             -- Creating Dimentions TAbles
--**************************************************************

-- Customer Dimension
CREATE TABLE retail.dim_customers (
   customer_id INT PRIMARY KEY,
   customer_name VARCHAR(100),
   email VARCHAR(100),
   region VARCHAR(50),
   signup_date DATE
);


-- Product Dimension
CREATE TABLE retail.dim_products (
   product_id INT PRIMARY KEY,
   product_name VARCHAR(100),
   category VARCHAR(50),
   price DECIMAL(10,2)
);


-- Store Dimension
CREATE TABLE retail.dim_stores (
   store_id INT PRIMARY KEY,
   store_name VARCHAR(100),
   location VARCHAR(100),
   manager_name VARCHAR(100)
);


-- Time Dimension
CREATE TABLE retail.dim_time (
   date_id DATE PRIMARY KEY,
   year INT,
   quarter INT,
   month INT,
   day INT,
   day_of_week VARCHAR(20)
);


-- Employee Dimension
CREATE TABLE retail.dim_employees (
   employee_id INT PRIMARY KEY,
   employee_name TEXT,
   department TEXT,
   employment_type TEXT,
   hire_date DATE,
   store_id INT  
);


--**************************************************************
                 -- Creating Facts TAbles
--**************************************************************

-- Fact Sales
CREATE TABLE retail.fact_sales (
   sale_id INT PRIMARY KEY,
   customer_id INT REFERENCES retail.dim_customers(customer_id),
   product_id INT REFERENCES retail.dim_products(product_id),
   store_id INT REFERENCES retail.dim_stores(store_id),
   sale_date DATE REFERENCES retail.dim_time(date_id),
   quantity_sold INT,
   total_amount DECIMAL(10,2)
);


-- Fact Inventory
CREATE TABLE retail.fact_inventory (
   inventory_id INT PRIMARY KEY,
   product_id INT REFERENCES retail.dim_products(product_id),
   store_id INT REFERENCES retail.dim_stores(store_id),
   stock_date DATE REFERENCES retail.dim_time(date_id),
   stock_level INT
);


--**************************************************************
             -- Inserting Random Data To Tables
--**************************************************************


INSERT INTO retail.dim_customers
WITH 
  t10 AS (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9),
  numbers AS (
    SELECT (a.n * 10000 + b.n * 1000 + c.n * 100 + d.n * 10 + e.n + 1) AS id
    FROM t10 a, t10 b, t10 c, t10 d, t10 e
    LIMIT 100000
  )
SELECT
   id,
   'Customer_' || id AS customer_name,
   'customer' || id || '@example.com' AS email,
   CASE
       WHEN id % 4 = 0 THEN 'North'
       WHEN id % 4 = 1 THEN 'South'
       WHEN id % 4 = 2 THEN 'East'
       ELSE 'West'
   END AS region,
   DATEADD(day, CAST(-FLOOR(RANDOM() * 3650) AS INT), CURRENT_DATE) AS signup_date
FROM numbers;

-- ///////////////////////////////////////////////////////////////////////////////////


INSERT INTO retail.dim_stores
WITH 
  t10 AS (
      SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
      UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
  ),
  numbers AS (
      SELECT (a.n * 10 + b.n + 1) AS id
      FROM t10 a, t10 b
      WHERE (a.n * 10 + b.n + 1) <= 100
  )
SELECT
   id,
   'Store_' || id AS store_name,
   CASE
       WHEN id % 4 = 0 THEN 'New York'
       WHEN id % 4 = 1 THEN 'Los Angeles'
       WHEN id % 4 = 2 THEN 'Chicago'
       ELSE 'Houston'
   END AS city,
   'Address_' || id AS address
FROM numbers;

-- ///////////////////////////////////////////////////////////////////////////////////


INSERT INTO retail.fact_sales
WITH 
  t10 AS (
      SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
      UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
  ),
  t1M AS (
      SELECT (a.n * 100000 + b.n * 10000 + c.n * 1000 + d.n * 100 + e.n * 10 + f.n + 1) AS id
      FROM t10 a, t10 b, t10 c, t10 d, t10 e, t10 f
  )
SELECT
   id,
   FLOOR(RANDOM() * 100000) + 1 AS customer_id,
   FLOOR(RANDOM() * 500) + 1 AS product_id,
   FLOOR(RANDOM() * 100) + 1 AS store_id,
   DATEADD(day, CAST(-FLOOR(RANDOM() * 1825) AS INT), CURRENT_DATE) AS sale_date,
   FLOOR(RANDOM() * 100) + 1 AS quantity_sold,
   ROUND((FLOOR(RANDOM() * 100) + 1) * (FLOOR(RANDOM() * 100) + 5), 2) AS total_amount
FROM t1M;


-- ///////////////////////////////////////////////////////////////////////////////////


INSERT INTO retail.fact_inventory
WITH 
  t10 AS (
      SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
      UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
  ),
  t500k AS (
      SELECT (a.n * 100000 + b.n * 10000 + c.n * 1000 + d.n * 100 + e.n * 10 + f.n + 1) AS id
      FROM t10 a, t10 b, t10 c, t10 d, t10 e, t10 f
      WHERE (a.n * 100000 + b.n * 10000 + c.n * 1000 + d.n * 100 + e.n * 10 + f.n + 1) <= 500000
  )
SELECT
   id,
   FLOOR(RANDOM() * 500) + 1 AS product_id,
   FLOOR(RANDOM() * 100) + 1 AS store_id,
   DATEADD(day, CAST(-FLOOR(RANDOM() * 1825) AS INT), CURRENT_DATE) AS stock_date,
   FLOOR(RANDOM() * 100) + 1 AS stock_level
FROM t500k;


-- ///////////////////////////////////////////////////////////////////////////////////


-- First create a temporary table with the date series
CREATE TEMPORARY TABLE temp_date_series AS
WITH 
  t10 AS (
      SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
      UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
  ),
  t10000 AS (
      SELECT (a.n * 1000 + b.n * 100 + c.n * 10 + d.n) AS num
      FROM t10 a, t10 b, t10 c, t10 d
  ),
  series AS (
      SELECT num
      FROM t10000
      WHERE num < 5000
  )
SELECT CURRENT_DATE - (num * INTERVAL '1 day') AS date_id
FROM series;

-- Then perform the INSERT using the temporary table
INSERT INTO retail.dim_time (date_id, year, quarter, month, day, day_of_week)
SELECT
   date_id,
   EXTRACT(YEAR FROM date_id) AS year,
   EXTRACT(QUARTER FROM date_id) AS quarter,
   EXTRACT(MONTH FROM date_id) AS month,
   EXTRACT(DAY FROM date_id) AS day,
   TRIM(TO_CHAR(date_id, 'Day')) AS day_of_week
FROM temp_date_series;



-- ///////////////////////////////////////////////////////////////////////////////////


-- Insert data into the employee table
INSERT INTO retail.dim_employees (employee_id, employee_name, department, employment_type, hire_date, store_id)
WITH 
  t10 AS (
      SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
      UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
  ),
  t10k AS (
      SELECT (a.n * 1000 + b.n * 100 + c.n * 10 + d.n + 1) AS id
      FROM t10 a, t10 b, t10 c, t10 d
  )
SELECT
   CAST(id AS INTEGER) AS employee_id,
   'Employee_' || CAST(id AS VARCHAR) AS employee_name,
   CASE
       WHEN id % 3 = 0 THEN 'HR'
       WHEN id % 3 = 1 THEN 'Sales'
       ELSE 'Operations'
   END AS department,
   CASE
       WHEN id % 2 = 0 THEN 'Full-time'
       ELSE 'Part-time'
   END AS employment_type,
   DATEADD(day, CAST(-FLOOR(RANDOM() * 3650) AS INT), CURRENT_DATE) AS hire_date,
   CAST((id % 5) + 1 AS INT) AS store_id
FROM t10k;
