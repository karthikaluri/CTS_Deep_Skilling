-- Exercise 6: Stored Procedures - Employee Management System
-- Comprehensive collection of 11 stored procedures

-- ====================================================
-- Setup: Employee Management Tables
-- ====================================================

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10, 2) NOT NULL,
    JoinDate DATE NOT NULL
);

-- Insert sample data
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');

INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
('John', 'Doe', 1, 5000.00, '2020-01-15'),
('Jane', 'Smith', 2, 6000.00, '2019-03-22'),
('Michael', 'Johnson', 3, 7000.00, '2018-07-30'),
('Emily', 'Davis', 4, 5500.00, '2021-11-05'),
('Robert', 'Brown', 3, 6500.00, '2020-05-12'),
('Sarah', 'Wilson', 2, 6200.00, '2019-08-18');

-- ====================================================
-- Exercise 1: Create a Stored Procedure
-- ====================================================

-- Retrieve employee details by department
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        d.DepartmentName,
        e.Salary,
        e.JoinDate,
        DATEDIFF(YEAR, e.JoinDate, GETDATE()) AS YearsOfService
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE e.DepartmentID = @DepartmentID
    ORDER BY e.LastName, e.FirstName;
END;

-- Test Exercise 1
EXEC sp_GetEmployeesByDepartment @DepartmentID = 3;

-- ====================================================
-- Exercise 2: Modify a Stored Procedure
-- ====================================================

-- Modify to include salary information
ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        d.DepartmentName,
        e.Salary,
        e.JoinDate,
        DATEDIFF(YEAR, e.JoinDate, GETDATE()) AS YearsOfService,
        (SELECT COUNT(*) FROM Employees WHERE DepartmentID = @DepartmentID) AS EmployeesInDept,
        (SELECT AVG(Salary) FROM Employees WHERE DepartmentID = @DepartmentID) AS AvgDeptSalary
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE e.DepartmentID = @DepartmentID
    ORDER BY e.Salary DESC;
END;

-- Test Exercise 2
EXEC sp_GetEmployeesByDepartment @DepartmentID = 2;

-- ====================================================
-- Exercise 3: Delete a Stored Procedure
-- ====================================================

-- NOTE: To delete, use: DROP PROCEDURE sp_DeleteEmployee;
-- We'll skip this and demonstrate the other procedures

-- ====================================================
-- Exercise 4: Execute a Stored Procedure
-- ====================================================

-- This execution is shown above with EXEC commands
-- Different ways to execute:
-- EXEC sp_GetEmployeesByDepartment 3;
-- EXECUTE sp_GetEmployeesByDepartment @DepartmentID = 1;

-- ====================================================
-- Exercise 5: Return Data from a Stored Procedure
-- ====================================================

-- Create procedure that returns total number of employees in a department
CREATE PROCEDURE sp_GetEmployeeCountByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT 
        d.DepartmentName,
        COUNT(e.EmployeeID) AS EmployeeCount,
        AVG(e.Salary) AS AvgSalary,
        MIN(e.Salary) AS MinSalary,
        MAX(e.Salary) AS MaxSalary
    FROM Employees e
    RIGHT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE d.DepartmentID = @DepartmentID
    GROUP BY d.DepartmentName;
END;

-- Test Exercise 5
EXEC sp_GetEmployeeCountByDepartment @DepartmentID = 3;

-- ====================================================
-- Exercise 6: Use Output Parameters in a Stored Procedure
-- ====================================================

-- Create procedure with OUTPUT parameter for total salary
CREATE PROCEDURE sp_GetDepartmentTotalSalary
    @DepartmentID INT,
    @TotalSalary DECIMAL(10, 2) OUTPUT,
    @EmployeeCount INT OUTPUT,
    @AvgSalary DECIMAL(10, 2) OUTPUT
AS
BEGIN
    SELECT 
        @TotalSalary = SUM(Salary),
        @EmployeeCount = COUNT(*),
        @AvgSalary = AVG(Salary)
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
    
    IF @EmployeeCount = 0
    BEGIN
        SET @TotalSalary = 0;
        SET @AvgSalary = 0;
    END
END;

-- Test Exercise 6
DECLARE @TotalSalary DECIMAL(10, 2), @EmpCount INT, @AvgSal DECIMAL(10, 2);
EXEC sp_GetDepartmentTotalSalary @DepartmentID = 2, 
                                  @TotalSalary = @TotalSalary OUTPUT,
                                  @EmployeeCount = @EmpCount OUTPUT,
                                  @AvgSalary = @AvgSal OUTPUT;
SELECT @TotalSalary AS TotalSalary, @EmpCount AS EmployeeCount, @AvgSal AS AvgSalary;

-- ====================================================
-- Exercise 7: Create a Stored Procedure with Multiple Parameters
-- ====================================================

-- Create procedure to update employee salary
CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10, 2)
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
    
    PRINT 'Employee ID ' + CAST(@EmployeeID AS VARCHAR) + ' salary updated to ' + CAST(@NewSalary AS VARCHAR);
END;

-- Test Exercise 7
EXEC sp_UpdateEmployeeSalary @EmployeeID = 1, @NewSalary = 5500.00;

-- ====================================================
-- Exercise 8: Create a Stored Procedure with Conditional Logic
-- ====================================================

