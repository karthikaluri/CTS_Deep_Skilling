# Exercise 3: Builder Pattern

## Problem Statement
Create a **PersonBuilder** to construct complex Person objects with various optional fields. The Builder Pattern should enable fluent API for clean object construction.

## Requirements
1. Create a `Person` class with fields:
   - `name` (required)
   - `age` (optional)
   - `email` (optional)
   - `phone` (optional)
   - `address` (optional)

2. Implement `PersonBuilder` class that:
   - Allows step-by-step construction
   - Supports method chaining (fluent API)
   - Validates required fields before building
   - Throws exception if required fields are missing

3. Create test cases showing:
   - Building person with minimal fields
   - Building person with all fields
   - Error handling for missing required field

## Expected Output
```
Person built successfully:
  Name: John Doe
  Age: 30
  Email: john@example.com
  Phone: 555-1234
  Address: 123 Main St

Person with minimal fields:
  Name: Jane Smith
  Age: Not provided
  Email: Not provided
```
**Created**: 2026-06-17  
**Status**: Template Ready for Implementation
