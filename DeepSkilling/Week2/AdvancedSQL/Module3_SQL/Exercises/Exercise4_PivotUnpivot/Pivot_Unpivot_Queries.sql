-- Exercise 4: PIVOT and UNPIVOT
-- Transforming data for reporting

-- Query 1: PIVOT - Convert monthly sales to columns
SELECT 
    ProductName,
    [January] AS Jan,
    [February] AS Feb,
    [March] AS Mar,
    [April] AS Apr,
    [May] AS May
INTO PivotedSalesData
FROM (
    SELECT 
        DATENAME(MONTH, o.OrderDate) AS MonthName,
        p.ProductName,
        od.Quantity * od.UnitPrice AS SalesAmount
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
) AS SourceData
PIVOT (
    SUM(SalesAmount)
    FOR MonthName IN ([January], [February], [March], [April], [May])
) AS PivotTable
ORDER BY ProductName;

-- Display pivoted data
SELECT * FROM PivotedSalesData;

-- Query 2: PIVOT - Sales by Region and Category
SELECT 
    Region,
    Electronics,
    Clothing,
    [Home & Garden],
    Sports
FROM (
    SELECT 
        c.Region,
        cat.CategoryName,
        od.Quantity * od.UnitPrice AS SalesAmount
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Categories cat ON p.CategoryID = cat.CategoryID
) AS SourceData
PIVOT (
    SUM(SalesAmount)
    FOR CategoryName IN ([Electronics], [Clothing], [Home & Garden], [Sports])
) AS PivotTable
ORDER BY Region;

-- Query 3: PIVOT - Product Quantity by Region
SELECT 
    ProductName,
    [North],
    [South],
    [East],
    [West],
    [Central]
FROM (
    SELECT 
        p.ProductName,
        c.Region,
        od.Quantity
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN Products p ON od.ProductID = p.ProductID
) AS SourceData
PIVOT (
    SUM(Quantity)
    FOR Region IN ([North], [South], [East], [West], [Central])
) AS PivotTable
ORDER BY ProductName;

-- Query 4: PIVOT with average calculation
SELECT 
    ProductName,
    ISNULL([North], 0) AS North_AvgPrice,
    ISNULL([South], 0) AS South_AvgPrice,
    ISNULL([East], 0) AS East_AvgPrice,
    ISNULL([West], 0) AS West_AvgPrice
FROM (
    SELECT 
        p.ProductName,
        c.Region,
        od.UnitPrice
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN Products p ON od.ProductID = p.ProductID
) AS SourceData
PIVOT (
    AVG(UnitPrice)
    FOR Region IN ([North], [South], [East], [West])
) AS PivotTable;

-- Query 5: UNPIVOT - Convert pivoted data back to normalized form
WITH UnpivotSource AS (
    SELECT 
        ProductName,
        'January' AS MonthName, [January] AS SalesAmount
    FROM PivotedSalesData
    
    UNION ALL
    
    SELECT 
        ProductName,
        'February', [February]
    FROM PivotedSalesData
    
    UNION ALL
    
    SELECT 
        ProductName,
        'March', [March]
    FROM PivotedSalesData
    
    UNION ALL
    
    SELECT 
        ProductName,
        'April', [April]
    FROM PivotedSalesData
    
    UNION ALL
    
    SELECT 
        ProductName,
        'May', [May]
    FROM PivotedSalesData
)
SELECT 
    ProductName,
    MonthName,
    ISNULL(SalesAmount, 0) AS SalesAmount
FROM UnpivotSource
ORDER BY ProductName, MonthName;

-- Query 6: Using UNPIVOT operator directly (SQL Server)
CREATE TABLE ProductSalesMonthly (
    ProductID INT,
    ProductName VARCHAR(100),
    January DECIMAL(10, 2),
    February DECIMAL(10, 2),
    March DECIMAL(10, 2),
    April DECIMAL(10, 2),
    May DECIMAL(10, 2)
);

INSERT INTO ProductSalesMonthly VALUES
(101, 'Laptop', 999.99, 1099.99, 899.99, 1199.99, 999.99),
(104, 'T-Shirt', 59.98, 89.97, 29.99, 59.98, 149.95),
(107, 'Garden Chair', 359.96, 269.97, 179.98, 449.95, 89.99);

SELECT 
    ProductName,
    MonthName,
    SalesAmount
FROM ProductSalesMonthly
UNPIVOT (
    SalesAmount FOR MonthName IN (January, February, March, April, May)
) AS UnpivotedTable
ORDER BY ProductName, CASE 
    WHEN MonthName = 'January' THEN 1
    WHEN MonthName = 'February' THEN 2
    WHEN MonthName = 'March' THEN 3
    WHEN MonthName = 'April' THEN 4
    WHEN MonthName = 'May' THEN 5
END;

-- Query 7: Complex PIVOT - Multiple aggregates
SELECT 
    ProductName,
    [North_Qty],
    [North_Value],
    [South_Qty],
    [South_Value],
    [East_Qty],
    [East_Value]
FROM (
    SELECT 
        p.ProductName,
        c.Region,
        CONCAT(c.Region, '_Qty') AS MeasureType,
        od.Quantity AS MeasureValue
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN Products p ON od.ProductID = p.ProductID
    
    UNION ALL
    
    SELECT 
        p.ProductName,
        c.Region,
        CONCAT(c.Region, '_Value') AS MeasureType,
        CAST(od.Quantity * od.UnitPrice AS INT) AS MeasureValue
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN Products p ON od.ProductID = p.ProductID
) AS SourceData
PIVOT (
    SUM(MeasureValue)
    FOR MeasureType IN ([North_Qty], [North_Value], [South_Qty], [South_Value], [East_Qty], [East_Value])
) AS PivotTable;

-- Query 8: PIVOT for creating cross-tabulation
SELECT 
    ISNULL(Region, 'TOTAL') AS Region,
    ISNULL(CAST(MONTH(o.OrderDate) AS VARCHAR), 'TOTAL') AS MonthNum,
    ISNULL(p.CategoryName, 'TOTAL') AS Category,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY ROLLUP (c.Region, MONTH(o.OrderDate), p.CategoryName)
ORDER BY Region, MonthNum;

-- Clean up
DROP TABLE IF EXISTS PivotedSalesData;
DROP TABLE IF EXISTS ProductSalesMonthly;
