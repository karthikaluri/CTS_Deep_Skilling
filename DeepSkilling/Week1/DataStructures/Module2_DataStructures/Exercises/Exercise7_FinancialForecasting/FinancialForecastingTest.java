import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;

/**
 * Test class for Financial Forecasting using Recursive Algorithms
 * Demonstrates various recursive patterns for financial prediction
 */
public class FinancialForecastingTest {
    public static void main(String[] args) {
        try (FileWriter writer = new FileWriter("OUTPUT.txt")) {
            writer.write("=== FINANCIAL FORECASTING WITH RECURSIVE ALGORITHMS ===\n");
            writer.write("Understanding Recursion in Financial Analysis\n");
            writer.write("================================================\n\n");

            // Create sample financial data
            FinancialData stockData = createStockPriceData();
            FinancialData cryptoData = createCryptoPriceData();
            FinancialForecaster forecaster = new FinancialForecaster();

            // Display input data
            writer.write("INPUT DATA:\n");
            writer.write("-----------\n");
            writer.write(stockData.toString() + "\n");
            writer.write("  Min: $" + String.format("%.2f", stockData.getMin()) + "\n");
            writer.write("  Max: $" + String.format("%.2f", stockData.getMax()) + "\n");
            writer.write("  Average: $" + String.format("%.2f", stockData.getAverage()) + "\n\n");

            writer.write(cryptoData.toString() + "\n");
            writer.write("  Min: $" + String.format("%.2f", cryptoData.getMin()) + "\n");
            writer.write("  Max: $" + String.format("%.2f", cryptoData.getMax()) + "\n");
            writer.write("  Average: $" + String.format("%.2f", cryptoData.getAverage()) + "\n\n");

            // Test 1: Fibonacci Forecasting - Naive Recursion
            writer.write("TEST 1: Fibonacci Forecasting (Naive Recursion) - O(2^n)\n");
            writer.write("-------------------------------------------------------\n");
            testFibonacciNaive(writer, forecaster);
            writer.write("\n");

            // Test 2: Fibonacci with Memoization
            writer.write("TEST 2: Fibonacci Forecasting (Memoized Recursion) - O(n)\n");
            writer.write("-------------------------------------------------------\n");
            testFibonacciMemoized(writer, forecaster);
            writer.write("\n");

            // Test 3: Linear Forecasting
            writer.write("TEST 3: Linear Forecasting (Trend-based) - O(n)\n");
            writer.write("-----------------------------------------------\n");
            testLinearForecasting(writer, forecaster, stockData);
            writer.write("\n");

            // Test 4: Exponential Forecasting
            writer.write("TEST 4: Exponential Forecasting (Growth-based) - O(n)\n");
            writer.write("----------------------------------------------------\n");
            testExponentialForecasting(writer, forecaster, cryptoData);
            writer.write("\n");

            // Test 5: Recursive Sum and Variance
            writer.write("TEST 5: Statistical Analysis using Recursion\n");
            writer.write("--------------------------------------------\n");
            testStatisticalAnalysis(writer, forecaster, stockData);
            writer.write("\n");

            // Recursion Analysis Summary
            writer.write("RECURSIVE ALGORITHM ANALYSIS\n");
            writer.write("============================\n");
            writer.write("1. Fibonacci (Naive):      O(2^n) - Exponential\n");
            writer.write("   - Base case: n <= 1\n");
            writer.write("   - Recursive case: f(n) = f(n-1) + f(n-2)\n");
            writer.write("   - Problem: Multiple redundant calculations\n\n");

            writer.write("2. Fibonacci (Memoized):   O(n) - Linear\n");
            writer.write("   - Same recursion with caching\n");
            writer.write("   - Eliminates redundant calculations\n");
            writer.write("   - Trade-off: Time for Space\n\n");

            writer.write("3. Linear Forecasting:     O(n) - Linear\n");
            writer.write("   - Recursive pattern: forecast[i] depends on previous value + trend\n");
            writer.write("   - Real-world: Trend analysis for financial markets\n\n");

            writer.write("4. Exponential Forecasting: O(n) - Linear\n");
            writer.write("   - Recursive pattern: forecast[i] = value * (1+rate)^i\n");
            writer.write("   - Models compound growth/interest\n\n");

            writer.write("5. Statistical Recursion: O(n) - Linear\n");
            writer.write("   - Sum: sum(i) = arr[i] + sum(i+1)\n");
            writer.write("   - Variance: accumulated squared differences\n\n");

            // Key Concepts
            writer.write("RECURSIVE ALGORITHM PATTERNS\n");
            writer.write("============================\n");
            writer.write("Pattern 1: Base Case + Recursive Case\n");
            writer.write("  - Must have termination condition\n");
            writer.write("  - Each call reduces problem size\n\n");

            writer.write("Pattern 2: Divide and Conquer\n");
            writer.write("  - Split problem into smaller subproblems\n");
            writer.write("  - Solve recursively\n");
            writer.write("  - Combine results\n\n");

            writer.write("Pattern 3: Backtracking\n");
            writer.write("  - Explore all possibilities\n");
            writer.write("  - Undo choices (backtrack) when needed\n\n");

            writer.write("Pattern 4: Memoization (Dynamic Programming)\n");
            writer.write("  - Cache results of subproblems\n");
            writer.write("  - Avoid recalculating same values\n");
            writer.write("  - Transforms O(2^n) to O(n)\n\n");

            // Complexity Comparison
            writer.write("COMPLEXITY COMPARISON TABLE\n");
            writer.write("===========================\n");
            writer.write(String.format("%-30s %-15s %-15s %-15s\n", 
                    "Algorithm", "Time", "Space", "Real-world Use"));
            writer.write("─".repeat(75) + "\n");
            writer.write(String.format("%-30s %-15s %-15s %-15s\n", 
                    "Fibonacci (Naive)", "O(2^n)", "O(n)", "None (avoid)"));
            writer.write(String.format("%-30s %-15s %-15s %-15s\n", 
                    "Fibonacci (Memoized)", "O(n)", "O(n)", "Pattern analysis"));
            writer.write(String.format("%-30s %-15s %-15s %-15s\n", 
                    "Linear Forecast", "O(n)", "O(n)", "Trend prediction"));
            writer.write(String.format("%-30s %-15s %-15s %-15s\n", 
                    "Exponential Forecast", "O(n)", "O(n)", "Compound growth"));
            writer.write(String.format("%-30s %-15s %-15s %-15s\n", 
                    "Recursive Sum", "O(n)", "O(n)", "Data aggregation"));
            writer.write("\n");

            // Best Practices
            writer.write("RECURSION BEST PRACTICES\n");
            writer.write("========================\n");
            writer.write("1. Always define base case(s) to prevent infinite recursion\n");
            writer.write("2. Ensure recursive case makes progress toward base case\n");
            writer.write("3. Consider stack overflow for deep recursion (convert to iteration if needed)\n");
            writer.write("4. Use memoization to optimize repeated calculations\n");
            writer.write("5. Analyze time complexity carefully - recursion can be expensive\n");
            writer.write("6. Profile recursive algorithms before deployment\n");
            writer.write("7. Consider iterative alternatives for better performance\n");

            System.out.println("Test completed! Output written to OUTPUT.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void testFibonacciNaive(FileWriter writer, FinancialForecaster forecaster) throws IOException {
        writer.write("  Testing Fibonacci(15) with naive recursion:\n");
        long startTime = System.nanoTime();
        double result = forecaster.fibonacciForecasting(15);
        long duration = System.nanoTime() - startTime;
        
        writer.write("  Result: " + (int)result + "\n");
        writer.write("  Recursion Calls: " + forecaster.getRecursionCallCount() + "\n");
        writer.write("  Time: " + forecaster.getRecursionTimeMs() + "\n");
        writer.write("  Analysis: Very slow due to repeated calculations\n");
        writer.write("  - F(15) requires " + forecaster.getRecursionCallCount() + " function calls\n");
        writer.write("  - Same values computed multiple times\n");
    }

    private static void testFibonacciMemoized(FileWriter writer, FinancialForecaster forecaster) throws IOException {
        writer.write("  Testing Fibonacci(15) with memoization:\n");
        long startTime = System.nanoTime();
        double result = forecaster.fibonacciMemoized(15);
        long duration = System.nanoTime() - startTime;
        
        writer.write("  Result: " + (int)result + "\n");
        writer.write("  Recursion Calls: " + forecaster.getRecursionCallCount() + "\n");
        writer.write("  Time: " + forecaster.getRecursionTimeMs() + "\n");
        writer.write("  Analysis: Much faster with caching\n");
        writer.write("  - Each value computed only once\n");
        writer.write("  - Results cached for reuse\n");
        writer.write("  - Dramatic performance improvement\n");
    }

    private static void testLinearForecasting(FileWriter writer, FinancialForecaster forecaster, 
                                              FinancialData data) throws IOException {
        writer.write("  Forecasting next 5 periods based on trend:\n");
        double[] forecast = forecaster.linearForecastRecursive(data, 5);
        
        writer.write("  Last known value: $" + String.format("%.2f", 
                data.getHistoricalValues()[data.getSize() - 1]) + "\n");
        writer.write("  Forecast: ");
        for (double value : forecast) {
            writer.write("$" + String.format("%.2f", value) + " ");
        }
        writer.write("\n");
        writer.write("  Recursion calls: " + forecaster.getRecursionCallCount() + "\n");
        writer.write("  Time complexity: O(n) where n = 5\n");
    }

    private static void testExponentialForecasting(FileWriter writer, FinancialForecaster forecaster,
                                                    FinancialData data) throws IOException {
        writer.write("  Forecasting exponential growth (10% annual rate):\n");
        double[] forecast = forecaster.exponentialForecastRecursive(data, 5, 0.10);
        
        writer.write("  Last known value: $" + String.format("%.2f", 
                data.getHistoricalValues()[data.getSize() - 1]) + "\n");
        writer.write("  Forecast (10% growth): ");
        for (double value : forecast) {
            writer.write("$" + String.format("%.2f", value) + " ");
        }
        writer.write("\n");
        writer.write("  Recursion calls: " + forecaster.getRecursionCallCount() + "\n");
        writer.write("  Formula: V * (1 + r)^t where r=0.10\n");
    }

    private static void testStatisticalAnalysis(FileWriter writer, FinancialForecaster forecaster,
                                                 FinancialData data) throws IOException {
        writer.write("  Recursive Sum calculation:\n");
        double sum = forecaster.sumRecursive(data.getHistoricalValues());
        writer.write("  Sum: $" + String.format("%.2f", sum) + "\n");
        writer.write("  Recursion calls: " + forecaster.getRecursionCallCount() + "\n");
        writer.write("  Time complexity: O(n)\n\n");

        writer.write("  Recursive Variance calculation:\n");
        double variance = forecaster.varianceRecursive(data);
        double stdDev = Math.sqrt(variance / data.getSize());
        writer.write("  Variance: " + String.format("%.4f", variance / data.getSize()) + "\n");
        writer.write("  Std Deviation: $" + String.format("%.2f", stdDev) + "\n");
        writer.write("  Recursion calls: " + forecaster.getRecursionCallCount() + "\n");
    }

    private static FinancialData createStockPriceData() {
        double[] prices = {100.50, 102.30, 101.80, 105.20, 107.50, 106.80, 108.90, 110.25, 109.75, 112.40};
        return new FinancialData(prices, "Stock Prices (Past 10 Days)");
    }

    private static FinancialData createCryptoPriceData() {
        double[] prices = {45000, 46500, 47200, 48100, 49500, 51000, 52800, 54200, 56100, 58500};
        return new FinancialData(prices, "Cryptocurrency Prices (Past 10 Days)");
    }
}
