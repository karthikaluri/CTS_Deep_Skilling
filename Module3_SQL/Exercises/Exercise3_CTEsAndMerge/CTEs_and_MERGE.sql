-- Exercise 3: Common Table Expressions (CTEs) and MERGE
-- Working with Recursive CTEs and MERGE statements

-- ====================================================
-- PART 1: RECURSIVE CTE - Generate Calendar Table
-- ====================================================

-- Query 1: Basic Recursive CTE - Generate dates from 2025-01-01 to 2025-01-31
WITH DateCTE AS (
    -- Anchor member: starting point
    SELECT CAST('2025-01-01' AS DATE) AS CalendarDate
    
    UNION ALL
    
    -- Recursive member: increment by 1 day
    SELECT DATEADD(DAY, 1, CalendarDate)
    FROM DateCTE
    WHERE CalendarDate < '2025-01-31'
)
SELECT CalendarDate,
       DATENAME(WEEKDAY, CalendarDate) AS DayOfWeek,
       DAY(CalendarDate) AS DayNum,
       MONTH(CalendarDate) AS MonthNum,
       YEAR(CalendarDate) AS YearNum,
       CASE WHEN DATENAME(WEEKDAY, CalendarDate) IN ('Saturday', 'Sunday') THEN 'Weekend' ELSE 'Weekday' END AS DayType
FROM DateCTE
ORDER BY CalendarDate;

