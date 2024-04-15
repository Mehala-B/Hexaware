--TASK 1

CREATE DATABASE TechShopDB;

CREATE TABLE dbo.Customers(
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(10),
LastName VARCHAR(10),
Email VARCHAR(20),
Phone INT,
Address VARCHAR(30));

CREATE TABLE dbo.Products(
ProductID INT PRIMARY KEY,
CategoryID INT REFERENCES Categories(CategoryID),
ProductName VARCHAR(20),
Description VARCHAR(50),
Price INT);

CREATE TABLE dbo.Orders(
OrderID INT PRIMARY KEY,
CustomerID INT REFERENCES Customers(CustomerID), 
OrderDate DATE,
TotalAmount INT);

CREATE TABLE dbo.OrderDetails(
OrderDetailID INT PRIMARY KEY,
OrderID INT REFERENCES Orders(OrderID),
ProductID INT REFERENCES Products(ProductID),
Quantity INT);

CREATE TABLE dbo.Inventory(
InventoryID INT PRIMARY KEY,
ProductID INT REFERENCES Products(ProductID),
QuantityInStock INT,
LastStockUpdate DATE);

CREATE TABLE Categories(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(20)
);


INSERT INTO Customers VALUES
(1,'Allen','Smith','allen@gmail.com',1233212312,'142 Main St, Pune'),
(2,'Benny','George','benny@gmail.com',1456327241,'232 Cross St, Mumbai'),
(3,'John','Davis','john@gmail.com',1246787466,'464 Line St, Punjab'),
(4,'Caren','David','caren@gmail.com',1332642756,'324 Main St, Bangalore'),
(5,'Henry','Jones','henry@gmail.com',1286653326,'239 Link St, Delhi'),
(6,'Harry','Potter','harry@gmail.com',1545443253,'542 Cross St, Chennai'),
(7,'Charlie','Lewis','charlie@gmail.com',1423535675,'654 Head St, Patna'),
(8,'Marry','Willams','marry@gmail.com',1237654686,'764 Mount St, Pune'),
(9,'Jenny','Dooms','jenny@gmail.com',1753442544,'234 Main St, Bangalore'),
(10,'Sara','Diana','sara@gmail.com',1433562354,'564 Pink St, Chennai')

INSERT INTO Products VALUES
(101,1301,'Smartwatch','Latest Model',1000),
(102,1302,'Laptop','Light weight',45000),
(103,1303,'Smartphone','Large display',15000),
(104,1304,'Headphones','Wireless',700),
(105,1305,'Mouse','Wireless',850),
(106,1306,'Bluetooth Speaker','High quality',25000),
(107,1307,'Keyboard','Portable and Latest',13000),
(108,1308,'Smart TV','Larger Screen',35000),
(109,1309,'Printer','Advanced',17000),
(110,1310,'Desktop Computer','High quality',39000)

INSERT INTO Orders VALUES
(1001,3,'2023-09-06',35000),
(1002,2,'2023-12-23',700),
(1003,7,'2024-01-13',17000),
(1004,6,'2024-03-04',13000),
(1005,9,'2023-05-30',1000),
(1006,10,'2024-02-19',45000),
(1007,5,'2023-11-01',850),
(1008,1,'2023-12-22',13000),
(1009,4,'2024-04-02',700),
(1010,8,'2023-11-16',39000)


INSERT INTO OrderDetails VALUES
(1101,1005,107,2),
(1102,1002,105,1),
(1103,1001,103,1),
(1104,1010,102,4),
(1105,1008,109,2),
(1106,1003,110,2),
(1107,1007,101,1),
(1108,1009,104,1),
(1109,1006,106,2),
(1110,1004,108,3)


INSERT INTO Inventory VALUES
(1201,106,4,'2024-01-16'),
(1202,102,2,'2024-02-01'),
(1203,109,2,'2024-02-14'),
(1204,103,2,'2023-12-30'),
(1205,102,5,'2023-11-29'),
(1206,110,3,'2024-03-26'),
(1207,107,7,'2024-01-25'),
(1208,101,3,'2024-03-31'),
(1209,104,6,'2024-02-11'),
(1210,105,2,'2024-03-17')

