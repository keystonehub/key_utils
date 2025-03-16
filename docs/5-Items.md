# 5 - API Items

The *Items module* provides a standalone item registry for usable items, allowing items to be registered and used without relying on a framework.

# Server

## register_item(item_id, use_function)
Registers an item as usable and assigns a function to execute when used.

### Parameters:
- **item_id** *(string)* - The unique identifier of the item.
- **use_function** *(function)* - The function to execute when the item is used.

### Example Usage:
```lua
items.register_item("bandage", function(source, item_id)
    print("Player " .. source .. " used a " .. item_id)
end)
```

---

## use_item(source, item_id)
Triggers the use of a registered item.

### Parameters:
- **source** *(number)* - The player source ID.
- **item_id** *(string)* - The unique identifier of the item being used.

### Example Usage:
```lua
items.use_item(1, "bandage")
```
If the item is registered, it will execute its corresponding function.