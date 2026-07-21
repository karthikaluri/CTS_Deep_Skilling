using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RetailInventory.Data;
using RetailInventory.Models;

namespace RetailInventory
{
    class Program
    {
        static async Task Main(string[] args)
        {
            Console.WriteLine("=================================================");
            Console.WriteLine("  EF Core 8.0 Hands-On Lab: Retail Inventory");
            Console.WriteLine("=================================================\n");

            using var context = new AppDbContext();

            // Lab 4: Inserting Initial Data into the Database
            Console.WriteLine("--- Lab 4: Inserting Initial Data ---");

            // Check if categories already exist before seeding to avoid duplicates
            if (!await context.Categories.AnyAsync())
            {
                var electronics = new Category { Name = "Electronics" };
                var groceries = new Category { Name = "Groceries" };

                await context.Categories.AddRangeAsync(electronics, groceries);

                var product1 = new Product { Name = "Laptop", Price = 75000, Category = electronics };
                var product2 = new Product { Name = "Rice Bag", Price = 1200, Category = groceries };

                await context.Products.AddRangeAsync(product1, product2);
                await context.SaveChangesAsync();

                Console.WriteLine("Initial categories and products inserted successfully!\n");
            }
            else
            {
                Console.WriteLine("Initial data already present in database.\n");
            }

            // Lab 5: Retrieving Data from the Database
            Console.WriteLine("--- Lab 5: Retrieving Data from the Database ---");

            // 1. Retrieve All Products
            Console.WriteLine("\n1. All Products:");
            var products = await context.Products.ToListAsync();
            foreach (var p in products)
            {
                Console.WriteLine($"   {p.Name} - ₹{p.Price}");
            }

            // 2. Find by ID
            Console.WriteLine("\n2. Find Product by ID (ID = 1):");
            var product = await context.Products.FindAsync(1);
            Console.WriteLine($"   Found: {product?.Name}");

            // 3. FirstOrDefault with Condition
            Console.WriteLine("\n3. FirstOrDefault with Condition (Price > 50000):");
            var expensive = await context.Products.FirstOrDefaultAsync(p => p.Price > 50000);
            Console.WriteLine($"   Expensive: {expensive?.Name}");

            Console.WriteLine("\n=================================================");
            Console.WriteLine("  Lab Execution Completed Successfully!");
            Console.WriteLine("=================================================");
        }
    }
}