INSERT INTO Categories VALUES
(1301,'Elec_gadgets'),
(1302,'Elec_gadgets'),
(1303,'Elec_gadgets'),
(1304,'Elec_gadgets'),
(1305,'Elec_gadgets'),
(1306,'Elec_appliance'),
(1307,'Elec_gadgets'),
(1308,'Elec_appliance'),
(1309,'Elec_appliance'),
(1310,'Elec_gadgets')


--Task 2

--1.Write an SQL query to retrieve the names and emails of all customers.

SELECT FirstName,LastName,Email FROM Customers

--2.Write an SQL query to list all orders with their order dates and corresponding customer names.
SELECT OrderID,OrderDate,CONCAT(Customers.FirstName,' ',Customers.LastName) AS CustomerName
FROM Orders,Customers 
WHERE Orders.CustomerID=Customers.CustomerID

--3.Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.

INSERT INTO Customers VALUES
(11,'Kenly','Moon','kenly@gmail.com',1237815452,'249 Main St, Pune')

--4.Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.

UPDATE Products
SET Price=Price*1.1

--5.Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.

DECLARE @InputOrderID INT;
SET @InputOrderID=112;
DELETE FROM OrderDetails WHERE OrderID = @InputOrderID;
DELETE FROM Orders WHERE OrderID = @InputOrderID;


--6.Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.

INSERT INTO Orders VALUES
(1011,11,'2023-07-16',36000)


--7.Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.

DECLARE @InputCustomerID INT;
DECLARE @InputEmail VARCHAR(20);
DECLARE @InputAddress VARCHAR(30);
SET @InputCustomerID=2;
SET @InputEmail='bengeorge@gmail.com';
SET @InputAddress='342 Cross St,Chennai';
UPDATE Customers
SET Email=@InputEmail,Address=@InputAddress WHERE CustomerID=@InputCustomerID;



--8.Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.

UPDATE Orders
SET TotalAmount = (Quantity * Price) 
FROM OrderDetails O,Products 
WHERE O.ProductID = Products.ProductID AND O.OrderID =Orders.OrderID;

--9.Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter

DECLARE @InputCustomerID INT;
SET @InputCustomerID=11;
DELETE FROM OrderDetails WHERE OrderID IN 
(SELECT OrderID FROM Orders
WHERE CustomerID = @InputCustomerID)
DELETE FROM Orders WHERE CustomerID = @InputCustomerID;

--10.Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
INSERT INTO Products VALUES
(111,1303,'CPU','High Performance',10000)


--11.Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.

ALTER TABLE Orders ADD Status VARCHAR(10);
DECLARE @OrderID INT
DECLARE @Status VARCHAR(10)
SET @OrderID=1001
SET @Status='Shipped'
UPDATE Orders SET Status=@Status WHERE OrderID=@OrderID;


--12.Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.

SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS OrdersPlaced
FROM Customers c,Orders o WHERE c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


--TASK 3

--1.Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.

SELECT OrderID,OrderDate,CONCAT(Customers.FirstName,' ',Customers.LastName) AS CustomerName
FROM Orders INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;

--2.Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.

SELECT Products.ProductName, SUM(Products.Price * OrderDetails.Quantity) AS TotalRevenue
FROM Products
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductName;

--3.Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.

SELECT CONCAT(Customers.FirstName,' ',Customers.LastName) AS CustomerName,Phone,Email,OrderID FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID;

--4.Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.

SELECT TOP 1 Quantity,ProductName
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
ORDER BY Quantity DESC;


--5.Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.

SELECT ProductName,CategoryName FROM Products p 
INNER JOIN Categories c ON p.CategoryID=c.CategoryID;


--6.Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.

SELECT Customers.FirstName, Customers.LastName, AVG(Orders.TotalAmount) AS AverageOrderValue
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.FirstName, Customers.LastName;

