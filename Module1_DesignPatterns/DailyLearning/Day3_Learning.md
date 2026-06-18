# Day 3 Learning Log - Design Patterns Exercises 3 & 4

**Date**: 2026-06-18 (Planned)  
**Module**: Design Patterns and Principles - Exercises Phase  
**Status**: CATCH-UP MODE - Completing Module 1

## Topics to Cover
1. **Exercise 3: Builder Pattern** (Creational)
2. **Exercise 4: Composite Pattern** (Structural)
3. **Module 1 Completion & Review**

## Learning Objectives for Today

### Builder Pattern (Exercise 3)
- [ ] Understand problem it solves (complex object construction)
- [ ] Implement step-by-step object building
- [ ] Create fluent API for better readability
- [ ] Test with multiple configurations

### Composite Pattern (Exercise 4)
- [ ] Understand tree structures
- [ ] Implement component interface
- [ ] Create leaf and composite classes
- [ ] Build recursive composition

## Exercise Template

### Exercise 3: Builder Pattern
**Problem Statement**: Create a `PersonBuilder` to construct complex Person objects with optional fields

**Implementation Steps**:
1. Create Person class with multiple fields
2. Create PersonBuilder class
3. Implement fluent method chaining
4. Test with various configurations

**Expected Output**:
- Person objects with different configurations
- Clean, readable object creation code
- No nullPointerException from missing fields

### Exercise 4: Composite Pattern
**Problem Statement**: Build a file system structure with folders and files

**Implementation Steps**:
1. Create Component interface
2. Implement Leaf (File) class
3. Implement Composite (Folder) class
4. Support recursive operations

**Expected Output**:
- Tree structure of files and folders
- Ability to calculate total size
- Display hierarchical structure

## Code Sketches

### Builder Pattern Sketch
```java
// Person class with Builder
public class Person {
    private String name;
    private int age;
    private String email;
    
    private Person(PersonBuilder builder) {
        this.name = builder.name;
        this.age = builder.age;
        this.email = builder.email;
    }
}

public static class PersonBuilder {
    private String name;
    private int age;
    private String email;
    
    public PersonBuilder name(String name) {
        this.name = name;
        return this;
    }
    
    public Person build() {
        return new Person(this);
    }
}
```

### Composite Pattern Sketch
```java
public interface FileSystemComponent {
    void display();
    long getSize();
}

public class File implements FileSystemComponent {
    private String name;
    private long size;
    // implementation
}

public class Folder implements FileSystemComponent {
    private List<FileSystemComponent> children;
    // implementation
}
```

## Mandatory Exercises Progress
- [x] Exercise 1: Singleton Pattern - **COMPLETED**
- [x] Exercise 2: Factory Method Pattern - **COMPLETED**
- [ ] Exercise 3: Builder Pattern - **IN PROGRESS**
- [ ] Exercise 4: Composite Pattern - **IN PROGRESS**

## Module 1 Completion Checklist
- [x] SOLID Principles - Learned
- [x] Singleton Pattern - Implemented
- [x] Factory Method Pattern - Implemented
- [ ] Builder Pattern - In progress
- [ ] Composite Pattern - In progress
- [ ] Module 1 Quiz - Pending
- [ ] All exercises tested - In progress

## Testing Evidence
Will capture:
- Console output screenshots
- Pass/Fail test results
- Code execution logs

## Reflection & Learning
**Today's Achievements**:
- [ ] Completed both Exercise 3 and 4
- [ ] Understood advanced design patterns
- [ ] Tested all implementations

**Challenges to Address**:
- Builder vs Constructor overloading
- When to use Composite vs other patterns
- Performance implications

**Key Takeaway**:
Design patterns provide proven solutions to recurring design problems. Builder pattern is essential for complex objects, and Composite pattern enables recursive hierarchical structures.

---
**Progress**: Module 1 - 85% Complete (after today)
**Next Update**: Module 2 Kickoff (Day 4)
