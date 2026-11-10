# create a database
create database bookstore_db;
use bookstore_db;

# Creating tables.

create table books(
                    book_id int primary key,
                    TITLE VARCHAR(50) ,
                    AUTHOR VARCHAR(50) ,
                    GENRE varchar(30) ,
                    PUBLISHED_YEAR INT,
                    PRICE DECIMAL(10,2),
                    STOCK INT);
                    
# CUSTOMER TABLES
CREATE TABLE CUSTOMER(
					   CUSTOMER_ID INT PRIMARY KEY,
                       NAME VARCHAR(50),
                       EMAIL VARCHAR(50),
                       PHONE VARCHAR(20),
                       CITY VARCHAR(30),
                       COUNTRY VARCHAR(50)
                       );
                       
# ORDER TABLE
create TABLE ORDERS(
                  ORDER_ID INT PRIMARY KEY,
                  CUSTOMER_ID INT,
                  BOOK_ID INT,
                  ORDER_DATE DATE,
                  QUANTITY INT,
                  TOTAL_AMOUNT DECIMAL(10,2),
                  
                  FOREIGN KEY (CUSTOMER_ID)
                  REFERENCES CUSTOMER(CUSTOMER_ID),
                  
                  FOREIGN KEY (BOOK_ID)
                  REFERENCES BOOKS(BOOK_ID)
                  );
                  
SELECT COUNT(*) FROM BOOKS;
SELECT count(*) FROM CUSTOMER;
SELECT COUNT(*) FROM ORDERS;

# cHECK THE ACTUAL RECORD
SELECT * FROM BOOKS LIMIT 10;
SELECT * FROM customer LIMIT 10;
SELECT * FROM ORDERS LIMIT 10;

# PART A BASIC QUERIES
#1 RETRIEVE ALL BOOKS IN THE "FICTION" GENRE
SELECT * FROM books
WHERE GENRE = "FICTION";

#2 FIND BOOKS PUBLISHED AFTER THE YEAR 1950
SELECT * FROM BOOKS 
WHERE PUBLISHED_YEAR > 1950
ORDER BY PUBLISHED_YEAR DESC;

#3 LIST ALL CUSTOMERS FROM A PARTICULAR CRITERIA 
SELECT * FROM CUSTOMER
WHERE COUNTRY= "INDIA";

#4 SHOW ORDERS PLACE IN NOVEMBER 2023
SELECT * FROM ORDERS 
WHERE ORDER_DATE >= "2023-11-1"
AND ORDER_DATE <="2023-12-01";

#5 RETRIEVE THE TOTAL STOCK OF BOOKS AVAILABLE
SELECT SUM(STOCK)AS TOTAL_STOCK
FROM BOOKS;

#6 FIND THE DETAILS OF TH MOST EXPENSIVE BOOK
SELECT * FROM BOOKS 
WHERE PRICE = (SELECT MAX(PRICE) FROM BOOKS );

#7 SHOW ALL CUSTOMERS WHO ORDERS MORE THAN QUANTITY OF A BOOK
SELECT DISTINCT C.CUSTOMER_ID,
                C.NAME,
                O.QUANTITY
			FROM CUSTOMER c
            JOIN ORDERS o 
            ON C.CUSTOMER_ID = O.CUSTOMER_ID
		WHERE O.QUANTITY >1;
        
#8 RETRIEVE ALL ORDERS WHERE TOTAL AMOUNT EXCEEDS $20
SELECT* FROM ORDERS
WHERE TOTAL_AMOUNT > 20;

#9 LIST ALL GENRES AVAILABLE IN THE BOOKS TABLE 
SELECT DISTINCT GENRE 
FROM BOOKS;

# 10 fIND THE BOOKS WITH THE LOWEST STOCK
SELECT * FROM books
WHERE STOCK = (SELECT MIN(STOCK) FROM BOOKS);

#11 CLACULATE TOTAL REVENUE GENERATED FROM ALL ORDERS
SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE 
FROM ORDERS;

# PART B ADVANCED QUERIES
# 1 RETRIEVE THE TOTAL NUMBERS OF BOOKS SOLD FOR EACH GENRE
SELECT
    b.Genre,
    SUM(o.Quantity) AS Total_Books_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Total_Books_Sold DESC;

#2 FIND AVERAGE PRICE OF BOOKS IN FANTACY GENRE
SELECT AVG(PRICE) AS AVERAGE_FANTACY_PRICE
FROM books WHERE GENRE = 'FANTACY';

