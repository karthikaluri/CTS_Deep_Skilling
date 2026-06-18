# Exercise 1: Inventory Management System

## Scenario

You are developing an inventory management system for a warehouse. Efficient data storage and retrieval are crucial.

## Problem Understanding

- Manage inventory items by item ID, name, quantity, and price.
- Support add, lookup, update, remove, and print operations.
- Optimize for fast retrieval and updates.

## Setup

- `InventoryItem.java`: represents each item in inventory.
- `InventoryManager.java`: manages items in a `HashMap<String, InventoryItem>`.
- `InventoryTest.java`: demonstrates add, update, remove, and print operations.

## Implementation

- `HashMap` provides average O(1) time for insert, lookup, update, and delete.
- The inventory key is `itemId`, which ensures unique and efficient access.

## Analysis & Optimization

1. Data Structure Choice:
   - Use `HashMap` for constant-time operations.
   - If you need ordered output, wrap the map with `LinkedHashMap`.

2. Memory vs Performance:
   - `HashMap` uses extra memory for buckets, but it is worth it for speed.
   - For very large inventory, consider using a database or disk-backed store.

3. Optimization:
   - Use string item IDs that follow a predictable format for better hashing.
   - Keep item metadata small to reduce memory overhead.
   - If the warehouse needs range queries by quantity or price, maintain secondary indexes (e.g. sorted lists or a `TreeMap`).

4. Concurrency:
   - If multiple warehouse workers update inventory concurrently, use `ConcurrentHashMap`.
   - Alternatively, synchronize only the operations that mutate the map.

## How to Run

Compile:
```
javac InventoryItem.java InventoryManager.java InventoryTest.java
```

Run:
```
java InventoryTest
```
