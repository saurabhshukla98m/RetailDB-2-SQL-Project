# 🛒 RetailDB_2 — Customer & Order Data Analysis

### SQL Medium Assignment | MySQL Workbench

A SQL-based retail analytics project focused on analyzing customer information, orders, products, suppliers, and sales data using SQL joins, aggregate functions, subqueries, and advanced filtering techniques.

## 📌 Project Overview

This project demonstrates the practical application of SQL in retail and e-commerce analytics. It uses relational database tables to explore customer orders, product pricing, supplier information, and sales performance.

**Project Details**

* **Created by:** Saurabh Shukla
* **Domain:** Retail & E-Commerce Analytics
* **Database:** MySQL
* **Tool:** MySQL Workbench
* **Language:** SQL
* **Project Type:** SQL Medium Assignment

## 🎯 Project Objectives

* Retrieve and analyze customer and order information.
* Combine related tables using SQL joins.
* Calculate sales metrics using aggregate functions.
* Identify top customers based on spending.
* Analyze product prices and supplier performance.
* Find products that have never been ordered.
* Apply subqueries and advanced filtering techniques.

## 🗂️ Database Structure

The project contains five relational tables:

| Table       | Description                                             |
| ----------- | ------------------------------------------------------- |
| Customers   | Customer details, email, city, and signup date          |
| Suppliers   | Supplier names, contact emails, and locations           |
| Products    | Product names, categories, prices, and stock quantities |
| Orders      | Order dates, customer IDs, amounts, and payment modes   |
| Order_Items | Products, quantities, and prices associated with orders |

### Table Relationships

* Customers → Orders
* Suppliers → Products
* Orders → Order_Items
* Products → Order_Items

Primary keys and foreign keys are used to establish relationships between tables.

## 🛠️ SQL Concepts Covered

### 1. Joins

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* UNION for FULL OUTER JOIN simulation

### 2. Aggregate Functions

* COUNT()
* SUM()
* AVG()
* MAX()
* MIN()

### 3. Grouped Analysis

* GROUP BY
* HAVING
* ORDER BY

### 4. Subqueries

* Customers with orders above the average order amount
* Products that have never been ordered
* Customers who ordered Electronics products
* Most expensive products

### 5. Advanced Filtering

* WHERE
* IN and NOT IN
* BETWEEN
* IS NULL
* TRIM()

### 6. Sorting and Pagination

* LIMIT
* OFFSET

## 📊 Analysis Performed

The project includes 20 SQL queries addressing questions such as:

1. Retrieve products with their supplier names.
2. Display customers and their orders.
3. Identify suppliers with or without products.
4. Simulate a FULL OUTER JOIN.
5. Filter products by price and supplier city.
6. Identify customers with more than two orders.
7. Calculate supplier-wise sales value.
8. Calculate average, maximum, and minimum product prices by category.
9. Find the top five customers by total spending.
10. Count unique products ordered by each customer.
11. Find orders above the average order amount.
12. Identify products that have never been ordered.
13. Find customers who ordered Electronics products.
14. Identify suppliers whose products have total ordered quantities above 100.
15. Find the most expensive products.
16. Filter orders by selected customer cities.
17. Retrieve orders paid for using other payment methods.
18. Find customers with missing email addresses.
19. Identify suppliers located in cities not represented among customers.
20. Retrieve the latest three orders after skipping the first two.

## 📁 Project Files

The repository contains the following project resources:

* **SQL Script:** Complete database creation and analysis queries.
* **CSV Datasets:** Customer, supplier, product, order, and order-item data.
* **PowerPoint Presentation:** Project overview and SQL assignment presentation.

## ▶️ How to Run the Project

1. Install and open MySQL Workbench.
2. Download the SQL script and CSV datasets from this repository.
3. Open the SQL script in MySQL Workbench.
4. Execute the script to create the database and tables.
5. Import the CSV files int
