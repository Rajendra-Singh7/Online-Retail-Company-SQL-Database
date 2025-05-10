/*
Implementing Views
	Views are virtual tables that represent the result of a query. 
	They can simplify complex queries and enhance security by restricting access to specific data.
*/


-- View for Product Details: A view combining product details with category names.
CREATE VIEW vw_ProductDeails AS
SELECT p.ProductID, p.ProductName, p.Price, p.Stock, c.CategoryName
FROM Products p INNER JOIN Categories c
ON p.CategoryID = c.CategoryID;
GO

-- Display product details with category names using view
SELECT * FROM vw_ProductDeails;
GO

-- View for Customer Orders : A view to get a summary of orders placed by each customer.
CREATE VIEW vw_CustomerOrders 
AS
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders,
SUM(oi.Quantity * p.Price) as TotalAmount
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
GO

-- View for Recent Orders: A view to display orders placed in the last 30 days.
CREATE VIEW vw_RecentOrders 
AS
SELECT o.OrderID, o.OrderDate, c.CustomerID, c.FirstName, c.LastName,
SUM(oi.Quantity * oi.Price) as OrderAmount
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY o.OrderID, o.OrderDate, c.CustomerID, c.FirstName, c.LastName;
GO

-- Query: Retrieve All Products with Category Names
SELECT * FROM vw_ProductDeails;
GO

-- Query: Retrieve Products within a Specific Price Range
SELECT * FROM vw_ProductDeails WHERE Price BETWEEN 10 AND 500;
GO

-- Query: Count the Number of Products in Each Category
SELECT CategoryName, Count(ProductID) AS ProductCount
FROM vw_ProductDeails GROUP BY CategoryName;
GO

-- Query: Retrieve Customers with More Than 1 Orders
SELECT * FROM vw_CustomerOrders WHERE TotalOrders > 1;
GO

-- Query: Retrieve the Total Amount Spent by Each Customer
SELECT CustomerID, FirstName, LastName, TotalAmount FROM vw_CustomerOrders
ORDER BY TotalAmount DESC;
GO

-- Query: Retrieve Recent Orders Above a Certain Amount
SELECT * FROM vw_RecentOrders WHERE OrderAmount > 1000;
GO

-- Query: Retrieve the Latest Order for Each Customer
SELECT ro.OrderID, ro.OrderDate, ro.CustomerID, ro.FirstName, ro.LastName, ro.OrderAmount
FROM vw_RecentOrders ro
INNER JOIN 
(SELECT CustomerID, Max(OrderDate) as LatestOrderDate FROM vw_RecentOrders GROUP BY CustomerID) latest
ON ro.CustomerID = latest.CustomerID AND ro.OrderDate = latest.LatestOrderDate
ORDER BY ro.OrderDate DESC;
GO

-- Query: Retrieve Products in a Specific Category
SELECT * FROM vw_ProductDeails WHERE CategoryName = 'Books';
GO

-- Query: Retrieve Total Sales for Each Category
SELECT pd.CategoryName, SUM(oi.Quantity * p.Price) AS TotalSales
FROM OrderItems oi
INNER JOIN Products p ON oi.ProductID = p.ProductID
INNER JOIN vw_ProductDeails pd ON p.ProductID = pd.ProductID
GROUP BY pd.CategoryName
ORDER BY TotalSales DESC;
GO

-- Query: Retrieve Customer Orders with Product Details
SELECT co.CustomerID, co.FirstName, co.LastName, o.OrderID, o.OrderDate,
pd.ProductName, oi.Quantity, pd.Price
FROM Orders o 
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN vw_ProductDeails pd ON oi.ProductID = pd.ProductID
INNER JOIN vw_CustomerOrders co ON o.CustomerID = co.CustomerID
ORDER BY o.OrderDate DESC;
GO

-- Query: Retrieve Top 5 Customers by Total Spending
SELECT TOP 5 CustomerID, FirstName, LastName, TotalAmount 
FROM vw_CustomerOrders ORDER BY TotalAmount DESC;
GO

-- Query: Retrieve Products with Low Stock
SELECT * FROM vw_ProductDeails WHERE Stock < 50;
GO

-- Query: Retrieve Orders Placed in the Last 7 Days
SELECT * from vw_RecentOrders WHERE OrderDate >= DATEADD(DAY, -7, GETDATE());
GO

-- Query: Retrieve Products Sold in the Last Month
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalSold
FROM vw_RecentOrders ro
INNER JOIN OrderItems oi ON ro.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
WHERE ro.OrderDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC;
GO