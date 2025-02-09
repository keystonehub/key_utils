# Tables Module

## Overview

The Tables Module provides utility functions working with tables.

## Functions

### 1. **Print Table**

Prints the contents of a table, including nested tables, with structured indentation for clarity. Useful for debugging.

#### Usage

```lua
local example_table = {
    key1 = "value1",
    nested = {
        key2 = "value2",
        key3 = {
            key4 = "value4"
        }
    }
}

exports.tables.print_table(example_table)
```

**Output:**
```
key1: value1
nested:
  key2: value2
  key3:
    key4: value4
```

---

### 2. **Table Contains**

Checks if a table contains a specific value, even within nested tables.

#### Usage

```lua
local example_table = {"value1", nested = {"value2", "value3"}}

local contains = exports.tables.table_contains(example_table, "value2")
print(contains) -- Output: true
```

---

### 3. **Deep Copy**

Creates an independent copy of a table, including nested tables, ensuring no shared references.

#### Usage

```lua
local original_table = { key = "value", nested = { key2 = "value2" } }
local copied_table = exports.tables.deep_copy(original_table)

copied_table.key = "new_value"
print(original_table.key) -- Output: value
```

---

### 4. **Deep Compare**

Compares two tables, including their nested structures, to check if they are identical.

#### Usage

```lua
local table1 = { key = "value", nested = { key2 = "value2" } }
local table2 = { key = "value", nested = { key2 = "value2" } }

local are_equal = exports.tables.deep_compare(table1, table2)
print(are_equal) -- Output: true
```