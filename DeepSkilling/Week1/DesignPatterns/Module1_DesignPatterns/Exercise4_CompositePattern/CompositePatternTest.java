package compositepattern;

/**
 * Test class for Composite Pattern Exercise 4
 * Demonstrates hierarchical file system structure
 */
public class CompositePatternTest {
    public static void main(String[] args) {
        System.out.println("=== Composite Pattern Test ===\n");

        // Create root folder
        Folder root = new Folder("Root");

        // Add files to root
        root.add(new File("File1.txt", 1));
        root.add(new File("Readme.md", 2));

        // Create subfolder1
        Folder subfolder1 = new Folder("SubFolder1");
        subfolder1.add(new File("File2.txt", 2));
        subfolder1.add(new File("File3.doc", 3));

        // Create subfolder2
        Folder subfolder2 = new Folder("SubFolder2");
        subfolder2.add(new File("File4.pdf", 4));
        Folder nestedFolder = new Folder("NestedFolder");
        nestedFolder.add(new File("File5.xlsx", 1));
        subfolder2.add(nestedFolder);

        // Add subfolders to root
        root.add(subfolder1);
        root.add(subfolder2);

        // Display entire structure
        System.out.println("File System Structure:");
        root.display();

        // Display total size
        System.out.println("\nTotal Size: " + root.getSize() + " KB");

        // Test size calculation for specific folder
        System.out.println("SubFolder1 Size: " + subfolder1.getSize() + " KB");
        System.out.println("SubFolder2 Size: " + subfolder2.getSize() + " KB");
    }
}
