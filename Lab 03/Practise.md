``` sql

-- COMPLETE E-COMMERCE DATABASE
-- Create the main database
CREATE DATABASE ecommerce_store;

-- Create categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_date DATE DEFAULT GETDATE()
);

-- Create customers table with various constraints
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    date_joined DATE DEFAULT GETDATE(),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) CHECK (price > 0),
    stock_quantity INT DEFAULT 0,
    sku VARCHAR(50) UNIQUE,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'PENDING',
    total_amount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT chk_status CHECK (status IN ('PENDING', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED'))
);

-- Insert sample data
INSERT INTO categories VALUES 
(1, 'Electronics', 'Electronic devices and gadgets'),
(2, 'Books', 'Physical and digital books'),
(3, 'Clothing', 'Apparel and accessories');

INSERT INTO customers (customer_id, first_name, last_name, email, phone) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '555-1234'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '555-5678'),
(3, 'Bob', 'Johnson', 'bob.johnson@email.com', '555-9012');

INSERT INTO products VALUES
(101, 'Gaming Laptop', 1, 1299.99, 15, 'LAP-GAME-001', TRUE),
(102, 'SQL Programming Guide', 2, 45.99, 50, 'BOOK-SQL-001', TRUE),
(103, 'Cotton T-Shirt', 3, 19.99, 100, 'SHIRT-COT-001', TRUE);

INSERT INTO orders (order_id, customer_id, total_amount, status) VALUES
(1001, 1, 1299.99, 'PROCESSING'),
(1002, 2, 45.99, 'SHIPPED'),
(1003, 3, 39.98, 'DELIVERED');

-- Update examples
UPDATE products SET price = price * 0.9 WHERE category_id = 1; -- 10% discount on electronics
UPDATE customers SET is_active = FALSE WHERE customer_id = 3;   -- Deactivate customer

-- Delete examples
DELETE FROM orders WHERE status = 'CANCELLED';                 -- Remove cancelled orders


-- #########################################################################################################################################################
-- Creating a customers table with NOT NULL constraints
CREATE TABLE customers (
    customer_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);

-- Adding NOT NULL to existing column
ALTER TABLE customers MODIFY email VARCHAR(100) NOT NULL;

-- UNIQUE
-- Method 1: Column-level UNIQUE
CREATE TABLE users (
    user_id INT NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    age INT
);

-- Method 2: Table-level UNIQUE with named constraint
CREATE TABLE products (
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    sku VARCHAR(50),
    price DECIMAL(10,2),
    CONSTRAINT unique_sku UNIQUE (sku)
);

-- Method 3: Multiple columns UNIQUE
CREATE TABLE employees (
    emp_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    department VARCHAR(50),
    CONSTRAINT unique_emp_dept UNIQUE (first_name, last_name, department)
);

-- Adding UNIQUE to existing table
ALTER TABLE users ADD UNIQUE (username);
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);

-- Dropping UNIQUE constraint
ALTER TABLE users DROP CONSTRAINT unique_email;


-- PRIMARY
-- Method 1: Single column PRIMARY KEY
CREATE TABLE categories (
    category_id INT NOT NULL PRIMARY KEY,
    category_name VARCHAR(100),
    description TEXT
);

-- Method 2: Composite PRIMARY KEY
CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT,
    unit_price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id)
);

-- Adding PRIMARY KEY to existing table
ALTER TABLE categories ADD PRIMARY KEY (category_id);
ALTER TABLE order_items ADD CONSTRAINT pk_order_items PRIMARY KEY(order_id, product_id);

-- Dropping PRIMARY KEY
ALTER TABLE categories DROP CONSTRAINT PRIMARY;


-- FOREIGN KEY
-- Creating parent table first
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- Creating child table with FOREIGN KEY
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Adding FOREIGN KEY to existing table
ALTER TABLE employees ADD FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Named FOREIGN KEY constraint
ALTER TABLE employees ADD CONSTRAINT fk_emp_dept 
FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Dropping FOREIGN KEY
ALTER TABLE employees DROP CONSTRAINT fk_emp_dept;


-- CHECK CONSTRAINT
-- Single condition CHECK
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    grade CHAR(1),
    gpa DECIMAL(3,2)
);

-- Multiple conditions CHECK with named constraint
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    stock_quantity INT,
    CONSTRAINT chk_product_valid CHECK (price > 0 AND stock_quantity >= 0)
);

-- Adding CHECK to existing table
ALTER TABLE students ADD CHECK (gpa BETWEEN 0.0 AND 4.0);
ALTER TABLE students ADD CONSTRAINT chk_grade CHECK (grade IN ('A', 'B', 'C', 'D', 'F'));

-- Dropping CHECK constraint
ALTER TABLE students DROP CONSTRAINT chk_grade;


-- DEFAULT CONSTRAINT
-- DEFAULT values in table creation
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'PENDING',
    total_amount DECIMAL(10,2) DEFAULT 0.00
);

-- Adding DEFAULT to existing column
ALTER TABLE orders MODIFY status VARCHAR(20) DEFAULT 'PROCESSING';

-- Removing DEFAULT (setting to NULL)
ALTER TABLE orders MODIFY status VARCHAR(20) DEFAULT NULL;


-- CREATE INDEX
-- Simple index
CREATE INDEX idx_customer_email ON customers(email);

-- Unique index
CREATE UNIQUE INDEX idx_product_sku ON products(sku);

-- Composite index
CREATE INDEX idx_order_customer_date ON orders(customer_id, order_date);

-- Dropping index
DROP INDEX idx_customer_email;

-- #########################################################################################################################################################
-- INSERT STATEMENTS
-- Method 1: Insert with all values (in order)
INSERT INTO customers VALUES 
(1, 'John', 'Doe', 'john.doe@email.com', '555-1234');

INSERT INTO customers VALUES 
(2, 'Jane', 'Smith', 'jane.smith@email.com', '555-5678'),
(3, 'Bob', 'Johnson', 'bob.johnson@email.com', '555-9012');

-- Method 2: Insert with specified columns
INSERT INTO customers (customer_id, first_name, last_name, email) 
VALUES (4, 'Alice', 'Wilson', 'alice.wilson@email.com');

INSERT INTO products (product_id, product_name, sku, price) VALUES
(101, 'Laptop Computer', 'LAP-001', 999.99),
(102, 'Wireless Mouse', 'MOU-001', 29.99),
(103, 'USB Keyboard', 'KEY-001', 49.99);

-- Insert from another table
INSERT INTO archived_orders (order_id, customer_id, order_date, total_amount)
SELECT order_id, customer_id, order_date, total_amount 
FROM orders 
WHERE order_date < '2023-01-01';


-- UPDATE STATEMENTS
-- Update single column
UPDATE customers 
SET email = 'john.doe.new@email.com' 
WHERE customer_id = 1;

-- Update multiple columns
UPDATE products 
SET price = 899.99, stock_quantity = 50 
WHERE product_id = 101;

-- Update with calculations
UPDATE employees 
SET salary = salary * 1.10 
WHERE department = 'Sales';

-- Update with subquery
UPDATE products 
SET price = price * 0.90 
WHERE category_id IN (
    SELECT category_id 
    FROM categories 
    WHERE category_name = 'Electronics'
);

-- Update all rows (remove WHERE clause)
UPDATE orders 
SET status = 'REVIEWED' 
WHERE status = 'PENDING';


-- DELETE STATEMENTS
-- Delete specific record
DELETE FROM customers 
WHERE customer_id = 4;

-- Delete with multiple conditions
DELETE FROM orders 
WHERE status = 'CANCELLED' AND order_date < '2023-01-01';

-- Delete with subquery
DELETE FROM order_items 
WHERE order_id IN (
    SELECT order_id 
    FROM orders 
    WHERE status = 'CANCELLED'
);

-- Delete all records (keep table structure)
DELETE FROM temp_data;


-- CREATE DATABASE
-- Create new database
CREATE DATABASE ecommerce_db;
CREATE DATABASE inventory_system;
CREATE DATABASE hr_management;


-- CREATE TABLE
-- Basic table creation
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(200)
);

-- Table with various data types and constraints
CREATE TABLE inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    supplier_id INT,
    category_id INT,
    unit_price DECIMAL(10,2) CHECK (unit_price > 0),
    stock_quantity INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


-- ADD COLUMNS
-- Add single column
ALTER TABLE customers ADD date_joined DATE;

-- Add multiple columns
ALTER TABLE products ADD (
    weight DECIMAL(8,2),
    dimensions VARCHAR(50),
    color VARCHAR(20)
);

-- Add column with constraints
ALTER TABLE employees ADD 
    hire_date DATE NOT NULL DEFAULT GETDATE();


-- DROP COLUMNS
-- Drop single column
ALTER TABLE customers DROP COLUMN phone;

-- Drop multiple columns (MySQL/PostgreSQL)
ALTER TABLE products DROP COLUMN weight, DROP COLUMN color;


-- MODIFY COLUMNS
-- Change data type
ALTER TABLE customers MODIFY first_name VARCHAR(100);

-- Change data type and add constraint
ALTER TABLE products MODIFY price DECIMAL(12,2) NOT NULL;

-- Add constraint to existing column
ALTER TABLE customers MODIFY email VARCHAR(100) UNIQUE;


-- DROP STATEMENTS
-- Drop table
DROP TABLE temp_customers;
DROP TABLE old_inventory;

-- Drop database
DROP DATABASE old_system;
DROP DATABASE test_db;

-- Drop with IF EXISTS (safer)
DROP TABLE IF EXISTS temp_data;
DROP DATABASE IF EXISTS old_archive;


-- TRUNCATE STATEMENTS
-- Remove all data, keep structure
TRUNCATE TABLE session_logs;
TRUNCATE TABLE temporary_imports;
TRUNCATE TABLE cache_data;


-- RENAME STATEMENTS
-- Rename table
ALTER TABLE customers RENAME TO client_list;
ALTER TABLE old_products RENAME TO archived_products;

-- Rename column
ALTER TABLE employees RENAME COLUMN emp_name TO employee_name;
ALTER TABLE products RENAME COLUMN desc TO description;



```
