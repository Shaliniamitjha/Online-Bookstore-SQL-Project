-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to theonlineBookstore;e database
 use OnlineBookstore;
 
 -- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- Import Data into Books Table
 SELECT * FROM Books;
 
 -- Import Data into Customers Table
 SELECT * FROM Customers;
 
 -- Import Data into Orders Table
 SELECT * FROM Orders;
 
 -- 1) Retrieve all books in the "Fiction" genre:
 SELECT * FROM BOOKS
 WHERE Genre='Fiction';
 
 -- 2) Find books published after the year 1950:
 SELECT * FROM BOOKS
 WHERE Published_Year>1950;
 
 -- 3) List all customers from the Canada:
 SELECT * FROM Customers
 WHERE Country='Canada';
 
 -- 4) Show orders placed in November 2023:
 SELECT * FROM Orders
 WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';
 
 -- 5) Retrieve the total stock of books available:
 SELECT SUM(Stock) AS Total_Stock
 FROM Books;
 
 -- 6) Find the details of the most expensive book:
SELECT * FROM Books
ORDER BY Price DESC
limit 1; 
 
 -- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE Total_Amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT Genre from Books;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books
ORDER BY Stock LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) AS revenue FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT * FROM ORDERS;
SELECT * FROM Books;

SELECT b.Genre,SUM(o.Quantity) AS Total_Books_Sold
FROM Books AS b
JOIN Orders AS o
on b.Book_ID=o.Book_ID
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre='Fantasy';

-- 3) List customers who have placed at least 2 orders
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT c.Name,o.Customer_ID,COUNT(o.Order_ID) AS Order_Count
FROM Customers as c
JOIN Orders as o
on c.Customer_ID=o.Customer_ID
GROUP BY c.Name,o.Customer_ID
HAVING COUNT(o.Order_ID)>=2;

-- 4) Find the most frequently ordered book:
SELECT * FROM Orders;
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books
WHERE Genre='Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT * FROM ORDERS;
SELECT b.Author,SUM(o.Quantity) AS Total_Books_Sold
FROM Books AS b
Join Orders AS o
ON b.Book_ID=o.Book_ID
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT * FROM Customers;
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT c.Customer_ID,c.Name,SUM(o.Total_Amount) AS Total_Spent
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID=o.Customer_ID
GROUP BY c.Customer_ID,Name
ORDER BY Total_Spent DESC LIMIT 1;

  --9) Calculate the stock remaining after fulfilling all orders:
SELECT * FROM Books;
SELECT * FROM Orders;

SELECT b.Book_ID,b.Title,b.Stock,COALESCE(SUM(o.Quantity),0)AS Order_Quantity,
b.Stock-COALESCE(SUM(o.Quantity),0) AS remaining_Quantity
FROM Books AS b
LEFT JOIN Orders AS o
ON b.Book_ID=o.Book_ID
GROUP BY b.Book_ID
ORDER BY Book_ID;
 











