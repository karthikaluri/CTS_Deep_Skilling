/**
 * FinancialData class representing historical financial data
 * Used for demonstrating recursive algorithms in financial forecasting
 */
public class FinancialData {
    private double[] historicalValues;
    private String dataLabel;

    public FinancialData(double[] values, String label) {
        this.historicalValues = values.clone();
        this.dataLabel = label;
    }

    public double[] getHistoricalValues() {
        return historicalValues;
    }

    public String getDataLabel() {
        return dataLabel;
    }

    public int getSize() {
        return historicalValues.length;
    }

    public double getValue(int index) {
        if (index >= 0 && index < historicalValues.length) {
            return historicalValues[index];
        }
        return -1;
    }

    public double getMax() {
        double max = historicalValues[0];
        for (double value : historicalValues) {
            if (value > max) {
                max = value;
            }
        }
        return max;
    }

    public double getMin() {
        double min = historicalValues[0];
        for (double value : historicalValues) {
            if (value < min) {
                min = value;
            }
        }
        return min;
    }

    public double getAverage() {
        double sum = 0;
        for (double value : historicalValues) {
            sum += value;
        }
        return sum / historicalValues.length;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(dataLabel).append(": [");
        for (int i = 0; i < historicalValues.length; i++) {
            sb.append(String.format("%.2f", historicalValues[i]));
            if (i < historicalValues.length - 1) {
                sb.append(", ");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}
