package compositepattern;

/**
 * FileSystemComponent Interface
 * Represents both files and folders in a uniform way
 */
public interface FileSystemComponent {
    void display();
    void display(String prefix);
    long getSize();
    String getName();
}
