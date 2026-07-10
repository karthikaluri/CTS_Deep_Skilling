# Exercise 2: Aggregation with GROUPING SETS, CUBE, and ROLLUP

## Goal
Analyze sales data across multiple dimensions using GROUPING SETS, ROLLUP, and CUBE to generate comprehensive reports.

## Scenario
Generate sales reports showing total quantity sold by Region and Category using different grouping strategies.

## Key Concepts

### GROUPING SETS
- Specifies exact combinations of columns to group by
- Most flexible - you control which combinations are calculated
- Syntax: `GROUP BY GROUPING SETS ((col1, col2), (col1), (col2), ())`

```sql
GROUP BY GROUPING SETS (
    (Region),           -- Region totals
    (Category),         -- Category totals
    (Region, Category), -- Region-Category totals
    ()                  -- Grand total
)
```

**Advantages:**
- Explicit control over groupings
- More efficient than UNION ALL
- Readable and maintainable

### ROLLUP
- Creates hierarchical totals
- Generates subtotals at each level
- Perfect for hierarchical data (Year-Month-Day)
- Syntax: `GROUP BY ROLLUP (col1, col2, col3)`

```sql
GROUP BY ROLLUP (Region, City, Category)
```

**Results in:**
1. (Region, City, Category) - Detail level
2. (Region, City) - City subtotals
3. (Region) - Region subtotals
4. () - Grand total

**Use Cases:**
- Fiscal hierarchies
- Geographic hierarchies
- Organizational structures

### CUBE
- Generates ALL possible combinations
- Creates complete cross-tabular analysis
- Syntax: `GROUP BY CUBE (col1, col2, col3)`

```sql
GROUP BY CUBE (Region, Category)
```

**Results in:**
1. (Region, Category) - All combinations
2. (Region) - Region totals
3. (Category) - Category totals
4. () - Grand total

**Use Cases:**
- Multi-dimensional analysis
- Market research
- Data warehousing

### GROUPING() Function
- Returns 1 if column is part of current grouping, 0 otherwise
- Identifies aggregation level
- Syntax: `GROUPING(column)`

```sql
CASE WHEN GROUPING(Region) = 1 THEN 'Grand Total' ELSE Region END
```

## Performance Comparison

| Clause | Result Rows | Use Case | Performance |
|--------|------------|----------|-------------|
| GROUP BY | n | Simple aggregation | Fast |
| GROUPING SETS | n+m | Specific combinations | Good |
| ROLLUP | Small multiple | Hierarchical | Good |
| CUBE | All combinations | Complete analysis | Slower |

## Files

### Aggregation_Queries.sql
Contains 7 comprehensive queries:

1. **GROUPING SETS Example** - Region and Category totals
2. **ROLLUP Example** - Hierarchical Region-City-Category totals
3. **CUBE Example** - All Region-Category combinations
4. **Time Hierarchy ROLLUP** - Year-Month-Day sales breakdown
5. **Combined GROUPING SETS** - Multi-level hierarchical aggregation
6. **Sales Performance ROLLUP** - Detailed sales metrics by Region-Category
7. **GROUPING Function** - Identifying aggregation levels

## Query Examples

### Query 1: GROUPING SETS for Specific Combinations
```sql
SELECT Region, Category, SUM(Sales)
FROM Orders
GROUP BY GROUPING SETS (
    (Region),
    (Category),
    (Region, Category),
    ()
);
```

### Query 2: ROLLUP for Hierarchical Data
```sql
SELECT Year, Month, Day, SUM(Sales)
FROM Sales
GROUP BY ROLLUP (Year, Month, Day);
```

### Query 3: CUBE for All Combinations
```sql
SELECT Region, Category, SUM(Sales)
FROM Orders
GROUP BY CUBE (Region, Category);
```

## Real-World Applications

1. **Financial Reporting** - Revenue by Department-Division-Company
2. **Retail Analysis** - Sales by Store-Region-Country
3. **HR Analytics** - Employee count by Department-Job Level-Location
4. **Supply Chain** - Inventory by Warehouse-Zone-Shelf
5. **Marketing** - Campaign performance by Channel-Region-Product

## Practice Exercises

1. Create a 3-level ROLLUP for Year-Quarter-Month sales
2. Use CUBE to analyze sales by Product-Customer-Region
3. Create GROUPING SETS for specific business requirements
4. Calculate running totals with ROLLUP
5. Identify which combinations have zero sales using CUBE

## Key Takeaways

✓ GROUPING SETS offers explicit control over combinations
✓ ROLLUP creates hierarchical subtotals efficiently
✓ CUBE generates all possible combinations
✓ GROUPING() function identifies aggregation levels
✓ Choose the right function based on your reporting needs
✓ All three are more efficient than multiple UNION ALL queries
✓ Performance depends on dimensionality and data volume