--7.Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.

SELECT TOP 1 SUM(Orders.TotalAmount) AS TotalRevenue,Orders.OrderID, Customers.FirstName, Customers.LastName, Customers.Email
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Orders.OrderID, Customers.FirstName, Customers.LastName, Customers.Email
ORDER BY TotalRevenue DESC

--8.Write an SQL query to list electronic gadgets and the number of times each product has been ordered.

SELECT Products.ProductName, COUNT(OrderDetails.OrderID) AS NumOrders
FROM Products
LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductName;

--9.Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.

DECLARE @ProductName VARCHAR(255);
SET @ProductName = 'Keyboard';

SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone, c.Address
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = @ProductName;

--10.Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;

SET @StartDate = '2024-01-01';
SET @EndDate = '2024-03-31';

SELECT SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate BETWEEN @StartDate AND @EndDate;


--TASK 4

--1.Write an SQL query to find out which customers have not placed any orders.

SELECT * FROM Customers WHERE CustomerID NOT IN
(SELECT CustomerID FROM Orders)

--2.Write an SQL query to find the total number of products available for sale.

SELECT SUM(QuantityInStock) AS NO_OF_PRO_FOR_SALE FROM Inventory

--3.Write an SQL query to calculate the total revenue generated by TechShop. 

SELECT  SUM(TotalAmount) AS total_revenue
FROM  Orders
WHERE CustomerID IN (SELECT CustomerID FROM Customers);

--4.Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.

SELECT AVG(No_quantity_ordered) AS average_quantity_ordered FROM 
(SELECT COUNT(o.Quantity) AS No_quantity_ordered
FROM OrderDetails o WHERE o.ProductID IN 
(SELECT p.ProductID FROM Products p WHERE p.CategoryID IN 
(SELECT CategoryID FROM Categories WHERE CategoryName='Elec_gadgets'))) AS No_quantity_ordered;

--5.Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
DECLARE @Customerid INT
SET @Customerid=6
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders WHERE CustomerID=@Customerid; 

--6.Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.

SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c WHERE c.CustomerID = 
(SELECT CustomerID FROM Orders WHERE OrderID=
(SELECT OrderID FROM OrderDetails WHERE Quantity=
(SELECT MAX(Quantity) FROM OrderDetails)));

--7.Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
SELECT CategoryName FROM Categories WHERE CategoryID=
(SELECT CategoryID FROM Products WHERE ProductID=
(SELECT ProductID FROM OrderDetails WHERE Quantity=
(SELECT MAX(Quantity) FROM OrderDetails)));

--8.Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.

SELECT FirstName,LastName,MAX(TotalAmount) AS MONEY_SPENT FROM Customers C,Orders WHERE C.CustomerID =
(SELECT CustomerID FROM Orders WHERE TotalAmount=
(SELECT Max(TotalAmount) FROM Orders WHERE OrderID IN
(SELECT OrderID FROM OrderDetails WHERE ProductID IN
(SELECT ProductID FROM Products WHERE CategoryID IN
(SELECT CategoryID FROM Categories WHERE CategoryName='Elec_gadgets')))))
GROUP BY FirstName,LastName;

--9.Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.

SELECT c.CustomerID,c.FirstName,c.LastName,
(SELECT SUM(od.Quantity * p.Price) FROM Orders o
 INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
 INNER JOIN Products p ON od.ProductID = p.ProductID
 WHERE o.CustomerID = c.CustomerID) / 
(SELECT COUNT(*) FROM Orders o
WHERE o.CustomerID = c.CustomerID) AS AverageOrderValue
FROM Customers c

--10.Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count.

SELECT c.FirstName,c.LastName,
(SELECT COUNT(*) FROM Orders o WHERE o.CustomerID = c.CustomerID ) AS OrderCount
FROM Customers c;


SELECT * FROM Customers
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM OrderDetails
SELECT * FROM Inventory
SELECT * FROM Categories

