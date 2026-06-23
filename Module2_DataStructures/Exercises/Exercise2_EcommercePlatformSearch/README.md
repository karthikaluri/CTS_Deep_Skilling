# Exercise 2: E-commerce Platform Search Function

## Scenario
You are working on the search functionality of an e-commerce platform. The search needs to be optimized for fast performance using appropriate data structures and algorithms.

## Learning Objectives
- Understand Asymptotic Notation (Big O)
- Compare different search algorithms
- Analyze time and space complexity
- Choose optimal algorithms for different use cases

## Steps

### 1. Understand Asymptotic Notation
**Big O Notation** describes how an algorithm's performance scales with input size:
- **O(1)** - Constant time (Hash table lookup)
- **O(log n)** - Logarithmic time (Binary search)
- **O(n)** - Linear time (Simple loop search)
- **O(n log n)** - Linearithmic time (Efficient sorting)
- **O(n²)** - Quadratic time (Nested loops)

### 2. Setup
**Classes:**
- `Product` - Represents an e-commerce product with id, name, price, and quantity
- `EcommerceSearchEngine` - Implements multiple search algorithms

**Data Structures Used:**
- ArrayList - For ordered product list
- HashMap - For O(1) product ID lookup
- Arrays (implicitly sorted) - For binary search

### 3. Implementation
**Search Algorithms Implemented:**

1. **Linear Search (O(n))**
   - Scans through all elements sequentially
   - Suitable for small lists or unsorted data
   - Worst case: searches entire list

2. **Binary Search (O(log n))**
   - Requires sorted data
   - Divides search space in half each iteration
   - Much faster for large datasets

3. **Hash Table Search (O(1))**
   - Uses HashMap for direct product access
   - Fastest method for ID-based lookups
   - Requires minimal space overhead

4. **Range Search (O(n))**
   - Finds all products within price range
   - Must examine all products
   - Example of specialized search patterns

### 4. Analysis

**Performance Comparison (for n = 10 products):**

| Algorithm | Best Case | Average Case | Worst Case | Use Case |
|-----------|-----------|--------------|-----------|----------|
| Linear Search | O(1) | O(n/2) | O(n) | Small lists, unsorted data |
| Binary Search | O(1) | O(log n) | O(log n) | Large sorted datasets |
| Hash Table | O(1) | O(1) | O(1) | ID-based lookups |
| Range Search | O(n) | O(n) | O(n) | Range queries |

**Key Insights:**
- ✓ Hash tables provide fastest lookups for known keys
- ✓ Binary search dramatically improves performance on sorted data
- ✓ Algorithm choice impacts scalability as data grows
- ✓ Space complexity trade-offs must be considered

## Classes

### Product.java
Represents a product in the e-commerce platform with:
- `productId` - Unique identifier
- `name` - Product name
- `price` - Product price
- `quantity` - Stock quantity

### EcommerceSearchEngine.java
Provides multiple search implementations:
- `linearSearchById(int)` - O(n) search by ID
- `binarySearchById(int)` - O(log n) search by ID
- `hashTableSearchById(int)` - O(1) search by ID
- `linearSearchByName(String)` - O(n) search by name
- `priceRangeSearch(double, double)` - O(n) range search

### SearchTest.java
Comprehensive test suite demonstrating:
- Performance of each search algorithm
- Operation count tracking
- Real-world usage scenarios
- Performance comparison

## Output
The program generates `OUTPUT.txt` containing:
- Test results for each search algorithm
- Operation counts
- Asymptotic notation summary
- Performance comparison table
- Best practices and key takeaways

## How to Run
```bash
javac Product.java
javac EcommerceSearchEngine.java
javac SearchTest.java
java SearchTest
```

## Expected Output
See `OUTPUT.txt` for detailed results including operation counts and performance analysis for each search method.

## Complexity Summary
```
Search Algorithm          Time Complexity    Space Complexity
─────────────────────────────────────────────────────────────
Linear Search (ID)        O(n)               O(1)
Binary Search (ID)        O(log n)           O(1)
Hash Table Search (ID)    O(1)               O(n)
Linear Search (Name)      O(n)               O(k) [k = results]
Price Range Search        O(n)               O(k) [k = results]
```

## Real-World Applications
1. **Product Search** - Using hash table for instant ID lookup
2. **Category Browsing** - Linear scan with filters
3. **Price Filtering** - Range search algorithm
4. **Auto-complete** - Could use trie data structure
5. **Recommendation Engine** - Similarity search patterns

## Additional Concepts
- **Trade-offs**: Speed vs Memory usage
- **Data Structure Selection**: Impact on performance
- **Scalability**: How algorithms perform with growing data
- **Optimization Techniques**: Indexing, caching, partitioning
