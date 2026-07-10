-- Exercise 2: Aggregation with GROUPING SETS, CUBE, and ROLLUP
-- Sales Analysis with Multiple Dimensions

-- Query 1: Using GROUPING SETS - Get specific combinations
-- Totals by Region, by Category, and Grand Total
SELECT 
    ISNULL(c.Region, 'ALL') AS Region,
    ISNULL(p.CategoryName, 'ALL') AS Category,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales,
    COUNT(*) AS OrderCount,
    SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY GROUPING SETS (
    (c.Region),
    (p.CategoryName),
    (c.Region, p.CategoryName),
    ()
)
ORDER BY Region, Category;

-- Query 2: Using ROLLUP - Hierarchical totals
-- Region -> Category -> Product -> Grand Total
SELECT 
    c.Region,
    c.City,
    p.CategoryName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales,
    COUNT(DISTINCT o.OrderID) AS OrderCount,
    SUM(od.Quantity) AS TotalQuantity,
    CASE 
        WHEN GROUPING(c.Region) = 1 THEN 'Grand Total'
        WHEN GROUPING(c.City) = 1 THEN 'Region Total'
        WHEN GROUPING(p.CategoryName) = 1 THEN 'City Total'
        ELSE 'Detail'
    END AS AggregationLevel
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY ROLLUP (c.Region, c.City, p.CategoryName)
ORDER BY c.Region, c.City, p.CategoryName;

-- Query 3: Using CUBE - All possible combinations
-- Region X Category (all combinations including totals)
SELECT 
    ISNULL(c.Region, 'ALL Regions') AS Region,
    ISNULL(p.CategoryName, 'ALL Categories') AS Category,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales,
    COUNT(DISTINCT o.OrderID) AS NumberOfOrders,
    SUM(od.Quantity) AS TotalQuantity,
    AVG(od.UnitPrice) AS AvgUnitPrice,
    GROUPING(c.Region) AS RegionGrouping,
    GROUPING(p.CategoryName) AS CategoryGrouping
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY CUBE (c.Region, p.CategoryName)
ORDER BY Region, Category;

-- Query 4: ROLLUP for Sales by Year-Month-Day
SELECT 
    YEAR(o.OrderDate) AS YearNum,
    MONTH(o.OrderDate) AS MonthNum,
    DAY(o.OrderDate) AS DayNum,
    FORMAT(o.OrderDate, 'yyyy-MM-dd') AS OrderDate,
    SUM(od.Quantity * od.UnitPrice) AS DailySales,
    COUNT(*) AS ItemCount
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY ROLLUP (YEAR(o.OrderDate), MONTH(o.OrderDate), DAY(o.OrderDate), o.OrderDate)
ORDER BY YearNum, MonthNum, DayNum;

-- Query 5: Combined analysis - GROUPING SETS for specific needs
-- Get subtotals for different dimensions
SELECT 
    c.Region,
    c.City,
    p.CategoryName,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantity,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales,
    COUNT(DISTINCT o.OrderID) AS OrderCount
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY GROUPING SETS (
    (c.Region),
    (c.Region, c.City),
    (c.Region, c.City, p.CategoryName),
    (c.Region, c.City, p.CategoryName, p.ProductName),
    ()
)
ORDER BY Region, City, CategoryName, ProductName;

-- Query 6: Sales Performance Analysis with ROLLUP
SELECT 
    c.Region,
    p.CategoryName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    COUNT(DISTINCT c.CustomerID) AS UniqueCustomers,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,
    AVG(od.Quantity * od.UnitPrice) AS AvgOrderValue,
    MIN(od.UnitPrice) AS MinPrice,
    MAX(od.UnitPrice) AS MaxPrice
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY ROLLUP (c.Region, p.CategoryName)
ORDER BY c.Region, p.CategoryName;

-- Query 7: Using GROUPING() function to identify aggregation levels
SELECT 
    CASE WHEN GROUPING(c.Region) = 1 THEN 'TOTAL' ELSE ISNULL(c.Region, 'Unknown') END AS Region,
    CASE WHEN GROUPING(p.CategoryName) = 1 THEN 'TOTAL' ELSE ISNULL(p.CategoryName, 'Unknown') END AS Category,
    SUM(od.Quantity * od.UnitPrice) AS Revenue,
    COUNT(*) AS LineItems
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY GROUPING SETS (
    (c.Region, p.CategoryName),
    (c.Region),
    (p.CategoryName),
    ()
)
ORDER BY 
    CASE WHEN GROUPING(c.Region) = 1 THEN 2 ELSE 1 END,
    Region,
    Category;
