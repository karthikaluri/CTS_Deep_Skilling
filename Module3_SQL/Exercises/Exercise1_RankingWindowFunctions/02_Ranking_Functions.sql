-- Exercise 1: Ranking and Window Functions
-- Find top 3 most expensive products in each category

-- Query 1: Using ROW_NUMBER() - Unique rank within each category
SELECT 
    'ROW_NUMBER' AS FunctionType,
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price,
    ROW_NUMBER() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS RankNum
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE ROW_NUMBER() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) <= 3
ORDER BY c.CategoryName, RankNum;

-- Query 2: Using RANK() - Handle ties by skipping ranks
SELECT 
    'RANK' AS FunctionType,
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price,
    RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS RankNum
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) <= 3
ORDER BY c.CategoryName, RankNum;

-- Query 3: Using DENSE_RANK() - Handle ties without skipping ranks
SELECT 
    'DENSE_RANK' AS FunctionType,
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price,
    DENSE_RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS RankNum
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE DENSE_RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) <= 3
ORDER BY c.CategoryName, RankNum;

-- Query 4: Comparison - All three ranking functions
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price,
    ROW_NUMBER() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS RowNum,
    RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS RankNum,
    DENSE_RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS DenseRankNum
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.Price DESC;

-- Query 5: Window Functions with aggregates - Total price per category
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price,
    SUM(p.Price) OVER (PARTITION BY c.CategoryID) AS CategoryTotal,
    COUNT(*) OVER (PARTITION BY c.CategoryID) AS ProductsInCategory,
    AVG(p.Price) OVER (PARTITION BY c.CategoryID) AS AvgCategoryPrice,
    RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS PriceRank
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.Price DESC;

-- Query 6: LAG and LEAD - Compare with previous and next product price
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price,
    LAG(p.Price, 1) OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS PreviousPrice,
    LEAD(p.Price, 1) OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS NextPrice,
    p.Price - LAG(p.Price, 1) OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS PriceDifference
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.Price DESC;

-- Query 7: NTILE - Distribution into quartiles
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Price,
    NTILE(4) OVER (PARTITION BY c.CategoryID ORDER BY p.Price DESC) AS PriceQuartile
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, PriceQuartile, p.Price DESC;
