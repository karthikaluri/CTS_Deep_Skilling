# Lab 3: Using EF Core CLI to Create and Apply Migrations

## Scenario
The retail store's database needs to be created based on the models defined. EF Core CLI is used to generate and apply migrations.

## Objective
Learn how to use EF Core CLI to manage database schema changes.

---

## Steps Executed

1. **Installed EF Core CLI:**
   ```bash
   dotnet tool install --global dotnet-ef
   ```

2. **Created Initial Migration:**
   ```bash
   dotnet ef migrations add InitialCreate
   ```
   *Output:*
   ```text
   Build started...
   Build succeeded.
   Done. To undo this action, use 'ef migrations remove'
   ```
   Generates a `Migrations/` directory containing database creation schema instructions.

3. **Applied Migration to Create Database:**
   ```bash
   dotnet ef database update
   ```
   *Output:*
   ```text
   Build started...
   Build succeeded.
   Acquiring an exclusive lock for migration application.
   Applying migration '20260721040742_InitialCreate'.
   Done.
   ```

4. **Database Verification:**
   Confirmed that database `RetailInventoryDb` and tables `Categories` and `Products` are created in SQL Server LocalDB.
