-- Exercise 5: Using CTE to Simplify Complex Queries
-- Customer Order Analysis

-- Query 1: Find customers who have placed more than 3 orders
WITH CustomerOrderCounts AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.Region,
        COUNT(o.OrderID) AS OrderCount,
        SUM(od.Quantity * od.UnitPrice) AS TotalSpending,
        AVG(od.Quantity * od.UnitPrice) AS AvgOrderValue,
        MIN(o.OrderDate) AS FirstOrderDate,
        MAX(o.OrderDate) AS LastOrderDate
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerID, c.CustomerName, c.Region
)
SELECT 
    CustomerID,
    CustomerName,
    Region,
    OrderCount,
    TotalSpending,
    AvgOrderValue,
    FirstOrderDate,
    LastOrderDate,
    DATEDIFF(DAY, FirstOrderDate, LastOrderDate) AS CustomerLivedaysDays
FROM CustomerOrderCounts
WHERE OrderCount > 3
ORDER BY OrderCount DESC;

-- Query 2: Multi-level CTE - Customer segmentation by spending
WITH CustomerSpending AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.Region,
        SUM(od.Quantity * od.UnitPrice) AS TotalSpent,
        COUNT(DISTINCT o.OrderID) AS OrderCount
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerID, c.CustomerName, c.Region
),
SpendingTiers AS (
    SELECT 
        *,
        CASE 
            WHEN TotalSpent >= 1000 THEN 'VIP'
            WHEN TotalSpent >= 500 THEN 'Premium'
            WHEN TotalSpent >= 100 THEN 'Regular'
            ELSE 'New/Inactive'
        END AS CustomerSegment,
        NTILE(4) OVER (ORDER BY TotalSpent DESC) AS SpendingQuartile
    FROM CustomerSpending
)
SELECT 
    CustomerID,
    CustomerName,
    Region,
    TotalSpent,
    OrderCount,
    CustomerSegment,
    SpendingQuartile
FROM SpendingTiers
ORDER BY SpendingQuartile, TotalSpent DESC;

-- Query 3: CTE with filtering for high-value customers
WITH ProductSalesByCustomer AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        p.ProductName,
        COUNT(od.OrderDetailID) AS PurchaseCount,
        SUM(od.Quantity) AS TotalQuantity,
        SUM(od.Quantity * od.UnitPrice) AS TotalValue
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.CustomerName, p.ProductName
),
TopProductsByCustomer AS (
    SELECT 
        CustomerID,
        CustomerName,
        ProductName,
        PurchaseCount,
        TotalQuantity,
        TotalValue,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY TotalValue DESC) AS ProductRank
    FROM ProductSalesByCustomer
)
SELECT 
    CustomerID,
    CustomerName,
    ProductName,
    PurchaseCount,
    TotalQuantity,
    TotalValue
FROM TopProductsByCustomer
WHERE ProductRank <= 3
ORDER BY CustomerID, ProductRank;

-- Query 4: CTE for regional analysis
WITH RegionalSales AS (
    SELECT 
        c.Region,
        p.CategoryName,
        SUM(od.Quantity * od.UnitPrice) AS SalesAmount,
        COUNT(DISTINCT o.OrderID) AS OrderCount,
        COUNT(DISTINCT c.CustomerID) AS CustomerCount
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY c.Region, p.CategoryName
),
RegionalTotals AS (
    SELECT 
        Region,
        SUM(SalesAmount) AS RegionTotalSales,
        SUM(OrderCount) AS RegionTotalOrders,
        SUM(CustomerCount) AS RegionCustomerCount
    FROM RegionalSales
    GROUP BY Region
)
SELECT 
    rs.Region,
    rs.CategoryName,
    rs.SalesAmount,
    rt.RegionTotalSales,
    ROUND(100.0 * rs.SalesAmount / rt.RegionTotalSales, 2) AS PercentOfRegion,
    rs.OrderCount,
    rs.CustomerCount
FROM RegionalSales rs
JOIN RegionalTotals rt ON rs.Region = rt.Region
ORDER BY rs.Region, rs.SalesAmount DESC;