-- Query 2: Recursive CTE - Employee Hierarchy (Manager-Subordinate)
WITH EmployeeHierarchy AS (
    -- Anchor member: Top level managers (no boss)
    SELECT 
        EmployeeID,
        FirstName + ' ' + LastName AS EmployeeName,
        EmployeeID AS ManagerID,
        CAST(FirstName + ' ' + LastName AS VARCHAR(MAX)) AS ManagerName,
        0 AS Level
    FROM Employees
    WHERE EmployeeID NOT IN (SELECT DISTINCT ManagerID FROM Employees WHERE ManagerID IS NOT NULL)
    
    UNION ALL
    
    -- Recursive member: Get subordinates
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName,
        e.ManagerID,
        eh.EmployeeName,
        eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT 
    REPLICATE('  ', Level) + EmployeeName AS EmployeeNameHierarchy,
    Level,
    EmployeeID,
    ManagerID
FROM EmployeeHierarchy
ORDER BY Level, ManagerName, EmployeeName;

-- Query 3: Recursive CTE - Number Sequence (Powers of 2)
WITH NumberSequence AS (
    SELECT 1 AS PowerNumber, POWER(2, 0) AS PowerValue
    UNION ALL
    SELECT PowerNumber + 1, POWER(2, PowerNumber + 1)
    FROM NumberSequence
    WHERE PowerNumber < 10
)
SELECT PowerNumber, PowerValue
FROM NumberSequence;

-- ====================================================
-- PART 2: MERGE STATEMENT - Update/Insert/Delete
-- ====================================================

-- Create staging table for product price updates
CREATE TABLE IF NOT EXISTS StagingProducts (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    NewPrice DECIMAL(10, 2),
    UpdateDate DATE
);

-- Insert sample data into staging table
DELETE FROM StagingProducts;

INSERT INTO StagingProducts (ProductID, ProductName, NewPrice, UpdateDate) VALUES
(101, 'Laptop', 1099.99, '2025-02-01'),
(102, 'USB Cable', 9.99, '2025-02-01'),
(103, 'Monitor 27inch', 349.99, '2025-02-01'),
(111, 'Wireless Mouse', 24.99, '2025-02-01'),  -- New product
(112, 'USB Hub', 34.99, '2025-02-01');          -- New product

-- Query 4: MERGE Statement - Update existing products and insert new ones
MERGE INTO Products AS target
USING StagingProducts AS source
ON target.ProductID = source.ProductID
WHEN MATCHED AND target.Price <> source.NewPrice THEN
    -- Update existing product if price changed
    UPDATE SET 
        target.Price = source.NewPrice
WHEN NOT MATCHED BY TARGET THEN
    -- Insert new products that don't exist
    INSERT (ProductID, ProductName, CategoryID, Price)
    VALUES (source.ProductID, source.ProductName, 1, source.NewPrice)
WHEN NOT MATCHED BY SOURCE AND target.CategoryID = 1 THEN
    -- Delete products that are in staging but marked for deletion (optional)
    DELETE
OUTPUT 
    $action AS Action,
    inserted.ProductID,
    inserted.ProductName,
    inserted.Price,
    ISNULL(deleted.Price, inserted.Price) AS OldPrice;

-- Query 5: MERGE with complex logic - Customer updates
MERGE INTO Customers AS target
USING (
    SELECT 
        CustomerID,
        'Updated ' + CustomerName AS UpdatedName,
        City,
        Region
    FROM Customers
    WHERE MONTH(GETDATE()) = MONTH(GETDATE())
) AS source
ON target.CustomerID = source.CustomerID
WHEN MATCHED THEN
    UPDATE SET target.CustomerName = source.UpdatedName
OUTPUT deleted.*, inserted.*;

-- ====================================================
-- PART 3: COMMON TABLE EXPRESSIONS - Query Simplification
-- ====================================================

-- Query 6: Simple CTE - Reusable subqueries
WITH SalesByCategoryRegion AS (
    SELECT 
        p.CategoryID,
        c.CategoryName,
        cs.Region,
        SUM(od.Quantity * od.UnitPrice) AS TotalSales,
        COUNT(DISTINCT o.OrderID) AS OrderCount
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers cs ON o.CustomerID = cs.CustomerID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Categories c ON p.CategoryID = c.CategoryID
    GROUP BY p.CategoryID, c.CategoryName, cs.Region
)
SELECT 
    CategoryName,
    Region,
    TotalSales,
    OrderCount,
    ROUND(TotalSales / OrderCount, 2) AS AvgOrderValue
FROM SalesByCategoryRegion
WHERE TotalSales > 100
ORDER BY TotalSales DESC;

-- Query 7: Multiple CTEs - Complex business logic
WITH MonthlyOrderCounts AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        MONTH(o.OrderDate) AS OrderMonth,
        COUNT(o.OrderID) AS OrdersInMonth
    FROM Orders o
    JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY c.CustomerID, c.CustomerName, MONTH(o.OrderDate)
),
HighVolumeCustomers AS (
    SELECT 
        CustomerID,
        CustomerName,
        OrderMonth,
        OrdersInMonth,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderMonth) AS MonthRank
    FROM MonthlyOrderCounts
    WHERE OrdersInMonth >= 2
)
SELECT 
    CustomerID,
    CustomerName,
    OrderMonth,
    OrdersInMonth,
    MonthRank
FROM HighVolumeCustomers
WHERE MonthRank <= 3
ORDER BY CustomerName, MonthRank;

-- Query 8: CTE with aggregate - Customer spending analysis
WITH CustomerSpending AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.Region,
        SUM(od.Quantity * od.UnitPrice) AS TotalSpent,
        COUNT(o.OrderID) AS TotalOrders,
        AVG(od.Quantity * od.UnitPrice) AS AvgOrderValue
    FROM Orders o
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerID, c.CustomerName, c.Region
),
RankedCustomers AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY Region ORDER BY TotalSpent DESC) AS SpendingRank
    FROM CustomerSpending
)
SELECT 
    CustomerID,
    CustomerName,
    Region,
    TotalSpent,
    TotalOrders,
    AvgOrderValue,
    SpendingRank
FROM RankedCustomers
WHERE SpendingRank <= 5
ORDER BY Region, SpendingRank;

-- Clean up
DROP TABLE IF EXISTS StagingProducts;
