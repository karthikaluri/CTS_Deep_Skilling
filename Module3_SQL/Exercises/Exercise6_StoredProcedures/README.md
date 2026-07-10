# Exercise 6: Stored Procedures

## Goal
Create and manage stored procedures for employee management system covering all aspects of stored procedure development.

## Scenario
Build a complete Employee Management System with 11 stored procedures demonstrating best practices.

## Key Concepts

### What is a Stored Procedure?

**Definition:**
- Precompiled SQL code stored in database
- Executed on server (not client)
- Reusable across applications
- Supports input/output parameters
- Can contain business logic

**Advantages:**
- Performance - Precompiled
- Security - Reduces SQL injection
- Reusability - Single source of truth
- Maintainability - Centralized changes
- Encapsulation - Hide implementation details

### Basic Syntax

```sql
CREATE PROCEDURE ProcedureName
    @Parameter1 DataType,
    @Parameter2 DataType OUTPUT
AS
BEGIN
    -- SQL statements
END;
```

### Parameter Types

- **Input Parameters** - Pass data to procedure
- **Output Parameters** - Return values
- **Return Values** - Numeric status codes

## Files

### Stored_Procedures.sql

**11 Complete Stored Procedures:**

### Exercise 1: Create a Stored Procedure
**sp_GetEmployeesByDepartment**
- Retrieves employee details by department
- Shows basic SELECT with parameters
- Includes JOIN and calculated columns

### Exercise 2: Modify a Stored Procedure
**sp_GetEmployeesByDepartment (Modified)**
- Added department statistics
- Subqueries for aggregates
- Enhanced with business metrics

### Exercise 3: Delete a Stored Procedure
- DROP PROCEDURE syntax explained
- Not implemented (would delete procedures)

### Exercise 4: Execute a Stored Procedure
- Multiple execution methods
- Named vs positional parameters
- Various EXEC syntaxes

### Exercise 5: Return Data from a Stored Procedure
**sp_GetEmployeeCountByDepartment**
- Returns aggregated data
- Multiple statistics (Count, Avg, Min, Max)
- Handles departments with no employees

### Exercise 6: Output Parameters
**sp_GetDepartmentTotalSalary**
- Multiple OUTPUT parameters
- Calculates department totals
- Handles edge cases (empty departments)

### Exercise 7: Multiple Parameters
**sp_UpdateEmployeeSalary**
- Two input parameters
- Updates based on EmployeeID
- Provides feedback message

### Exercise 8: Conditional Logic
**sp_GiveBonus**
- IF...ELSE IF...ELSE statements
- Conditional business logic
- Mass updates based on conditions

### Exercise 9: Transactions
**sp_TransferEmployee**
- BEGIN TRANSACTION...COMMIT
- TRY...CATCH error handling
- ROLLBACK on failure
- Data integrity enforcement

### Exercise 10: Dynamic SQL
**sp_GetEmployeesByFilter**
- QUOTENAME for identifier security
- Parameter replacement
- sp_executesql execution
- Flexible filtering

### Exercise 11: Error Handling
**sp_InsertEmployee**
- Comprehensive validation
- Custom error messages
- ERROR_NUMBER, ERROR_MESSAGE functions
- THROW statement for errors
- OUTPUT parameter returns

## Stored Procedure Best Practices

### Naming Convention
```sql
sp_[Action][ObjectName]
sp_GetEmployeesByDepartment
sp_UpdateEmployeeSalary
sp_InsertEmployee
```

### Parameter Naming
```sql
@ParameterName DataType
@EmployeeID INT
@NewSalary DECIMAL(10,2)
@DepartmentID INT
```

### Error Handling Pattern
```sql
BEGIN TRY
    -- Your code
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE();
    ROLLBACK;
END CATCH
```

### Transaction Pattern
```sql
BEGIN TRANSACTION
BEGIN TRY
    -- Critical operations
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    -- Error handling
END CATCH
```

## Common Patterns

### Pattern 1: Read-Only
```sql
CREATE PROCEDURE sp_GetData
    @ID INT
AS
BEGIN
    SELECT * FROM Table WHERE ID = @ID;
END;
```

