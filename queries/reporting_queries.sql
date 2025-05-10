--Query 1: Retrieve all orders for a specific customer
SELECT o.OrderID, o.OrderDate, o.TotalAmount, oi.ProductID, p.ProductName, oi.Quantity, oi.Price
FROM Orders o
JOIN OrderItems oi ON o.OrderId = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE o.CustomerID = 1;

--Query 2: Find the total sales for each product
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity * oi.Price) AS TotalSales
FROM OrderItems oi
JOIN Products p 
ON oi.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSales DESC;

--Query 3: Calculate the average order value
SELECT AVG(TotalAmount) AS AverageOrderValue FROM Orders;

--Query 4: List all products that are out of stock, i.e. stock = 0
SELECT * FROM Products WHERE Stock = 0;

SELECT ProductID, ProductName, Stock FROM Products WHERE Stock = 0;

-- with category name
SELECT p.ProductID, p.ProductName, c.CategoryName, p.Stock 
FROM Products p JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE Stock = 0;

--Query 5: Calculate the total number of orders placed each month
SELECT YEAR(OrderDate) as OrderYear,
MONTH(OrderDate) as OrderMonth,
COUNT(OrderID) as TotalOrders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth;

--Query 6: Retrieve the details of the most recent order
SELECT TOP 1 o.OrderID, o.OrderDate, o.TotalAmount, c.FirstName, c.LastName
FROM Orders o JOIN Customers c
ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC;

--Query 7: Find the average price of products in each category
SELECT c.CategoryID, c.CategoryName, AVG(p.Price) as AveragePrice 
FROM Categories c JOIN Products p
ON c.CategoryID = p.ProductID
GROUP BY c.CategoryID, c.CategoryName;

--Query 8: Retrieve the total quantity sold for each product
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalQuantitySold
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY p.ProductName;

--Query 9: Calculate the total revenue generated from each category
SELECT c.CategoryID, c.CategoryName, SUM(oi.Quantity * oi.Price) AS TotalRevenue
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
JOIN Categories c
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;

--Query 10: Retrieve orders with a total amount greater than a specific value (e.g., $500)
SELECT o.OrderID, c.CustomerID, c.FirstName, c.LastName, o.TotalAmount
FROM Orders o JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount >= 49.99
ORDER BY o.TotalAmount DESC;

--Query 11: List products along with the number of orders they appear in
SELECT p.ProductID, p.ProductName, COUNT(oi.OrderID) as OrderCount
FROM Products p JOIN OrderItems oi
ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY OrderCount DESC;

--Query 12: Calculate the total number of customers from each country
SELECT Country, COUNT(CustomerID) AS TotalCustomers
FROM Customers GROUP BY Country ORDER BY TotalCustomers DESC;

--Query 13: Retrieve the list of customers along with their total spending
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending
FROM Customers c JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;