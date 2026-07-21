# Exercise 7: Financial Forecasting

## Scenario
You are developing a financial forecasting tool that predicts future values based on past data using recursive algorithms and pattern analysis.

## Learning Objectives
- Understand recursive algorithms and their properties
- Apply recursion to financial data analysis
- Compare different recursive patterns and their complexities
- Learn optimization techniques like memoization
- Implement financial forecasting models

## Steps

### 1. Understand Recursive Algorithms
**What is Recursion?**
A function that calls itself to solve a problem by breaking it down into smaller subproblems.

**Key Components:**
- **Base Case** - The termination condition that prevents infinite recursion
- **Recursive Case** - The function calling itself with smaller inputs
- **Progress** - Each recursive call must move toward the base case

**Complexity Classifications:**
- **O(2^n)** - Exponential (avoid in production)
- **O(n²)** - Quadratic 
- **O(n)** - Linear (good performance)
- **O(log n)** - Logarithmic (excellent performance)

### 2. Setup
**Classes:**
- `FinancialData` - Stores historical financial values and statistics
- `FinancialForecaster` - Implements various recursive forecasting algorithms

**Data Structures Used:**
- Arrays - For storing historical and forecasted values
- Memoization array - For caching computed results
- Double arrays - For tracking multiple forecasts

### 3. Implementation

**Recursive Patterns Demonstrated:**

#### 1. **Fibonacci Recursion (Naive) - O(2^n)**
```java
f(n) = f(n-1) + f(n-2)
```
- **Problem**: Recalculates same values exponentially
- **Example**: f(5) requires 15 function calls
- **Use Case**: Educational - avoid in production

#### 2. **Fibonacci with Memoization - O(n)**
```java
f(n) = f(n-1) + f(n-2) with caching
```
- **Solution**: Cache results in array
- **Improvement**: Reduces from O(2^n) to O(n)
- **Trade-off**: Uses O(n) space to save time
- **Pattern Matching**: Find recurring patterns in data

#### 3. **Linear Forecasting - O(n)**
```java
forecast[i] = lastValue + (trend × (i+1))
```
- **Purpose**: Predict linear trends
- **Method**: Calculate trend from historical data
- **Recursively**: Build forecast array one element at a time
- **Use Case**: Steady growth/decline prediction

#### 4. **Exponential Forecasting - O(n)**
```java
forecast[i] = value × (1 + rate)^i
```
- **Purpose**: Model compound growth
- **Formula**: Interest/inflation calculations
- **Recursively**: Apply exponential formula recursively
- **Use Case**: Cryptocurrency, compound interest

#### 5. **Statistical Recursion - O(n)**
- **Sum**: sum[i] = arr[i] + sum[i+1]
- **Variance**: variance = Σ(value - mean)²
- **Both implemented recursively**

### 4. Analysis

**Time Complexity Comparison:**

| Algorithm | Time | Space | Call Count (n=10) | Practical Use |
|-----------|------|-------|-------------------|---------------|
| Naive Fibonacci | O(2^n) | O(n) | 177 | Educational only |
| Memoized Fib | O(n) | O(n) | 19 | Pattern analysis |
| Linear Forecast | O(n) | O(n) | 5+ | Trend prediction |
| Exponential | O(n) | O(n) | 5+ | Growth modeling |
| Recursive Sum | O(n) | O(n) | n | Data aggregation |

**Performance Metrics:**
- Recursion Call Count - How many times function is invoked
- Execution Time - Measured in milliseconds
- Space Complexity - Stack memory used

**Key Insights:**
1. ✓ Naive recursion is inefficient for overlapping subproblems
2. ✓ Memoization transforms exponential to polynomial complexity
3. ✓ Linear and exponential forecasting are O(n) in both versions
4. ✓ Recursion depth affects stack memory usage
5. ✓ Sometimes iteration is better than recursion

## Classes