### Pattern 2: Modify with Validation
```sql
CREATE PROCEDURE sp_UpdateData
    @ID INT,
    @Value VARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Table WHERE ID = @ID)
        THROW 50000, 'Record not found', 1;
    
    UPDATE Table SET Column = @Value WHERE ID = @ID;
END;
```

### Pattern 3: Insert with Return
```sql
CREATE PROCEDURE sp_InsertData
    @Value VARCHAR(50),
    @NewID INT OUTPUT
AS
BEGIN
    INSERT INTO Table (Column) VALUES (@Value);
    SET @NewID = SCOPE_IDENTITY();
END;
```

### Pattern 4: Delete with Safety
```sql
CREATE PROCEDURE sp_DeleteData
    @ID INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        DELETE FROM DependentTable WHERE ParentID = @ID;
        DELETE FROM Table WHERE ID = @ID;
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END;
```

## Real-World Examples

### HR Application
- sp_GetEmployeesByDepartment - List employees
- sp_UpdateEmployeeSalary - Adjust compensation
- sp_InsertEmployee - Onboard new staff
- sp_GetDepartmentMetrics - Department analytics

### E-Commerce
- sp_GetProductsByCategory - Product listing
- sp_UpdateInventory - Stock management
- sp_InsertOrder - Order placement
- sp_GetOrderHistory - Customer orders

### Financial
- sp_CalculateBonus - Bonus calculation
- sp_TransferFunds - Account transfers
- sp_GenerateReport - Financial reports
- sp_AuditTrail - Transaction logging

## Security Considerations

1. **Avoid SQL Injection**
   - Use parameterized queries
   - Use QUOTENAME for identifiers
   - Validate all inputs

2. **Permission Control**
   - Grant EXECUTE only
   - Hide table details
   - Control data access

3. **Error Messages**
   - Don't expose table names
   - Use generic error messages
   - Log detailed errors separately

4. **Data Validation**
   - Check input ranges
   - Verify foreign keys
   - Enforce business rules

## Performance Tips

1. **Indexes** - Create indexes on frequently searched columns
2. **Execution Plans** - Use SET STATISTICS TIME, IO
3. **Avoid Loops** - Use set-based operations
4. **Limit Results** - Use TOP clause when appropriate
5. **Cache Results** - Minimize redundant calls

## Testing Stored Procedures

```sql
-- Test basic execution
EXEC sp_GetEmployeesByDepartment @DepartmentID = 3;

-- Test with output parameters
DECLARE @Total DECIMAL(10,2);
EXEC sp_GetDepartmentTotalSalary @DepartmentID = 2, @TotalSalary = @Total OUTPUT;
SELECT @Total;

-- Test error handling
EXEC sp_InsertEmployee 'Test', '', 1, 5000, GETDATE();

-- Check execution plan
SET STATISTICS TIME ON;
EXEC sp_GetEmployeesByDepartment 3;
SET STATISTICS TIME OFF;
```

## Practice Exercises

1. Create sp_GetHighestPaidEmployees (Top 5)
2. Create sp_CalculateTenure (Years of service)
3. Create sp_PromoteEmployee (Department change with validation)
4. Create sp_GenerateSalaryReport (Dynamic report)
5. Create sp_AuditEmployeeChanges (Track modifications)

## Key Takeaways

✓ Stored procedures improve performance and security
✓ Always use parameters (avoid SQL injection)
✓ Implement proper error handling
✓ Use transactions for multi-step operations
✓ Validate inputs thoroughly
✓ Follow naming conventions
✓ Document your procedures
✓ Test edge cases
✓ Monitor execution performance
✓ Keep procedures focused and single-purpose

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| "Procedure not found" | Typo in name | Check exact name |
| Parameter mismatch | Wrong data type | Cast or convert |
| NULL results | Missing data | Add NULL handling |
| Permission denied | Insufficient rights | GRANT EXECUTE |
| Slow execution | Missing indexes | Check execution plan |

## Monitoring Stored Procedures

```sql
-- List all procedures
SELECT * FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = 'dbo';

-- Get procedure definition
SP_HELPTEXT 'sp_GetEmployeesByDepartment';

-- Check dependencies
sp_depends 'sp_GetEmployeesByDepartment';
```
