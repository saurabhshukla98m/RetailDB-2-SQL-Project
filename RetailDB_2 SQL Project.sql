/*====================================================================
 
                  SQL PROJECT | RETAILDB_2
               CUSTOMER & ORDER DATA ANALYSIS

======================================================================

  PROJECT       : RetailDB_2 - SQL Medium Assignment
  CREATED BY    : Saurabh Shukla
  EMAIL         : saurabhshukla98m@gmail.com
  DOMAIN        : Retail & E-Commerce Analytics
  DATABASE      : RetailDB_2
  TOOL          : MySQL Workbench
  LANGUAGE      : Structured Query Language (SQL)

  PROJECT OBJECTIVE:
  To analyze customers, orders, products, suppliers and sales data
  using SQL joins, aggregate functions, subqueries and advanced filters.

  KEY CONCEPTS:
  INNER JOIN | LEFT JOIN | RIGHT JOIN | UNION
  GROUP BY | HAVING | Aggregate Functions | Subqueries
  IN | NOT IN | IS NULL | LIMIT | OFFSET

====================================================================*/

CREATE DATABASE IF NOT EXISTS RetailDB_2;
USE RetailDB_2;

-- 1. Customers 
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
); 
-- 2. Suppliers 
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact_email VARCHAR(100),
    city VARCHAR(50)
);
-- 3. Products 
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10 , 2 ),
    stock_qty INT,
    supplier_id INT,
    FOREIGN KEY (supplier_id)
        REFERENCES Suppliers (supplier_id)
);
 -- 4. Orders 
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10 , 2 ),
    payment_mode VARCHAR(50),
    FOREIGN KEY (customer_id)
        REFERENCES Customers (customer_id)
);
 -- 5. Order_Items 
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_each DECIMAL(10 , 2 ),
    FOREIGN KEY (order_id)
        REFERENCES Orders (order_id),
    FOREIGN KEY (product_id)
        REFERENCES Products (product_id)
);


-- Step 4: View all tables using SELECT commands 
-- 1. View Customers 
SELECT * FROM Customers; 
-- 2. View Orders 
SELECT * FROM Orders; 
-- 3. View Products 
SELECT * FROM Products; 
-- 4. View Order_Items 
SELECT * FROM Order_Items; 
-- 5. View Suppliers 
SELECT * FROM Suppliers;




-- =====================================================
-- a) NORMAL QUERIES
-- =====================================================

-- 1. All products with their supplier name (INNER JOIN)
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.stock_qty,
    s.supplier_name
FROM
    Products p
        INNER JOIN
    Suppliers s ON p.supplier_id = s.supplier_id;

-- 2. All customers and their orders, even if none (LEFT JOIN)
SELECT 
    c.customer_id,
    c.name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.payment_mode
FROM
    Customers c
        LEFT JOIN
    Orders o ON c.customer_id = o.customer_id;

-- 3. All suppliers and their products, even if none (RIGHT JOIN)
SELECT 
    s.supplier_id, s.supplier_name, p.product_id, p.product_name
FROM
    Products p
        RIGHT JOIN
    Suppliers s ON p.supplier_id = s.supplier_id;

-- 4. FULL OUTER JOIN simulation (LEFT JOIN UNION RIGHT JOIN)
SELECT 
    c.customer_id,
    c.name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM
    Customers c
        LEFT JOIN
    Orders o ON c.customer_id = o.customer_id 
UNION SELECT 
    c.customer_id,
    c.name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM
    Customers c
        RIGHT JOIN
    Orders o ON c.customer_id = o.customer_id;

-- 5. Products priced between 5000 and 50000 supplied from Mumbai
SELECT 
    p.product_id,
    p.product_name,
    p.price,
    s.supplier_name,
    s.city
FROM
    Products p
        INNER JOIN
    Suppliers s ON p.supplier_id = s.supplier_id
WHERE
    p.price BETWEEN 5000 AND 50000
        AND s.city = 'Mumbai';

-- =====================================================
-- b) AGGREGATIONS & GROUP BY
-- =====================================================

-- 6. Customers with more than 2 orders
SELECT 
    c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM
    Customers c
        INNER JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.name
HAVING COUNT(o.order_id) > 2;

-- 7. Each supplier's total sales value (quantity * price_each)
SELECT 
    s.supplier_id,
    s.supplier_name,
    SUM(oi.quantity * oi.price_each) AS total_sales_value
FROM
    Suppliers s
        INNER JOIN
    Products p ON s.supplier_id = p.supplier_id
        INNER JOIN
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY s.supplier_id , s.supplier_name
ORDER BY total_sales_value DESC;

