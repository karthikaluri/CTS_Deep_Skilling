# Lab 1: Understanding ORM with a Retail Inventory System

## Scenario
You’re building an inventory management system for a retail store. The store wants to track products, categories, and stock levels in a SQL Server database.

## Objective
Understand what ORM is and how EF Core helps bridge the gap between C# objects and relational tables.

---

## 1. What is ORM (Object-Relational Mapping)?
Object-Relational Mapping (ORM) is a technique that enables developers to query and manipulate data from a database using an object-oriented paradigm.

- **Mapping C# Classes to Database Tables:**
  - C# Classes map to Database Tables (e.g., `Product` class -> `Products` table).
  - Class Properties map to Table Columns (e.g., `Name`, `Price`).
  - Class Instances (objects) map to Table Rows.

- **Key Benefits:**
  - **Productivity:** Eliminates boiler-plate SQL code writing and manual ADO.NET reader parsing.
  - **Maintainability:** Provides strongly-typed data access and compile-time check for queries.
  - **Abstraction:** Abstracts engine-specific SQL dialect; allows switching databases seamlessly.

---

## 2. EF Core vs EF Framework (EF6)
| Feature | Entity Framework Core (EF Core) | Entity Framework 6 (EF6) |
| :--- | :--- | :--- |
| **Platform Support** | Cross-platform (.NET Core, .NET 8/9/10, Windows, Linux, macOS) | Windows-only (.NET Framework) |
| **Architecture** | Lightweight, modular, highly extensible | Legacy, monolithic |
| **Performance** | High performance with compiled models and query optimizations | Slower relative to EF Core |
| **Modern Features** | LINQ, Async queries, Shadow properties, JSON mapping, Bulk operations | Basic LINQ & Async support |

---

## 3. Key EF Core 8.0 Features
- **JSON Column Mapping:** Directly map C# complex objects or owned types to SQL Server `json` columns using `Owned Navigation Types`.
- **Improved Performance with Compiled Models:** Reduces cold-startup time for large data models by pre-compiling model metadata.
- **Interceptors & Bulk Operations:** Intercept database operations and support improved batching and raw SQL bulk updates/deletes.

---

## 4. Setup Steps Executed
1. Console App Creation:
   ```bash
   dotnet new console -n RetailInventory
   cd RetailInventory
   ```
2. Packages Installed:
   ```bash
   dotnet add package Microsoft.EntityFrameworkCore.SqlServer
   dotnet add package Microsoft.EntityFrameworkCore.Design
   dotnet add package Microsoft.EntityFrameworkCore.Tools
   ```
