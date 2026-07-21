# Lab 4: Inserting Initial Data into the Database

## Scenario
The store manager wants to add initial product categories and products to the system.

## Objective
Use EF Core to insert records using `AddRangeAsync` and `SaveChangesAsync`.

---

## Implementation Code (`Program.cs` snippet)

```csharp
using var context = new AppDbContext();

var electronics = new Category { Name = "Electronics" };
var groceries = new Category { Name = "Groceries" };

await context.Categories.AddRangeAsync(electronics, groceries);

var product1 = new Product { Name = "Laptop", Price = 75000, Category = electronics };
var product2 = new Product { Name = "Rice Bag", Price = 1200, Category = groceries };

await context.Products.AddRangeAsync(product1, product2);
await context.SaveChangesAsync();
```

---

## Execution Results

```text
--- Lab 4: Inserting Initial Data ---
Initial categories and products inserted successfully!
```
Rows inserted into SQL Server database `RetailInventoryDb`:
- Category: Electronics (Id: 1)
- Category: Groceries (Id: 2)
- Product: Laptop (Price: ₹75000, CategoryId: 1)
- Product: Rice Bag (Price: ₹1200, CategoryId: 2)