-- Query 5: CTE for customer lifetime value analysis
WITH OrderAnalysis AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.Region,
        o.OrderID,
        o.OrderDate,
        SUM(od.Quantity * od.UnitPrice) AS OrderTotal
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerID, c.CustomerName, c.Region, o.OrderID, o.OrderDate
),
CustomerMetrics AS (
    SELECT 
        CustomerID,
        CustomerName,
        Region,
        COUNT(OrderID) AS LifetimeOrderCount,
        SUM(OrderTotal) AS LifetimeValue,
        AVG(OrderTotal) AS AvgOrderValue,
        MIN(OrderDate) AS FirstPurchaseDate,
        MAX(OrderDate) AS LastPurchaseDate,
        DATEDIFF(DAY, MIN(OrderDate), MAX(OrderDate)) AS CustomerTenureDays
    FROM OrderAnalysis
    WHERE OrderID IS NOT NULL
    GROUP BY CustomerID, CustomerName, Region
)
SELECT 
    CustomerID,
    CustomerName,
    Region,
    LifetimeOrderCount,
    LifetimeValue,
    AvgOrderValue,
    FirstPurchaseDate,
    LastPurchaseDate,
    CustomerTenureDays,
    CASE 
        WHEN LifetimeOrderCount >= 5 AND LifetimeValue >= 500 THEN 'Loyal VIP'
        WHEN LifetimeOrderCount >= 3 AND LifetimeValue >= 200 THEN 'Regular Customer'
        WHEN LifetimeOrderCount = 1 THEN 'New Customer'
        ELSE 'At Risk'
    END AS CustomerStatus
FROM CustomerMetrics
WHERE LifetimeOrderCount > 0
ORDER BY LifetimeValue DESC;

-- Query 6: CTE for year-over-year comparison
WITH MonthlySales AS (
    SELECT 
        YEAR(o.OrderDate) AS SalesYear,
        MONTH(o.OrderDate) AS SalesMonth,
        DATENAME(MONTH, o.OrderDate) AS MonthName,
        SUM(od.Quantity * od.UnitPrice) AS MonthlySales,
        COUNT(DISTINCT o.OrderID) AS OrderCount
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate), DATENAME(MONTH, o.OrderDate)
),
MonthlyGrowth AS (
    SELECT 
        SalesYear,
        SalesMonth,
        MonthName,
        MonthlySales,
        OrderCount,
        LAG(MonthlySales) OVER (PARTITION BY SalesMonth ORDER BY SalesYear) AS PreviousYearSales,
        ROUND(100.0 * (MonthlySales - LAG(MonthlySales) OVER (PARTITION BY SalesMonth ORDER BY SalesYear)) / 
              LAG(MonthlySales) OVER (PARTITION BY SalesMonth ORDER BY SalesYear), 2) AS YoYGrowthPercent
    FROM MonthlySales
)
SELECT 
    SalesYear,
    SalesMonth,
    MonthName,
    MonthlySales,
    PreviousYearSales,
    ISNULL(YoYGrowthPercent, 0) AS YoYGrowthPercent,
    OrderCount
FROM MonthlyGrowth
ORDER BY SalesYear, SalesMonth;

-- Query 7: CTE for cohort analysis
WITH FirstOrderMonth AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        MIN(DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1)) AS CohortMonth
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CustomerName
),
OrderMonths AS (
    SELECT 
        fom.CustomerID,
        fom.CustomerName,
        fom.CohortMonth,
        DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1) AS OrderMonth,
        DATEDIFF(MONTH, fom.CohortMonth, DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1)) AS MonthNumber,
        SUM(od.Quantity * od.UnitPrice) AS MonthlySales
    FROM FirstOrderMonth fom
    JOIN Orders o ON fom.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY fom.CustomerID, fom.CustomerName, fom.CohortMonth, 
             DATEFROMPARTS(YEAR(o.OrderDate), MONTH(o.OrderDate), 1)
)
SELECT 
    CustomerID,
    CustomerName,
    CohortMonth,
    MonthNumber,
    MonthlySales,
    SUM(MonthlySales) OVER (PARTITION BY CustomerID ORDER BY MonthNumber ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSales
FROM OrderMonths
ORDER BY CohortMonth, MonthNumber;
