-- Exercise 1: Ranking and Window Functions
-- Online Retail Store Database Setup

-- Drop existing tables if they exist
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Categories;

-- Create Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    Price DECIMAL(10, 2) NOT NULL
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Region VARCHAR(50) NOT NULL
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE NOT NULL
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL
);

-- Insert Sample Data
INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Garden'),
(4, 'Sports');

INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES
(101, 'Laptop', 1, 999.99),
(102, 'USB Cable', 1, 12.50),
(103, 'Monitor 27inch', 1, 299.99),
(104, 'T-Shirt', 2, 29.99),
(105, 'Jeans', 2, 79.99),
(106, 'Jacket', 2, 149.99),
(107, 'Garden Chair', 3, 89.99),
(108, 'Umbrella', 3, 45.00),
(109, 'Soccer Ball', 4, 34.99),
(110, 'Tennis Racket', 4, 189.99);

INSERT INTO Customers (CustomerID, CustomerName, City, Region) VALUES
(1, 'John Doe', 'New York', 'North'),
(2, 'Jane Smith', 'Los Angeles', 'West'),
(3, 'Michael Johnson', 'Chicago', 'Central'),
(4, 'Emily Davis', 'Houston', 'South');

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1001, 1, '2025-01-10'),
(1002, 2, '2025-01-15'),
(1003, 1, '2025-01-20'),
(1004, 3, '2025-01-25'),
(1005, 4, '2025-02-01');

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1001, 101, 1, 999.99),
(2, 1001, 102, 3, 12.50),
(3, 1002, 104, 2, 29.99),
(4, 1002, 105, 1, 79.99),
(5, 1003, 103, 1, 299.99),
(6, 1004, 106, 2, 149.99),
(7, 1005, 107, 4, 89.99);

-- Verify data
SELECT 'Categories' AS Table_Name, COUNT(*) AS Record_Count FROM Categories
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM OrderDetails;