# 3 LIST CUSTOMERS WHO HAVE PLACED AT LEAST 2 ORDERS
SELECT C.CUSTOMER_ID,
C.NAME,
COUNT(O.ORDER_ID) AS TOTAL_ORDERS
FROM CUSTOMER C 
JOIN ORDERS O 
ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID,
C.NAME
HAVING COUNT(O.ORDER_ID) >= 2
ORDER BY TOTAL_ORDERS DESC;

# 4 Find the most frequetnly ordered book

select b.book_id,b.Title,sum(o.Quantity) as total_quantity_sold
from books b 
join orders o 
on b.book_id = o.book_id
group by b.book_id,
b.title
order by Total_quantity_sold desc
Limit 1;

# 5 show the top 3 most expensive books of fantacy genre
SELECT
    Book_ID,
    Title,
    Author,
    Price
FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

# 6 Retrieve total quantity of books sold by each author
select b.author, sum(o.Quantity) as total_books_sold
from Books b 
join Orders o
on b.book_id = o.book_id
group by b.author
order by total_books_sold Desc;

# 7 List cities where customers who spent over $30 are located
select c.city, sum(o.total_amount) as total_spent
from customer c
join orders o 
on c.customer_id = o.customer_id 
group by c.city
having sum(o.total_amount) >30
order by total_spent desc;

# 8 Find the customer who spent the most on orders
select c.customer_id, c.name, 
sum(o.total_amount) as total_spent
from customer c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id , c.name 
order by total_spent desc limit 1;

#9 Calculate stock remaining after fulfilling all oreders
Select b.book_id,b.title,b.stock as current_stock,
coalesce(sum(o.quantity),0) as total_sold,
b.stock - coalesce(sum(o.quantity) , 0) as remaining_stock
from books b
left join orders o 
on b.book_id = o.book_id
group by b.book_id,
b.title,
b.stock
order by remaining_stock asc;

# Part C Business analysis queries
# 1 TOp 10 best-selling Books
select b.book_id,b.title,b.author,b.genre,sum(o.quantity) as quantity_sold
from books b 
join orders o 
on b.book_id = o.book_id 
group by b.book_id ,
b.title, b.author, b.genre 
order by quantity_sold desc 
limit 10;

# 2 Revenue by genre

select b.genre , sum(o.total_amount) as revenue
from books b 
join orders o 
on b.book_id = o.book_id
group by b.genre
order by revenue desc;

# 3 Revenue by author
Select b.author, sum(o.total_amount) as revenue
from books b 
join orders o 
on b.book_id = o.book_id
group by b.author 
order by revenue desc;

# 4 Monthly revenue 

select year(order_date) as order_year,
month(order_date) as order_month,
sum(total_amount) as monhly_revenue
from orders 
group by 
year(order_date),
month(order_date)
order by 
order_year,
order_month;

    
# 5 Average order value 
select avg(total_amount) as average_order_value
from orders;

# 6 Total books sold

select sum(quantity) as total_books_sold
from orders;

#7 customers with no orders
select c.customer_id,
c.name, c.email
from customer c
left join orders o on c.customer_id = o.customer_id 
where o.order_id is null;

# 8 Books never ordered
SELECT
    b.Book_ID,
    b.Title,
    b.Author,
    b.Genre,
    b.Stock
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Order_ID IS NULL;

# 9 Low stock books
 select book_id,
 title,
 author,
 stock 
 from books where stock <= 5 
 order by stock asc;
 
 # 11 Out-of stock books
 
 select book_id,
 title,
 author, genre
 from books where stock = 0;
 
 #12 most popular genre
 
 select b.genre, sum(o.quantity) as books_sold
 from books b
 join orders o 
 on b.book_id = o.book_id
 group by b.genre
 order by books_sold desc
 limit 1;
 
 #12 highest revenue-generating genre 
SELECT
    b.Genre,
    SUM(o.Total_Amount) AS Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC
LIMIT 1;

# 14 customer purchase ranking 

select c.customer_id, c.name , 
sum(o.total_amount) as total_spent, 
rank() over( order by sum(o.total_amount) desc ) 
as customer_rank 
from customer c 
join orders o 
on c.customer_id = o.customer_id 
group by c.customer_id,c.name;

# 14 revenue contribution by genre 
SELECT
    b.Genre,
    SUM(o.Total_Amount) AS Revenue,
    ROUND(
        SUM(o.Total_Amount) * 100.0 /
        (SELECT SUM(Total_Amount) FROM Orders),
        2
    ) AS Revenue_Percentage
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;





