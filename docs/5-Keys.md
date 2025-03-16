# 5 - API Keys

The*Keys module provides a static key list and functions to retrieve key codes, names, and perform lookups.

# Shared

## get_keys()
Retrieves the full list of available keys and their respective key codes.

### Returns:
- *(table)* - A table containing key names as keys and their corresponding key codes as values.

### Example Usage:
```lua
local keys = KEYS.get_keys()
print(keys["enter"]) -- Outputs: 191
```
---

## get_key(key_name)
Retrieves the key code for a given key name.

### Parameters:
- **key_name** *(string)* - The name of the key.

### Returns:
- *(number|nil)* - The key code if found, otherwise nil.

### Example Usage:
```lua
local key_code = KEYS.get_key("escape")
print(key_code) -- Outputs: 322
```
---

## get_key_name(key_code)
Retrieves the key name for a given key code.

### Parameters:
- **key_code** *(number)* - The key code to look up.

### Returns:
- *(string|nil)* - The key name if found, otherwise nil.

### Example Usage:
```lua
local key_name = KEYS.get_key_name(46)
print(key_name) -- Outputs: "e"
```
---

## print_key_list()
Prints the entire key list to the console.

### Example Usage:
```lua
KEYS.print_key_list()
```
---

## key_exists(key_name)
Checks if a key exists in the key list.

### Parameters:
- **key_name** *(string)* - The name of the key to check.

### Returns:
- *(boolean)* - `true` if the key exists, `false` otherwise.

### Example Usage:
```lua
if KEYS.key_exists("f1") then
    print("F1 key is available.")
else
    print("F1 key is not in the list.")
end
```