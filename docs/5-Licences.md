# 5 - API Licences

The Licenses module provides a standalone licensing system for players. 
It supports theory and practical tests, a point-based system, and revoking of licenses when the maximum point threshold is reached.

# Server

## get_licences(source)
Retrieves all licenses for a specific player.

### Parameters:
- **source** *(number)* - Player source identifier.

### Returns:
- *(table)* - A table containing all the player’s licenses.

### Example Usage:
```lua
local licences = LICENCES.get_licences(source)
print(json.encode(licences))
```

---

## get_licence(source, licence_id)
Retrieves a specific license for a player.

### Parameters:
- **source** *(number)* - Player source identifier.
- **licence_id** *(string)* - License ID to retrieve.

### Returns:
- *(table|nil)* - The license data if found, otherwise nil.

### Example Usage:
```lua
local licence = LICENCES.get_licence(source, "driver")
if licence then print("License found!") end
```

---

## add_licence(source, licence_id)
Adds a new license to a player.

### Parameters:
- **source** *(number)* - Player source identifier.
- **licence_id** *(string)* - License ID to add.

### Returns:
- *(boolean)* - True if the license was successfully added.

### Example Usage:
```lua
LICENCES.add_licence(source, "pilot")
```

---

## remove_licence(source, licence_id)
Removes a license from a player.

### Parameters:
- **source** *(number)* - Player source identifier.
- **licence_id** *(string)* - License ID to remove.

### Returns:
- *(boolean)* - True if the license was successfully removed.

### Example Usage:
```lua
LICENCES.remove_licence(source, "driver")
```

---

## add_points(source, licence_id, points)
Adds penalty points to a player’s license. If the total points exceed the max limit, the license will be revoked.

### Parameters:
- **source** *(number)* - Player source identifier.
- **licence_id** *(string)* - License ID to modify.
- **points** *(number)* - Number of points to add.

### Returns:
- *(boolean)* - True if points were added successfully.

### Example Usage:
```lua
LICENCES.add_points(source, "driver", 3)
```

---

## remove_points(source, licence_id, points)
Removes penalty points from a player’s license.

### Parameters:
- **source** *(number)* - Player source identifier.
- **licence_id** *(string)* - License ID to modify.
- **points** *(number)* - Number of points to remove.

### Returns:
- *(boolean)* - True if points were removed successfully.

### Example Usage:
```lua
LICENCES.remove_points(source, "driver", 2)
```

---

## update_licence(source, licence_id, test_type, passed)
Updates a player’s license status for either theory or practical tests.

### Parameters:
- **source** *(number)* - Player source identifier.
- **licence_id** *(string)* - License ID to update.
- **test_type** *(string)* - "theory" or "practical".
- **passed** *(boolean)* - Whether the test was passed.

### Returns:
- *(boolean)* - True if the license was updated successfully.

### Example Usage:
```lua
LICENCES.update_licence(source, "driver", "practical", true)
```

---

# Client

## get_licences()
Retrieves the player’s licenses from the server.

### Returns:
- *(table|nil)* - A table containing the player’s licenses, or nil if retrieval failed.

### Example Usage:
```lua
local licences = LICENCES.get_licences()
if licences then print(json.encode(licences)) end
```