-- 8. Average, highest and lowest price per category
SELECT 
    category,
    ROUND(AVG(price), 2) AS avg_price,
    MAX(price) AS highest_price,
    MIN(price) AS lowest_price
FROM
    Products
GROUP BY category;

-- 9. Top 5 customers by total spending
SELECT 
    c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM
    Customers c
        INNER JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.name
ORDER BY total_spent DESC
LIMIT 5;

-- 10. Number of unique products ordered by each customer
SELECT 
    c.customer_id,
    c.name,
    COUNT(DISTINCT oi.product_id) AS unique_products_ordered
FROM
    Customers c
        INNER JOIN
    Orders o ON c.customer_id = o.customer_id
        INNER JOIN
    Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id , c.name;

-- =====================================================
-- c) SUBQUERIES
-- =====================================================

-- 11. Customers with an order amount greater than the average order amount
SELECT DISTINCT
    c.customer_id, c.name, o.order_id, o.total_amount
FROM
    Customers c
        INNER JOIN
    Orders o ON c.customer_id = o.customer_id
WHERE
    o.total_amount > (SELECT 
            AVG(total_amount)
        FROM
            Orders);

-- 12. Products that have never been ordered
SELECT 
    product_id, product_name, category, price
FROM
    Products
WHERE
    product_id NOT IN (SELECT 
            product_id
        FROM
            Order_Items
        WHERE
            product_id IS NOT NULL);

-- 13. Customers who ordered at least one Electronics product
SELECT 
    customer_id, name
FROM
    Customers
WHERE
    customer_id IN (SELECT 
            o.customer_id
        FROM
            Orders o
                INNER JOIN
            Order_Items oi ON o.order_id = oi.order_id
                INNER JOIN
            Products p ON oi.product_id = p.product_id
        WHERE
            p.category = 'Electronics');

-- 14. Suppliers whose products were ordered more than 100 times in total
--     (a product's total ordered quantity > 100)
SELECT 
    supplier_id, supplier_name
FROM
    Suppliers
WHERE
    supplier_id IN (SELECT 
            p.supplier_id
        FROM
            Products p
                INNER JOIN
            Order_Items oi ON p.product_id = oi.product_id
        GROUP BY p.product_id , p.supplier_id
        HAVING SUM(oi.quantity) > 100);

-- 15. Most expensive product(s)
SELECT 
    product_id, product_name, category, price
FROM
    Products
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            Products);

-- =====================================================
-- d) ADVANCED FILTERS
-- =====================================================

-- 16. Orders by customers living in Mumbai, Delhi or Bengaluru
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    o.payment_mode,
    c.name,
    c.city
FROM
    Orders o
        INNER JOIN
    Customers c ON o.customer_id = c.customer_id
WHERE
    c.city IN ('Mumbai' , 'Delhi', 'Bengaluru');

-- 17. Orders where payment mode is NOT UPI or Credit Card
SELECT 
    *
FROM
    Orders
WHERE
    payment_mode NOT IN ('UPI' , 'Credit Card');

-- 18. Customers with no email recorded
SELECT 
    customer_id, name, city
FROM
    Customers
WHERE
    email IS NULL OR TRIM(email) = '';

-- 19. Suppliers not in the same city as any customer
SELECT 
    supplier_id, supplier_name, city
FROM
    Suppliers
WHERE
    city NOT IN (SELECT 
            city
        FROM
            Customers
        WHERE
            city IS NOT NULL);

-- 20. Latest 3 orders, skipping the first 2
SELECT 
    *
FROM
    Orders
ORDER BY order_date DESC , order_id DESC
LIMIT 3 OFFSET 2;

/*
CONCLUSION:

This project demonstrates the practical application of SQL
for retail data analysis using five relational tables:
Customers, Orders, Products, Order_Items, and Suppliers.

KEY CONCEPTS COVERED:
1. INNER JOIN, LEFT JOIN, and RIGHT JOIN.
2. UNION for FULL OUTER JOIN simulation.
3. Aggregate functions: COUNT(), SUM(), AVG(), MAX(), MIN().
4. GROUP BY and HAVING for grouped analysis.
5. Subqueries for advanced data retrieval.
6. Filtering using IN, NOT IN, BETWEEN, and IS NULL.
7. Sorting and pagination using ORDER BY, LIMIT, and OFFSET.

PROJECT OUTCOME:
Successfully applied SQL queries to analyze customer orders,
product prices, supplier information, and sales data.

This project strengthened practical SQL skills and demonstrated
how relational databases can support business analysis
and data-driven decision-making.

=====================================================
                  END OF PROJECT
=====================================================
*/