### FinancialData.java
Represents historical financial data:
- `historicalValues` - Array of past values
- `dataLabel` - Description of data
- Methods: getMax(), getMin(), getAverage()

### FinancialForecaster.java
Implements recursive forecasting algorithms:
- `fibonacciForecasting(int)` - O(2^n) Fibonacci
- `fibonacciMemoized(int)` - O(n) optimized Fibonacci
- `linearForecastRecursive()` - O(n) linear trend
- `exponentialForecastRecursive()` - O(n) exponential growth
- `sumRecursive()` - O(n) recursive sum
- `varianceRecursive()` - O(n) statistical variance

### FinancialForecastingTest.java
Comprehensive test suite with:
- Fibonacci comparison (naive vs memoized)
- Linear and exponential forecasting
- Statistical calculations
- Performance analysis
- Detailed output with recursion metrics

## Output
Generates `OUTPUT.txt` containing:
- Historical data analysis
- Forecast predictions for multiple models
- Recursion call counts and execution times
- Complexity analysis summary
- Comparison tables
- Best practices and recommendations

## How to Run
```bash
javac FinancialData.java
javac FinancialForecaster.java
javac FinancialForecastingTest.java
java FinancialForecastingTest
```

## Expected Output
See `OUTPUT.txt` for:
- Detailed test results
- Recursion metrics and call counts
- Performance comparisons
- Analysis summary

## Complexity Summary

### Recursion Depth Analysis
```
Algorithm                Depth    Max Stack Depth
─────────────────────────────────────────────────
Fibonacci (Naive)        n        O(n)
Fibonacci (Memoized)     n        O(n)
Linear Forecast          n        O(n)
Exponential Forecast     n        O(n)
Sum Recursive            n        O(n)
```

### Call Count Comparison
```
Fibonacci(10):
- Naive:     177 calls
- Memoized:  19 calls
- Difference: 89% reduction

Fibonacci(15):
- Naive:     1,973 calls
- Memoized:  29 calls
- Difference: 98.5% reduction
```

## Real-World Applications

1. **Stock Price Prediction**
   - Linear: Steady uptrend/downtrend
   - Exponential: Volatile markets

2. **Compound Interest**
   - Formula: A = P(1+r)^t
   - Recursive implementation models iterative growth

3. **Pattern Recognition**
   - Fibonacci patterns appear in markets
   - Use memoization for efficiency

4. **Risk Analysis**
   - Variance/std deviation calculations
   - Recursive aggregation of data

5. **Seasonal Forecasting**
   - Recursive trend analysis
   - Multi-period predictions

## Important Concepts

### Memoization Benefits
```
Problem: f(5) = f(4) + f(3)
         f(4) = f(3) + f(2)
         f(3) is recalculated!

Solution: Store f(3) result, reuse it
Result: Exponential → Polynomial complexity
```

### Recursion vs Iteration
- **Recursion**: More elegant, harder to debug, stack overhead
- **Iteration**: More efficient, less elegant, easier to understand
- **Memoization**: Best of both - elegant + efficient

### Stack Overflow Prevention
- Monitor recursion depth
- Convert to iteration for deep recursion
- Use memoization to reduce depth

## Advanced Topics

1. **Dynamic Programming**
   - Extension of memoization
   - Build solutions bottom-up
   - Eliminates recursion overhead

2. **Tail Recursion**
   - Last operation is recursive call
   - Can be optimized by compiler
   - Reduces stack overhead

3. **Mutual Recursion**
   - Function A calls B, B calls A
   - Complex but powerful pattern

4. **Divide and Conquer**
   - Merge Sort, Quick Sort use this
   - Recursive decomposition strategy

## Lessons Learned
- ✓ Recursion elegant but can be expensive
- ✓ Always consider memoization for repeated subproblems
- ✓ Profile before optimizing
- ✓ Sometimes iteration is better choice
- ✓ Understanding complexity is crucial
