# Exercise 4: Composite Pattern

## Problem Statement
Create a **file system structure** using the Composite Pattern. Implement a hierarchical tree structure with files and folders where both can be treated uniformly.

## Requirements
1. Create a `FileSystemComponent` interface with:
   - `display()` - Display the component and its structure
   - `getSize()` - Get the total size
   - `getName()` - Get component name

2. Implement `File` class (Leaf):
   - Stores name and size
   - Implements all interface methods

3. Implement `Folder` class (Composite):
   - Contains collection of FileSystemComponent objects
   - `add()` and `remove()` methods
   - `display()` shows entire tree structure
   - `getSize()` returns sum of all children

4. Create comprehensive test cases

## Expected Output
```
Root (Folder)
├── File1.txt (1 KB)
├── SubFolder1
│   ├── File2.txt (2 KB)
│   └── File3.doc (3 KB)
└── SubFolder2
    └── File4.pdf (4 KB)

Total Size: 10 KB


---
**Created**: 2026-06-17  
**Status**: Template Ready for Implementation
