# 5 - API Tables

Provides utility functions for working with Lua tables, including debugging, searching, copying, and comparing.

# Shared

## print_table(t, indent)
Prints the contents of a table to the console. Useful for debugging.

### Parameters:
- **t** *(table)* - The table to print.
- **indent** *(string, optional)* - The indentation level for nested TABLES. Defaults to an empty string.

### Example Usage:
```lua
local example_table = { key1 = "value1", key2 = { subkey1 = "subvalue1", subkey2 = "subvalue2" } }
TABLES.print(example_table)
```

---

## table_contains(tbl, val)
Checks if a table contains a specific value.

### Parameters:
- **tbl** *(table)* - The table to check.
- **val** *(any)* - The value to search for in the table.

### Returns:
- *(boolean)* - `true` if the value is found, `false` otherwise.

### Example Usage:
```lua
local example_table = {"apple", "banana", "cherry"}
if TABLES.contains(example_table, "banana") then
    print("Value found!")
end
```

---

## deep_copy(t)
Creates a deep copy of a table, ensuring changes to the copy won't affect the original table.

### Parameters:
- **t** *(table)* - The table to copy.

### Returns:
- *(table)* - A deep copy of the table.

### Example Usage:
```lua
local original = {a = 1, b = {c = 2, d = 3}}
local copy = TABLES.deep_copy(original)
copy.b.c = 10
print(original.b.c) -- Outputs 2, proving original is unaffected
```

---

## deep_compare(t1, t2)
Compares two nested tables for equality.

### Parameters:
- **t1** *(table)* - The first table.
- **t2** *(table)* - The second table.

### Returns:
- *(boolean)* - `true` if the tables are equal, `false` otherwise.

### Example Usage:
```lua
local table1 = {x = 1, y = {z = 2}}
local table2 = {x = 1, y = {z = 2}}
if TABLES.compare(table1, table2) then
    print("Tables are equal!")
end
```