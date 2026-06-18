package compositepattern;

/**
 * File class - Leaf component in Composite pattern
 * Represents individual files in the file system
 */
public class File implements FileSystemComponent {
    private String name;
    private long size; // in KB

    public File(String name, long size) {
        this.name = name;
        this.size = size;
    }

    @Override
    public void display() {
        display("");
    }

    @Override
    public void display(String prefix) {
        System.out.println(prefix + "├── " + name + " (" + size + " KB)");
    }

    @Override
    public long getSize() {
        return size;
    }

    @Override
    public String getName() {
        return name;
    }
}
