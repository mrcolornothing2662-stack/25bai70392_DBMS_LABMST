-- Create an Online Shopping Management System using Customer and Orders tables.
-- 1. Create both tables with suitable attributes and apply Primary Key and Foreign Key constraints.
-- 2. Apply suitable NOT NULL, UNIQUE, DEFAULT, and CHECK constraints.
-- 3. Insert at least 5 customer records and 5 order records.
-- 4. Display orders whose total amount is greater than ₹5,000.
-- 5. Calculate the total order amount for each customer using GROUP BY and SUM().
-- 6. Display customers whose total order amount exceeds ₹10,000 using HAVING.
-- 7. Find the average order amount using AVG().
-- 8. Update the status of a particular order.
-- 9. Delete an order based on a suitable condition.
-- 10. Add a new column to the Orders table using ALTER.
-- 11. Display the final order records.

CREATE DATABASE IF NOT EXISTS CUSTOMER;
USE CUSTOMER;

-- 1 & 2. Create tables with PK, FK, NOT NULL, UNIQUE, DEFAULT, and CHECK constraints
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),

    CONSTRAINT order_amount_constraint
        CHECK (total_amount > 0),

    CONSTRAINT chk_order_status
        CHECK (status IN (
            'Pending',
            'Shipped',
            'Delivered',
            'Cancelled'
        ))
);

-- 3. Insert at least 5 customer records
INSERT INTO Customer (customer_id, customer_name, email, phone)
VALUES 
    (1, 'Rahul Sharma', 'rahul@gmail.com', '9876543210'),
    (2, 'Rohit Sharma', 'rohit@gmail.com', '9821232211'),
    (3, 'Hardik Pandya', 'hardik@gmail.com', '9122345778'),
    (4, 'Sachin Tendulkar', 'sachin@gmail.com', '9878151515'),
    (5, 'Virat Kohli', 'virat@gmail.com', '9898989898');

SELECT * FROM Customer;

-- 3. Insert at least 5 order records
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status)
VALUES
    (101, 1, '2026-03-01', 7000.00, 'Pending'),
    (102, 2, '2026-03-02', 8000.00, 'Pending'),
    (103, 3, '2026-03-03', 1234.00, 'Pending'),
    (104, 4, '2026-03-04', 12000.00, 'Delivered'),
    (105, 5, '2026-03-05', 5500.00, 'Pending');

-- 4. Display orders whose total amount is greater than ₹5,000
SELECT * FROM Orders
WHERE total_amount > 5000;

-- 5. Calculate total order amount for each customer using GROUP BY and SUM()
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_order_amount
FROM Customer c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;

-- 6. Display customers whose total order amount exceeds ₹10,000 using HAVING
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_order_amount
FROM Customer c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(o.total_amount) > 10000;

-- 7. Find average order amount using AVG()
SELECT AVG(total_amount) AS average_order_amount
FROM Orders;

-- 8. Update status of a particular order
UPDATE Orders
SET status = 'Delivered'
WHERE order_id = 101;

SELECT * FROM Orders;

-- 9. Delete an order based on a suitable condition
DELETE FROM Orders
WHERE order_id = 102;

-- 10. Add a new column to Orders table using ALTER
ALTER TABLE Orders
ADD order_name VARCHAR(100);

-- 11. Display final order records
SELECT * FROM Orders;
