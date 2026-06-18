# Day 2 Learning Log - SOLID Principles Deep Dive

**Date**: 2026-06-17  
**Module**: Design Patterns and Principles  
**Status**: CATCH-UP MODE - 1 Week Behind

## Topics Covered
1. **SOLID Principles** (Full Coverage)
   - Single Responsibility Principle (SRP)
   - Open/Closed Principle (OCP)
   - Liskov Substitution Principle (LSP)
   - Interface Segregation Principle (ISP)
   - Dependency Inversion Principle (DIP)

2. **Creational Design Patterns**
   - Singleton Pattern (Completed)
   - Factory Method Pattern (Completed)
   - Builder Pattern (Theory)

## Key Learnings

### SRP - Single Responsibility Principle
- **Definition**: A class should have only one reason to change
- **Example**: Logger class only handles logging, not file operations
- **Benefit**: Easier to test, maintain, and debug

### OCP - Open/Closed Principle
- **Definition**: Open for extension, closed for modification
- **Implementation**: Use interfaces and inheritance
- **Pattern Used**: Factory Method Pattern demonstrates this

### LSP - Liskov Substitution Principle
- **Definition**: Derived classes must be substitutable for base classes
- **In Context**: All document types (Word, PDF, Excel) can be used interchangeably

### ISP - Interface Segregation Principle
- **Definition**: Clients should not depend on interfaces they don't use
- **Alternative**: Use multiple specialized interfaces instead of one fat interface

### DIP - Dependency Inversion Principle
- **Definition**: Depend on abstractions, not concrete implementations
- **Practice**: Use dependency injection in constructors

## Code Examples Implemented

### Singleton Pattern (Logger)
```java
package singletonpattern;

public class Logger {
    private static Logger instance;
    
    private Logger() {
        System.out.println("Logger Instance Created");
    }
    
    public static Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        return instance;
    }
    
    public void log(String message) {
        System.out.println("LOG: " + message);
    }
}
```

### Factory Method Pattern (Document Types)
```java
package factorypattern;

public interface Document {
    void open();
}

public class WordDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Word Document");
    }
}
```

## Challenges Encountered
1. Package naming convention (corrected from `Exercise1_SingletonPattern` to `singletonpattern`)
2. Understanding when to use Singleton vs Factory Pattern
3. Thread safety in Singleton implementation

## Resources Used
- https://www.baeldung.com/solid-principles
- https://medium.com/@softwaretechsolution/design-pattern-81ef65829de2
- Personal code implementations and tests

## Exercises Completed
- [x] Singleton Pattern Exercise (Logger class)
- [x] Factory Method Pattern Exercise (Document factory)
- [ ] Exercise 3 - Builder Pattern (Pending - Module 1 continuation)
- [ ] Exercise 4 - Composite Pattern (Pending - Module 1 continuation)

## Self-Assessment
- ✅ Understood SOLID principles thoroughly
- ✅ Implemented Singleton pattern correctly
- ✅ Implemented Factory Method pattern with multiple document types
- ⚠️ Need more clarity on LSP and ISP in real-world scenarios
- ⚠️ Thread-safe Singleton implementation needs exploration

