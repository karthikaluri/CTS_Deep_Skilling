package compositepattern;

import java.util.ArrayList;
import java.util.List;

/**
 * Folder class - Composite component in Composite pattern
 * Represents folders that can contain files and other folders
 */
public class Folder implements FileSystemComponent {
    private String name;
    private List<FileSystemComponent> children;

    public Folder(String name) {
        this.name = name;
        this.children = new ArrayList<>();
    }

    public void add(FileSystemComponent component) {
        children.add(component);
    }

    public void remove(FileSystemComponent component) {
        children.remove(component);
    }

    @Override
    public void display() {
        display("");
    }

    @Override
    public void display(String prefix) {
        System.out.println(prefix + name + "/");
        for (int i = 0; i < children.size(); i++) {
            FileSystemComponent child = children.get(i);
            String childPrefix = prefix + "  ";
            child.display(childPrefix);
        }
    }

    @Override
    public long getSize() {
        long totalSize = 0;
        for (FileSystemComponent child : children) {
            totalSize += child.getSize();
        }
        return totalSize;
    }

    @Override
    public String getName() {
        return name;
    }
}
