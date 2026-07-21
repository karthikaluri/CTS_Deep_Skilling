public class InventoryTest {
    public static void main(String[] args) {
        InventoryManager manager = new InventoryManager();

        InventoryItem item1 = new InventoryItem("A001", "Keyboard", 15, 29.99);
        InventoryItem item2 = new InventoryItem("A002", "Mouse", 30, 14.99);
        InventoryItem item3 = new InventoryItem("A003", "HDMI Cable", 50, 9.99);

        manager.addItem(item1);
        manager.addItem(item2);
        manager.addItem(item3);

        manager.printInventory();

        System.out.println("\nUpdating quantity for A002 to 25...");
        manager.updateQuantity("A002", 25);
        System.out.println(manager.getItem("A002"));

        System.out.println("\nRemoving item A003...");
        manager.removeItem("A003");
        manager.printInventory();
    }
}
