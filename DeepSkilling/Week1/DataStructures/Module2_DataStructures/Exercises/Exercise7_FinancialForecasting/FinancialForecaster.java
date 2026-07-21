/**
 * FinancialForecaster class implementing recursive algorithms
 * for predicting future financial values based on historical data
 */
public class FinancialForecaster {
    private long recursionCallCount;
    private long recursionTime;

    public FinancialForecaster() {
        this.recursionCallCount = 0;
        this.recursionTime = 0;
    }

    /**
     * Fibonacci-based forecasting using recursion
     * Demonstrates recursive nature of pattern matching
     * Time Complexity: O(2^n) - exponential, inefficient
     */
    public double fibonacciForecasting(int periods) {
        recursionCallCount = 0;
        long startTime = System.nanoTime();
        double result = fibonacciRecursive(periods);
        recursionTime = System.nanoTime() - startTime;
        return result;
    }

    private double fibonacciRecursive(int n) {
        recursionCallCount++;
        if (n <= 1) {
            return n;
        }
        return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2);
    }

    /**
     * Optimized Fibonacci using recursion with memoization
     * Time Complexity: O(n) - polynomial, efficient
     */
    public double fibonacciMemoized(int periods) {
        recursionCallCount = 0;
        long startTime = System.nanoTime();
        double[] memo = new double[periods + 1];
        for (int i = 0; i <= periods; i++) {
            memo[i] = -1;
        }
        double result = fibonacciMemo(periods, memo);
        recursionTime = System.nanoTime() - startTime;
        return result;
    }

    private double fibonacciMemo(int n, double[] memo) {
        recursionCallCount++;
        if (n <= 1) {
            return n;
        }
        if (memo[n] != -1) {
            return memo[n];
        }
        memo[n] = fibonacciMemo(n - 1, memo) + fibonacciMemo(n - 2, memo);
        return memo[n];
    }

    /**
     * Linear forecasting using recursive pattern analysis
     * Calculates moving average using recursion
     * Time Complexity: O(n)
     */
    public double[] linearForecastRecursive(FinancialData data, int periods) {
        recursionCallCount = 0;
        long startTime = System.nanoTime();
        
        double[] forecast = new double[periods];
        double lastValue = data.getHistoricalValues()[data.getSize() - 1];
        double average = data.getAverage();
        double trend = calculateTrendRecursive(data.getHistoricalValues(), 
                                              data.getSize() - 1);
        
        fillForecastRecursive(forecast, 0, periods, lastValue, trend);
        
        recursionTime = System.nanoTime() - startTime;
        return forecast;
    }

    private void fillForecastRecursive(double[] forecast, int index, int periods, 
                                       double lastValue, double trend) {
        recursionCallCount++;
        if (index >= periods) {
            return;
        }
        forecast[index] = lastValue + (trend * (index + 1));
        fillForecastRecursive(forecast, index + 1, periods, lastValue, trend);
    }

    /**
     * Calculate trend recursively
     * Time Complexity: O(n)
     */
    private double calculateTrendRecursive(double[] values, int index) {
        recursionCallCount++;
        if (index <= 0) {
            return 0;
        }
        double difference = values[index] - values[index - 1];
        double previousTrend = calculateTrendRecursive(values, index - 1);
        return (difference + previousTrend) / 2;
    }

    /**
     * Exponential growth forecasting using recursion
     * Models exponential growth pattern
     * Time Complexity: O(n)
     */
    public double[] exponentialForecastRecursive(FinancialData data, int periods, 
                                                 double growthRate) {
        recursionCallCount = 0;
        long startTime = System.nanoTime();
        
        double[] forecast = new double[periods];
        double lastValue = data.getHistoricalValues()[data.getSize() - 1];
        
        fillExponentialRecursive(forecast, 0, periods, lastValue, growthRate);
        
        recursionTime = System.nanoTime() - startTime;
        return forecast;
    }

    private void fillExponentialRecursive(double[] forecast, int period, int periods,
                                          double lastValue, double growthRate) {
        recursionCallCount++;
        if (period >= periods) {
            return;
        }
        forecast[period] = lastValue * Math.pow(1 + growthRate, period + 1);
        fillExponentialRecursive(forecast, period + 1, periods, lastValue, growthRate);
    }

    /**
     * Sum of values using recursion
     * Time Complexity: O(n)
     */
    public double sumRecursive(double[] values) {
        recursionCallCount = 0;
        return sumRecursiveHelper(values, 0);
    }

    private double sumRecursiveHelper(double[] values, int index) {
        recursionCallCount++;
        if (index >= values.length) {
            return 0;
        }
        return values[index] + sumRecursiveHelper(values, index + 1);
    }

    /**
     * Calculate variance recursively
     * Time Complexity: O(n)
     */
    public double varianceRecursive(FinancialData data) {
        double mean = data.getAverage();
        recursionCallCount = 0;
        return varianceHelper(data.getHistoricalValues(), 0, mean);
    }

    private double varianceHelper(double[] values, int index, double mean) {
        recursionCallCount++;
        if (index >= values.length) {
            return 0;
        }
        double diff = values[index] - mean;
        return (diff * diff + varianceHelper(values, index + 1, mean));
    }

    public long getRecursionCallCount() {
        return recursionCallCount;
    }

    public long getRecursionTime() {
        return recursionTime;
    }

    public String getRecursionTimeMs() {
        return String.format("%.4f", recursionTime / 1_000_000.0) + " ms";
    }
}
