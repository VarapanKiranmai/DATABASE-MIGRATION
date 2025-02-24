-- MySQL to PostgreSQL Migration Script

-- Step 1: Export MySQL Data to CSV
-- Run this in MySQL to export data
SELECT * INTO OUTFILE '/tmp/employees.csv' 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
FROM employees;

-- Step 2: Create Table in PostgreSQL
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    position VARCHAR(255),
    department VARCHAR(255),
    salary DECIMAL(10,2)
);

-- Step 3: Import CSV Data into PostgreSQL
COPY employees(name, position, department, salary)
FROM '/tmp/employees.csv' 
DELIMITER ',' 
CSV HEADER;

-- Step 4: Verify Data Integrity
SELECT COUNT(*) FROM employees;

