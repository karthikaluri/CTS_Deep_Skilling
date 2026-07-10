# Exercise 5: Using CTE to Simplify Complex Queries

## Goal
Use Common Table Expressions to simplify complex queries and improve readability for business intelligence analysis.

## Scenario
Find all customers who have placed more than 3 orders in total and analyze their purchasing patterns using CTEs.

## Key Concepts

### Why CTEs for Simplification?

**Benefits:**
1. **Readability** - Complex logic broken into logical steps
2. **Maintainability** - Easier to update business rules
3. **Reusability** - CTE can be referenced multiple times
4. **Debuggability** - Test intermediate results
5. **Organization** - Top-down logical flow

### CTE Patterns

**Pattern 1: Single CTE**
```sql
WITH FilteredCustomers AS (
    SELECT ... FROM Customers WHERE ...
)
SELECT * FROM FilteredCustomers;
```

**Pattern 2: Multiple CTEs**
```sql
WITH CTE1 AS (...),
     CTE2 AS (...),
     CTE3 AS (...)
SELECT * FROM CTE3;
```

**Pattern 3: CTE with Window Functions**
```sql
WITH Ranked AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY ...) AS Rank
    FROM Table
)
SELECT * FROM Ranked WHERE Rank <= 10;
```

## Files

### CTE_Query_Examples.sql

**7 Progressive Examples:**

1. **Basic Customer Analysis**
   - Count orders per customer
   - Identify customers with >3 orders
   - Calculate spending metrics

2. **Multi-level CTE - Customer Segmentation**
   - First CTE: Calculate spending
   - Second CTE: Create segments (VIP, Premium, Regular)
   - Result: Segmented customer list

3. **Top Products Per Customer**
   - First CTE: Calculate sales by product
   - Second CTE: Rank products per customer
   - Result: Top 3 products per customer

4. **Regional Analysis**
   - First CTE: Calculate regional sales
   - Second CTE: Calculate regional totals
   - Result: Sales breakdown by percentage

5. **Customer Lifetime Value**
   - Analyze ordering patterns
   - Calculate tenure and metrics
   - Create customer status classification

6. **Year-over-Year Growth**
   - Calculate monthly sales per year
   - Compare with previous year
   - Calculate growth percentages

7. **Cohort Analysis**
   - Group customers by first purchase month
   - Track repeat purchases
   - Calculate cumulative spending

## Real-World Scenarios

### Scenario 1: Customer Retention Analysis
```sql
WITH FirstOrder AS (
    SELECT CustomerID, MIN(OrderDate) AS FirstPurchaseDate
    FROM Orders
    GROUP BY CustomerID
),
RecentOrder AS (
    SELECT CustomerID, MAX(OrderDate) AS LastPurchaseDate
    FROM Orders
    GROUP BY CustomerID
)
SELECT 
    f.CustomerID,
    DATEDIFF(DAY, f.FirstPurchaseDate, r.LastPurchaseDate) AS DaysSinceFirst,
    CASE WHEN DATEDIFF(DAY, r.LastPurchaseDate, GETDATE()) > 180 THEN 'Churned'
         ELSE 'Active'
    END AS CustomerStatus
FROM FirstOrder f
JOIN RecentOrder r ON f.CustomerID = r.CustomerID;
```

### Scenario 2: RFM Segmentation
```sql
WITH RFM AS (
    SELECT 
        CustomerID,
        MAX(OrderDate) AS LastOrderDate,
        COUNT(OrderID) AS Frequency,
        SUM(OrderTotal) AS Monetary,
        DATEDIFF(DAY, MAX(OrderDate), GETDATE()) AS Recency
    FROM Orders
    GROUP BY CustomerID
)
SELECT 
    CustomerID,
    CASE WHEN Recency < 90 THEN 'Recent' ELSE 'Not Recent' END,
    CASE WHEN Frequency > 5 THEN 'Frequent' ELSE 'Not Frequent' END,
    CASE WHEN Monetary > 1000 THEN 'High Value' ELSE 'Low Value' END
FROM RFM;
```

### Scenario 3: Funnel Analysis
```sql
WITH CustomerJourney AS (
    SELECT 
        CustomerID,
        COUNT(OrderID) AS OrderCount,
        COUNT(DISTINCT CAST(OrderDate AS DATE)) AS PurchaseDays,
        SUM(OrderTotal) AS LifetimeValue
    FROM Orders
    GROUP BY CustomerID
)
SELECT 
    CASE 
        WHEN OrderCount >= 10 THEN 'Loyal'
        WHEN OrderCount >= 5 THEN 'Regular'
        WHEN OrderCount >= 2 THEN 'Repeat'
        ELSE 'First-time'
    END AS CustomerSegment,
    COUNT(*) AS CustomerCount
FROM CustomerJourney
GROUP BY CASE... END;
```

## Query Optimization Tips

1. **Filter Early** - Apply WHERE clauses in CTEs
2. **Aggregate First** - Pre-aggregate before joins
3. **Limit Data** - Use ROW_NUMBER() to limit results
4. **Index Columns** - Ensure proper indexes on join columns
5. **Test Incrementally** - Build and test each CTE

## Common CTE Patterns

### Pattern: Incremental Aggregation
```sql
WITH Level1 AS (SELECT Category, SUM(Sales) FROM ...),
     Level2 AS (SELECT SUM(Sales) FROM Level1)
SELECT * FROM Level2;
```

### Pattern: Ranking and Filtering
```sql
WITH Ranked AS (SELECT *, ROW_NUMBER() OVER (...)),
     Top10 AS (SELECT * FROM Ranked WHERE Rank <= 10)
SELECT * FROM Top10;
```

### Pattern: Time Series
```sql
WITH Daily AS (SELECT Date, SUM(Sales) FROM ...),
     Weekly AS (SELECT DATEPART(WEEK, Date), SUM(...) FROM Daily)
SELECT * FROM Weekly;
```

## Performance Considerations

- CTEs are evaluated once per use in newer SQL Server versions
- Materialized CTEs (results stored) when reused multiple times
- Filter as early as possible
- Use appropriate indexes
- Test execution plans

## Practice Exercises

1. Create customer activity analysis CTE
2. Build sales trend CTE with growth calculations
3. Implement product recommendation CTE
4. Create inventory turnover CTE
5. Build revenue forecast CTE with trends

## Key Takeaways

✓ CTEs improve query readability significantly
✓ Multiple CTEs allow complex logic decomposition
✓ Window functions pair well with CTEs
✓ Filtering in CTEs reduces downstream processing
✓ Test intermediate CTE results for debugging
✓ Documentation in CTEs improves maintenance
✓ Performance equivalent to subqueries but more readable

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| CTE not found | Used outside scope | Define before SELECT |
| Circular reference | Self-referencing non-recursive | Use recursive CTE syntax |
| Performance | Too much data | Filter early in CTE |
| NULL values | Missing joins | Use LEFT JOIN |
| Wrong totals | Incorrect aggregation | Verify GROUP BY |
