import java.util.*;

/**
 * E-commerce Search Engine demonstrating different search algorithms
 * and their asymptotic time complexity (Big O notation)
 */
public class EcommerceSearchEngine {
    private List<Product> products;
    private Map<Integer, Product> productMap;
    private long operationCount;

    public EcommerceSearchEngine(List<Product> products) {
        this.products = new ArrayList<>(products);
        this.productMap = new HashMap<>();
        this.operationCount = 0;

        for (Product p : products) {
            productMap.put(p.getProductId(), p);
        }
    }

    /**
     * Linear Search - O(n) time complexity
     * Searches through unsorted list sequentially
     */
    public Product linearSearchById(int productId) {
        operationCount = 0;
        for (Product product : products) {
            operationCount++;
            if (product.getProductId() == productId) {
                return product;
            }
        }
        return null;
    }

    /**
     * Binary Search - O(log n) time complexity
     * Requires sorted list for optimal performance
     */
    public Product binarySearchById(int productId) {
        operationCount = 0;
        List<Product> sortedProducts = new ArrayList<>(products);
        Collections.sort(sortedProducts);

        int left = 0, right = sortedProducts.size() - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            operationCount++;
            
            int midId = sortedProducts.get(mid).getProductId();
            if (midId == productId) {
                return sortedProducts.get(mid);
            } else if (midId < productId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }

    /**
     * Hash Table Search - O(1) average time complexity
     * Fastest search method for random access
     */
    public Product hashTableSearchById(int productId) {
        operationCount = 1;
        return productMap.get(productId);
    }

    /**
     * Linear Search by Name - O(n) time complexity
     */
    public List<Product> linearSearchByName(String name) {
        operationCount = 0;
        List<Product> results = new ArrayList<>();
        for (Product product : products) {
            operationCount++;
            if (product.getName().toLowerCase().contains(name.toLowerCase())) {
                results.add(product);
            }
        }
        return results;
    }

    /**
     * Range Search - O(n) time complexity
     * Finds all products within a price range
     */
    public List<Product> priceRangeSearch(double minPrice, double maxPrice) {
        operationCount = 0;
        List<Product> results = new ArrayList<>();
        for (Product product : products) {
            operationCount++;
            if (product.getPrice() >= minPrice && product.getPrice() <= maxPrice) {
                results.add(product);
            }
        }
        return results;
    }

    public long getOperationCount() {
        return operationCount;
    }

    public int getTotalProducts() {
        return products.size();
    }
}
