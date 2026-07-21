import java.util.HashMap;
import java.util.Map;

public class InventoryManager {
    private final Map<String, InventoryItem> inventory;

    public InventoryManager() {
        this.inventory = new HashMap<>();
    }

    public void addItem(InventoryItem item) {
        inventory.put(item.getItemId(), item);
    }

    public InventoryItem getItem(String itemId) {
        return inventory.get(itemId);
    }

    public void updateQuantity(String itemId, int newQuantity) {
        InventoryItem item = inventory.get(itemId);
        if (item != null) {
            item.setQuantity(newQuantity);
        }
    }

    public void removeItem(String itemId) {
        inventory.remove(itemId);
    }

    public void printInventory() {
        System.out.println("Inventory List:");
        inventory.values().forEach(System.out::println);
    }
}
