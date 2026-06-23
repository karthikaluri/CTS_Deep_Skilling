import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Test class for E-commerce Search Engine
 * Demonstrates performance differences between search algorithms
 * using asymptotic notation analysis
 */
public class SearchTest {
    public static void main(String[] args) {
        try (FileWriter writer = new FileWriter("OUTPUT.txt")) {
            // Create sample products
            List<Product> products = createSampleProducts();
            EcommerceSearchEngine engine = new EcommerceSearchEngine(products);

            writer.write("=== E-COMMERCE PLATFORM SEARCH FUNCTION ===\n");
            writer.write("Asymptotic Notation Analysis\n");
            writer.write("=====================================\n\n");

            // Display all products
            writer.write("Total Products in Database: " + engine.getTotalProducts() + "\n");
            writer.write("Sample Products:\n");
            for (int i = 0; i < Math.min(5, products.size()); i++) {
                writer.write("  " + products.get(i) + "\n");
            }
            writer.write("\n");

            // Test 1: Search by ID - Linear Search O(n)
            writer.write("TEST 1: Linear Search by ID - O(n)\n");
            writer.write("-----------------------------------\n");
            testLinearSearch(engine, writer, 103);
            testLinearSearch(engine, writer, 999);
            writer.write("\n");

            // Test 2: Search by ID - Binary Search O(log n)
            writer.write("TEST 2: Binary Search by ID - O(log n)\n");
            writer.write("--------------------------------------\n");
            testBinarySearch(engine, writer, 103);
            testBinarySearch(engine, writer, 999);
            writer.write("\n");

            // Test 3: Search by ID - Hash Table Search O(1)
            writer.write("TEST 3: Hash Table Search by ID - O(1)\n");
            writer.write("--------------------------------------\n");
            testHashSearch(engine, writer, 103);
            testHashSearch(engine, writer, 999);
            writer.write("\n");

            // Test 4: Search by Name - O(n)
            writer.write("TEST 4: Linear Search by Name - O(n)\n");
            writer.write("------------------------------------\n");
            testNameSearch(engine, writer, "Laptop");
            testNameSearch(engine, writer, "Phone");
            writer.write("\n");

            // Test 5: Range Search - O(n)
            writer.write("TEST 5: Price Range Search - O(n)\n");
            writer.write("--------------------------------\n");
            testRangeSearch(engine, writer, 500, 1500);
            testRangeSearch(engine, writer, 50, 300);
            writer.write("\n");

            // Complexity Analysis Summary
            writer.write("ASYMPTOTIC NOTATION SUMMARY\n");
            writer.write("==========================\n");
            writer.write("1. Linear Search by ID:       O(n) - compares up to n elements\n");
            writer.write("2. Binary Search by ID:       O(log n) - divides search space by 2\n");
            writer.write("3. Hash Table Search by ID:   O(1) - direct access via hash map\n");
            writer.write("4. Linear Search by Name:     O(n) - checks all products\n");
            writer.write("5. Range Search:              O(n) - scans entire list\n\n");

            writer.write("PERFORMANCE COMPARISON (for n = " + engine.getTotalProducts() + "):\n");
            writer.write("- Linear Search: up to " + engine.getTotalProducts() + " operations\n");
            writer.write("- Binary Search: up to " + (int)Math.ceil(Math.log(engine.getTotalProducts()) / Math.log(2)) + " operations\n");
            writer.write("- Hash Table Search: 1 operation\n\n");

            writer.write("KEY TAKEAWAYS:\n");
            writer.write("✓ Choose appropriate data structures based on access patterns\n");
            writer.write("✓ Hash tables offer O(1) search for key-based lookups\n");
            writer.write("✓ Binary search requires sorted data but improves from O(n) to O(log n)\n");
            writer.write("✓ Understand trade-offs between space and time complexity\n");

            System.out.println("Test completed! Output written to OUTPUT.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void testLinearSearch(EcommerceSearchEngine engine, FileWriter writer, int productId) throws IOException {
        Product result = engine.linearSearchById(productId);
        writer.write("  Searching for Product ID: " + productId + "\n");
        writer.write("  Operations: " + engine.getOperationCount() + "\n");
        writer.write("  Result: " + (result != null ? result : "Not Found") + "\n");
    }

    private static void testBinarySearch(EcommerceSearchEngine engine, FileWriter writer, int productId) throws IOException {
        Product result = engine.binarySearchById(productId);
        writer.write("  Searching for Product ID: " + productId + "\n");
        writer.write("  Operations: " + engine.getOperationCount() + "\n");
        writer.write("  Result: " + (result != null ? result : "Not Found") + "\n");
    }

    private static void testHashSearch(EcommerceSearchEngine engine, FileWriter writer, int productId) throws IOException {
        Product result = engine.hashTableSearchById(productId);
        writer.write("  Searching for Product ID: " + productId + "\n");
        writer.write("  Operations: " + engine.getOperationCount() + "\n");
        writer.write("  Result: " + (result != null ? result : "Not Found") + "\n");
    }

    private static void testNameSearch(EcommerceSearchEngine engine, FileWriter writer, String name) throws IOException {
        List<Product> results = engine.linearSearchByName(name);
        writer.write("  Searching for Name: '" + name + "'\n");
        writer.write("  Operations: " + engine.getOperationCount() + "\n");
        writer.write("  Results Found: " + results.size() + "\n");
        for (Product p : results) {
            writer.write("    - " + p + "\n");
        }
    }

    private static void testRangeSearch(EcommerceSearchEngine engine, FileWriter writer, double minPrice, double maxPrice) throws IOException {
        List<Product> results = engine.priceRangeSearch(minPrice, maxPrice);
        writer.write("  Price Range: $" + minPrice + " - $" + maxPrice + "\n");
        writer.write("  Operations: " + engine.getOperationCount() + "\n");
        writer.write("  Products Found: " + results.size() + "\n");
        for (Product p : results) {
            writer.write("    - " + p + "\n");
        }
    }

    private static List<Product> createSampleProducts() {
        List<Product> products = new ArrayList<>();
        products.add(new Product(101, "Laptop", 999.99, 15));
        products.add(new Product(102, "Desktop Computer", 1299.99, 8));
        products.add(new Product(103, "Smartphone", 599.99, 50));
        products.add(new Product(104, "Tablet", 399.99, 25));
        products.add(new Product(105, "Wireless Mouse", 49.99, 100));
        products.add(new Product(106, "Mechanical Keyboard", 129.99, 40));
        products.add(new Product(107, "Monitor 27-inch", 299.99, 20));
        products.add(new Product(108, "Headphones", 199.99, 60));
        products.add(new Product(109, "USB-C Cable", 19.99, 200));
        products.add(new Product(110, "Laptop Stand", 79.99, 35));
        return products;
    }
}
