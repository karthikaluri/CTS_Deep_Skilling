# Exercise 1: Ranking and Window Functions

## Goal
Use ROW_NUMBER(), RANK(), DENSE_RANK(), OVER(), and PARTITION BY to find the top 3 most expensive products in each category.

## Scenario
Find the top 3 most expensive products in each category using different ranking functions and compare how each handles ties.

## Key Concepts

### Window Functions Overview
Window functions perform calculations across a set of rows related to the current row.

### Ranking Functions

#### ROW_NUMBER()
- Assigns a unique sequential number to each row
- Handles ties by assigning consecutive numbers
- Syntax: `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)`

```sql
ROW_NUMBER() OVER (PARTITION BY CategoryID ORDER BY Price DESC)
```

#### RANK()
- Assigns the same rank to tied rows
- Skips subsequent ranks after ties
- Example: 1, 2, 2, 4 (skips 3)

```sql
RANK() OVER (PARTITION BY CategoryID ORDER BY Price DESC)
```

#### DENSE_RANK()
- Assigns the same rank to tied rows
- Does NOT skip subsequent ranks
- Example: 1, 2, 2, 3 (no gap)

```sql
DENSE_RANK() OVER (PARTITION BY CategoryID ORDER BY Price DESC)
```

### Other Window Functions

#### LAG() and LEAD()
- Access data from previous or following rows
- Useful for comparisons
- `LAG(column, offset) OVER (ORDER BY ...)`
- `LEAD(column, offset) OVER (ORDER BY ...)`

#### NTILE(n)
- Divides ordered rows into n groups
- Useful for quartiles, deciles, percentiles
- `NTILE(4)` creates 4 equal groups

#### Aggregate Functions with OVER
- `SUM()`, `AVG()`, `COUNT()`, `MIN()`, `MAX()` can be used as window functions
- `SUM(Price) OVER (PARTITION BY CategoryID)`

## Files

### 01_Setup_Tables.sql
- Creates all required tables (Categories, Products, Customers, Orders, OrderDetails)
- Inserts sample data
- Verifies data insertion

### 02_Ranking_Functions.sql
Complete SQL queries demonstrating:

1. **ROW_NUMBER() Query** - Unique sequential ranking
2. **RANK() Query** - Ranking with skips on ties
3. **DENSE_RANK() Query** - Ranking without skips
4. **Comparison Query** - All three functions side-by-side
5. **Aggregate Window Functions** - SUM, COUNT, AVG with windows
6. **LAG/LEAD Query** - Compare with previous/next rows
7. **NTILE Query** - Quartile distribution

## Steps to Execute

1. Run `01_Setup_Tables.sql` to create and populate tables
2. Run `02_Ranking_Functions.sql` to see all ranking examples
3. Analyze the differences in output between functions

## Sample Output Interpretation

### Difference Between RANK and DENSE_RANK
For Products with prices [1000, 800, 800, 500]:

- ROW_NUMBER(): 1, 2, 3, 4
- RANK(): 1, 2, 2, 4 (skips rank 3)
- DENSE_RANK(): 1, 2, 2, 3 (no gaps)

## Real-World Applications

1. **Sales Analysis** - Top N customers per region
2. **HR Reports** - Top paid employees per department
3. **Performance Metrics** - Employee rankings with percentiles
4. **Financial Reports** - Top products by revenue
5. **Trend Analysis** - Period-over-period comparisons using LAG/LEAD

## Performance Considerations

- Window functions are evaluated after WHERE clause
- Use PARTITION BY to limit window scope
- ORDER BY in OVER clause determines window order
- Indexes on PARTITION BY and ORDER BY columns improve performance

## Practice Exercises

1. Find top 2 most expensive products per category
2. Find products within top 25% price range per category
3. Calculate price difference between consecutive products per category
4. Identify products that are at least 50% more expensive than average in their category
5. Find customers with the most orders per region

## Key Takeaways

✓ Window functions operate on a set of rows without collapsing them
✓ PARTITION BY defines the window
✓ ORDER BY determines the window order
✓ ROW_NUMBER is best when you need unique numbers
✓ RANK/DENSE_RANK handle ties differently
✓ LAG/LEAD enable row-to-row comparisons
✓ Aggregate functions can work as window functions
