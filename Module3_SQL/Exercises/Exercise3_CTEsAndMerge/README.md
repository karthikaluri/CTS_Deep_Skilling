# Exercise 3: CTEs and MERGE

## Goal
Master Common Table Expressions (CTEs), Recursive CTEs, and MERGE statements for advanced data manipulation.

## Scenario
1. Create a recursive CTE to generate a calendar table for January 2025
2. Use MERGE to update/insert product prices from a staging table
3. Simplify complex queries using CTEs

## Key Concepts

### Common Table Expressions (CTEs)

**What is a CTE?**
- Temporary named result set
- Scope: Only within single SELECT, INSERT, UPDATE, DELETE statement
- Syntax: `WITH CTE_Name AS (...) SELECT ...`

**Advantages:**
- Improves readability
- Makes complex queries manageable
- Allows recursion
- Reusable within single statement

**Basic Syntax:**
```sql
WITH MyCTE AS (
    SELECT col1, col2 FROM Table
    WHERE condition
)
SELECT * FROM MyCTE;
```

### Recursive CTEs

**Structure:**
1. **Anchor Member** - Starting point (non-recursive query)
2. **Recursive Member** - References CTE itself
3. **UNION ALL** - Combines both

**Syntax:**
```sql
WITH RecursiveCTE AS (
    -- Anchor member
    SELECT ... WHERE StopCondition
    
    UNION ALL
    
    -- Recursive member
    SELECT ... 
    FROM RecursiveCTE
    WHERE ContinueCondition
)
SELECT * FROM RecursiveCTE;
```

**Use Cases:**
- Organizational hierarchies
- Bill of Materials (BOM)
- Date sequences
- Number sequences
- Genealogy trees

### MERGE Statement

**Purpose:**
- Combines INSERT, UPDATE, DELETE in single statement
- Compares source and target
- Executes conditional actions

**Syntax:**
```sql
MERGE INTO TargetTable AS target
USING SourceTable AS source
ON target.KeyColumn = source.KeyColumn
WHEN MATCHED THEN UPDATE SET ...
WHEN NOT MATCHED BY TARGET THEN INSERT ...
WHEN NOT MATCHED BY SOURCE THEN DELETE;
```

**Clauses:**
- WHEN MATCHED - Record exists in both
- WHEN NOT MATCHED BY TARGET - Source has record target doesn't
- WHEN NOT MATCHED BY SOURCE - Target has record source doesn't

## Files

### CTEs_and_MERGE.sql

**Part 1: Recursive CTEs (Queries 1-3)**
1. Calendar generation - All dates in January 2025
2. Employee hierarchy - Manager-subordinate relationships
3. Number sequence - Powers of 2

**Part 2: MERGE Statement (Queries 4-5)**
4. Product price updates and insertions
5. Customer data merge with complex logic

**Part 3: CTE Query Simplification (Queries 6-8)**
6. Simple CTE - Sales by category and region
7. Multiple CTEs - High-volume customer analysis
8. Complex CTE chain - Customer spending analysis with ranking

## Recursive CTE Examples

### Example 1: Date Sequence
```sql
WITH DateCTE AS (
    SELECT CAST('2025-01-01' AS DATE) AS DateValue
    UNION ALL
    SELECT DATEADD(DAY, 1, DateValue)
    FROM DateCTE
    WHERE DateValue < '2025-01-31'
)
SELECT * FROM DateCTE;
```

### Example 2: Hierarchy
```sql
WITH Hierarchy AS (
    SELECT EmployeeID, Name, NULL AS ManagerID, 0 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    SELECT e.EmployeeID, e.Name, e.ManagerID, h.Level + 1
    FROM Employees e
    JOIN Hierarchy h ON e.ManagerID = h.EmployeeID
)
SELECT * FROM Hierarchy;
```

## MERGE Examples

### Example 1: Update and Insert
```sql
MERGE INTO Products AS target
USING StagingProducts AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET target.Price = source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price);
```

### Example 2: With OUTPUT
```sql
MERGE INTO Customers AS target
USING NewCustomers AS source
ON target.CustomerID = source.CustomerID
WHEN NOT MATCHED BY TARGET THEN
    INSERT VALUES (...)
OUTPUT $action, inserted.*, deleted.*;
```

## Real-World Applications

### CTEs
1. **Reporting** - Multi-level calculations
2. **Hierarchies** - Organization charts, BOMs
3. **Analytics** - Customer segmentation, cohort analysis
4. **Date Sequences** - Generate missing dates, calendar tables

### Recursive CTEs
1. **Organizational Charts** - Employee hierarchies
2. **BOM Explosion** - Product composition
3. **Cost Accounting** - Roll-up calculations
4. **Tree Structures** - Folder hierarchies, taxonomies

### MERGE
1. **ETL Processes** - Staging table updates
2. **Inventory Management** - Stock synchronization
3. **Price Updates** - Batch pricing changes
4. **Data Warehouse Loading** - SCD implementation

## Performance Considerations

- CTEs are evaluated each time they're referenced
- Use indexed columns in JOIN conditions
- Recursive CTEs can be slow with deep nesting
- MERGE is typically faster than INSERT/UPDATE/DELETE separately
- Consider MAXRECURSION hint for recursive CTEs

## Practice Exercises

1. Create calendar table for entire 2025 year
2. Build 3-level organizational hierarchy (CEO -> Manager -> Employee)
3. Generate numbers 1-100 using recursive CTE
4. Implement SCD Type 2 using MERGE
5. Create customer cohort analysis with multiple CTEs

## Key Takeaways

✓ CTEs improve query readability and maintainability
✓ Recursive CTEs enable hierarchical queries
✓ MERGE is efficient for complex multi-action scenarios
✓ Multiple CTEs can be chained for complex logic
✓ OUTPUT clause shows what was modified
✓ Recursive CTEs need proper termination conditions
✓ Both are more efficient than alternative approaches

## Troubleshooting

**Issue: Infinite recursion**
- Solution: Ensure recursive member has termination condition

**Issue: CTE not found**
- Solution: CTE scope is only within single statement

**Issue: MERGE produces duplicates**
- Solution: Ensure ON condition is unique

**Issue: Recursive CTE slow**
- Solution: Add MAXRECURSION hint or optimize joins
