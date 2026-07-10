# Exercise 4: PIVOT and UNPIVOT

## Goal
Transform data for reporting using PIVOT to convert rows to columns and UNPIVOT to reverse the process.

## Scenario
Show monthly sales quantity per product in pivoted format (products as rows, months as columns), then unpivot back to normalized form.

## Key Concepts

### PIVOT Operator

**Purpose:**
- Converts row values into column headers
- Aggregates data across multiple dimensions
- Essential for cross-tabular reporting

**Syntax:**
```sql
SELECT ...
FROM (SELECT ... FROM SourceTable) AS SourceData
PIVOT (
    AggregateFunction(column)
    FOR PivotColumn IN (Value1, Value2, ...)
) AS PivotedTable
```

**Components:**
- **SELECT clause** - Columns to display
- **FROM clause** - Source data (usually subquery)
- **Aggregate function** - SUM, AVG, COUNT, MIN, MAX
- **FOR clause** - Column to pivot
- **IN clause** - Values to convert to columns

**Example:**
```sql
SELECT Product, [2024], [2025]
FROM (SELECT Year, Product, Sales FROM SalesData)
PIVOT (SUM(Sales) FOR Year IN ([2024], [2025]))
```

### UNPIVOT Operator

**Purpose:**
- Reverses PIVOT
- Converts column headers back to rows
- Normalizes denormalized data

**Syntax:**
```sql
SELECT ...
FROM PivotedTable
UNPIVOT (
    ValueColumn FOR NameColumn IN (Col1, Col2, ...)
) AS UnpivotedTable
```

## Comparison: PIVOT vs UNPIVOT

| Aspect | PIVOT | UNPIVOT |
|--------|-------|---------|
| Direction | Rows → Columns | Columns → Rows |
| Purpose | Create reports | Normalize data |
| Input | Normalized data | Denormalized data |
| Output | Cross-tabulation | Normalized rows |
| Use Case | Executive reports | Data warehouse |

## Files

### Pivot_Unpivot_Queries.sql

**PIVOT Examples (Queries 1-4)**
1. Monthly sales by product
2. Sales by region and category
3. Product quantity by region
4. Average price by product and region

**UNPIVOT Examples (Queries 5-6)**
5. Convert pivoted data back using UNION ALL
6. Using UNPIVOT operator directly

**Advanced Examples (Queries 7-8)**
7. Multiple aggregates in single PIVOT
8. Cross-tabulation with ROLLUP

## PIVOT Examples

### Example 1: Basic PIVOT
```sql
SELECT Product, [January], [February], [March]
FROM (
    SELECT DATENAME(MONTH, OrderDate) AS Month, 
           Product, Sales
    FROM Orders
) AS SourceData
PIVOT (
    SUM(Sales)
    FOR Month IN ([January], [February], [March])
) AS PivotTable;
```

### Example 2: PIVOT with Multiple Aggregates
```sql
SELECT Product,
       [2024_Q1] AS Q1_2024,
       [2024_Q2] AS Q2_2024,
       [2025_Q1] AS Q1_2025
FROM (
    SELECT Quarter, Year, Product, Revenue
    FROM Sales
) AS SourceData
PIVOT (
    SUM(Revenue)
    FOR Quarter IN ([Q1], [Q2], [Q3], [Q4])
) AS PivotTable;
```

## UNPIVOT Examples

### Example 1: Basic UNPIVOT
```sql
SELECT ProductName, MonthName, SalesAmount
FROM SalesData
UNPIVOT (
    SalesAmount FOR MonthName IN (January, February, March)
) AS UnpivotedData;
```

### Example 2: UNPIVOT with UNION ALL
```sql
SELECT Product, 'January' AS Month, January AS Sales FROM QuarterlyData
UNION ALL
SELECT Product, 'February', February FROM QuarterlyData
UNION ALL
SELECT Product, 'March', March FROM QuarterlyData;
```

## Real-World Applications

### PIVOT Use Cases
1. **Sales Reports** - Products × Months/Regions/Years
2. **Budget Analysis** - Departments × Budget Categories
3. **Performance Dashboard** - Metrics × Time Periods
4. **Inventory Reports** - Products × Warehouses
5. **Exam Results** - Students × Subjects

### UNPIVOT Use Cases
1. **Data Warehouse Loading** - Denormalized → Normalized
2. **Historical Analysis** - Pivot → Unpivot → Analyze
3. **Data Migration** - Legacy format conversion
4. **Data Reconciliation** - Compare formats
5. **Archive Processing** - Convert old reports

## Performance Considerations

**PIVOT Performance:**
- Indexes on PARTITION BY columns improve performance
- Aggregate function is the most expensive operation
- Limit number of pivot columns
- Use WHERE clause before PIVOT

**UNPIVOT Performance:**
- More efficient than UNION ALL
- Both are relatively lightweight
- No significant performance difference for small datasets

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| NULL values in output | Use ISNULL(column, 0) |
| Column count mismatch | All pivot values must have data |
| Unexpected duplicates | Aggregate function must reduce rows |
| Multiple values per group | Use aggregate function to consolidate |

## Practice Exercises

1. Create sales matrix (Products × Regions)
2. Build employee skills matrix (Employees × Skills)
3. Create quarterly revenue pivot
4. Build customer segment analysis pivot
5. Unpivot and reanalyze pivoted data

## Key Takeaways

✓ PIVOT transforms rows into columns for reporting
✓ UNPIVOT reverses the process
✓ Aggregate functions are essential
✓ Null handling is critical
✓ Performance depends on data volume
✓ Both operators are database-specific
✓ Often used together in ETL processes

## Advanced Techniques

1. **Dynamic PIVOT** - Column list not known in advance
2. **Conditional PIVOT** - CASE within aggregates
3. **Nested PIVOT** - Multiple pivots in sequence
4. **PIVOT with CTE** - Combine with CTEs for flexibility
5. **PIVOT Performance** - Indexing strategies

## Practice Dataset Tips

- Start with small datasets (< 1000 rows)
- Ensure all required columns are present
- Verify aggregate function matches business logic
- Test edge cases (nulls, duplicates, zeros)
- Always validate pivoted results
