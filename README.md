# Book Store Data Analysis Using SQL

## Project Overview
This project focuses on analyzing a bookstore database using MySQL. It explores book inventory, customer purchasing behavior, order details, sales performance, and revenue generation.

The objective is to extract meaningful business insights using SQL queries and database operations.

## Technologies Used
- MySQL
- SQL
- GitHub

## Database Structure

The project contains three main tables:

1. **Books** – Book ID, Title, Author, Genre, Published Year, Price, Stock.
2. **Customer** – Customer ID, Name, Email, Phone, City, Country.
3. **Orders** – Order ID, Customer ID, Book ID, Order Date, Quantity, Total Amount.

## SQL Concepts Covered

- SELECT, WHERE, ORDER BY
- Aggregate Functions (SUM, AVG, COUNT, MIN, MAX)
- GROUP BY and HAVING
- INNER JOIN and LEFT JOIN
- Subqueries
- Window Functions (RANK)
- LIMIT and DISTINCT
- Business-oriented SQL analysis

## Project Analysis

### Basic Analysis
- Retrieve books by genre.
- Identify books published after 1950.
- Analyze customer locations.
- Calculate total inventory.
- Identify the most expensive books.
- Calculate total revenue.

### Advanced Analysis
- Books sold by genre.
- Customers with multiple orders.
- Most frequently ordered books.
- Top 3 expensive Fantasy books.
- Total books sold by each author.
- Highest spending customers.

### Business Analysis
- Top 10 best-selling books.
- Revenue by genre and author.
- Monthly revenue trends.
- Average order value.
- Customers with no orders.
- Books that have never been ordered.
- Low-stock and out-of-stock books.
- Customer purchase ranking.
- Revenue contribution by genre.

## How to Run the Project

1. Install MySQL Workbench.
2. Download or clone this repository.
3. Open the `book_store.sql` file in MySQL Workbench.
4. Execute the database creation and table creation statements.
5. Import or insert the dataset into the three tables.
6. Execute the SQL queries to perform the analysis.

## Project Objective

To demonstrate practical SQL skills and the ability to transform relational database information into meaningful business insights.