-- Create procedure to give bonus based on department
CREATE PROCEDURE sp_GiveBonus
    @DepartmentID INT,
    @BonusAmount DECIMAL(10, 2)
AS
BEGIN
    DECLARE @BonusPercentage DECIMAL(5, 2);
    
    -- Determine bonus percentage based on department
    IF @DepartmentID = 1 -- HR
        SET @BonusPercentage = 0.05;
    ELSE IF @DepartmentID = 2 -- Finance
        SET @BonusPercentage = 0.07;
    ELSE IF @DepartmentID = 3 -- IT
        SET @BonusPercentage = 0.10;
    ELSE IF @DepartmentID = 4 -- Marketing
        SET @BonusPercentage = 0.06;
    ELSE
        SET @BonusPercentage = 0.05;
    
    -- Update salaries with bonus
    UPDATE Employees
    SET Salary = Salary + (@BonusAmount * @BonusPercentage)
    WHERE DepartmentID = @DepartmentID;
    
    SELECT 'Bonus given to ' + CAST(@@ROWCOUNT AS VARCHAR) + ' employees in department ' + CAST(@DepartmentID AS VARCHAR) AS Message;
END;

-- Test Exercise 8
EXEC sp_GiveBonus @DepartmentID = 1, @BonusAmount = 100.00;

-- ====================================================
-- Exercise 9: Use Transactions in a Stored Procedure
-- ====================================================

-- Create procedure with transaction for data integrity
CREATE PROCEDURE sp_TransferEmployee
    @EmployeeID INT,
    @NewDepartmentID INT
AS
BEGIN
    BEGIN TRANSACTION
    BEGIN TRY
        -- Check if employee exists
        IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
        BEGIN
            THROW 50001, 'Employee not found', 1;
        END
        
        -- Check if new department exists
        IF NOT EXISTS (SELECT 1 FROM Departments WHERE DepartmentID = @NewDepartmentID)
        BEGIN
            THROW 50002, 'Department not found', 1;
        END
        
        -- Update employee department
        UPDATE Employees
        SET DepartmentID = @NewDepartmentID
        WHERE EmployeeID = @EmployeeID;
        
        -- Log the transaction (if audit table exists)
        PRINT 'Employee transferred successfully';
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;

-- Test Exercise 9
EXEC sp_TransferEmployee @EmployeeID = 2, @NewDepartmentID = 3;

-- ====================================================
-- Exercise 10: Use Dynamic SQL in a Stored Procedure
-- ====================================================

-- Create procedure using dynamic SQL for flexible filtering
CREATE PROCEDURE sp_GetEmployeesByFilter
    @FilterColumn VARCHAR(50),
    @FilterValue VARCHAR(100)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    
    SET @SQL = 'SELECT EmployeeID, FirstName, LastName, Salary, JoinDate FROM Employees WHERE ' 
               + QUOTENAME(@FilterColumn) + ' = ''' + REPLACE(@FilterValue, '''', '''''') + ''' ORDER BY LastName';
    
    EXEC sp_executesql @SQL;
END;

-- Test Exercise 10
EXEC sp_GetEmployeesByFilter @FilterColumn = 'DepartmentID', @FilterValue = '3';

-- ====================================================
-- Exercise 11: Handle Errors in a Stored Procedure
-- ====================================================

-- Create procedure with comprehensive error handling
CREATE PROCEDURE sp_InsertEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10, 2),
    @JoinDate DATE,
    @EmployeeID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        -- Validate inputs
        IF @FirstName IS NULL OR LTRIM(RTRIM(@FirstName)) = ''
            THROW 50101, 'FirstName cannot be empty', 1;
        
        IF @LastName IS NULL OR LTRIM(RTRIM(@LastName)) = ''
            THROW 50102, 'LastName cannot be empty', 1;
        
        IF @Salary < 1000
            THROW 50103, 'Salary must be at least 1000', 1;
        
        IF @JoinDate > GETDATE()
            THROW 50104, 'JoinDate cannot be in the future', 1;
        
        -- Check department exists
        IF NOT EXISTS (SELECT 1 FROM Departments WHERE DepartmentID = @DepartmentID)
            THROW 50105, 'Department does not exist', 1;
        
        -- Insert employee
        INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, JoinDate)
        VALUES (@FirstName, @LastName, @DepartmentID, @Salary, @JoinDate);
        
        SET @EmployeeID = SCOPE_IDENTITY();
        
        SELECT 'Employee successfully added with ID: ' + CAST(@EmployeeID AS VARCHAR) AS Message;
    END TRY
    BEGIN CATCH
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState;
        SET @EmployeeID = -1;
    END CATCH
END;

-- Test Exercise 11
DECLARE @NewEmployeeID INT;
EXEC sp_InsertEmployee 
    @FirstName = 'David',
    @LastName = 'Miller',
    @DepartmentID = 4,
    @Salary = 5500.00,
    @JoinDate = '2025-01-10',
    @EmployeeID = @NewEmployeeID OUTPUT;

SELECT @NewEmployeeID AS NewEmployeeID;

-- ====================================================
-- View all stored procedures created
-- ====================================================

SELECT 
    ROUTINE_NAME AS ProcedureName,
    ROUTINE_TYPE,
    CREATED AS CreationDate
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = 'dbo' 
  AND ROUTINE_NAME LIKE 'sp_%'
ORDER BY CREATED DESC;
