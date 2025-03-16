# 5 - API XP

The XP module provides functionality for managing player experience points, including adding, removing, and calculating required XP for leveling up.

# Server

## get_all_xp(source)
Retrieves all XP data for a player.

### Parameters:
- **source** *(number)* - The player source ID.

### Returns:
- *(table)* - The XP data for the player.

### Example Usage:
```lua
local player_xp = XP.get_all(source)
print(json.encode(player_xp))
```

---

## get_xp(source, xp_id)
Retrieves a specific XP entry for a player.

### Parameters:
- **source** *(number)* - The player source ID.
- **xp_id** *(string)* - The XP ID.

### Returns:
- *(table|nil)* - The XP data for the specified ID.

### Example Usage:
```lua
local xp_data = XP.get(source, "driving")
if xp_data then
    print("Driving XP:", xp_data.xp)
end
```

---

## set_xp(source, xp_id, amount)
Sets XP for a player.

### Parameters:
- **source** *(number)* - The player source ID.
- **xp_id** *(string)* - The XP ID.
- **amount** *(number)* - The XP amount to set.

### Returns:
- *(boolean)* - True if successful, false otherwise.

### Example Usage:
```lua
XP.set(source, "driving", 100)
```

---

## add_xp(source, xp_id, amount)
Adds XP to a player's skill/reputation.

### Parameters:
- **source** *(number)* - The player source ID.
- **xp_id** *(string)* - The XP ID.
- **amount** *(number)* - The XP amount to add.

### Returns:
- *(boolean)* - True if successful, false otherwise.

### Example Usage:
```lua
XP.add(source, "driving", 10)
```

---

## remove_xp(source, xp_id, amount)
Removes XP from a player's skill/reputation.

### Parameters:
- **source** *(number)* - The player source ID.
- **xp_id** *(string)* - The XP ID.
- **amount** *(number)* - The XP amount to remove.

### Returns:
- *(boolean)* - True if successful, false otherwise.

### Example Usage:
```lua
XP.remove(source, "driving", 5)
```

---

## calculate_required_xp(current_level, first_level_xp, growth_factor)
Calculates required experience points for the next level.

### Parameters:
- **current_level** *(number)* - The current level of the skill.
- **first_level_xp** *(number)* - The experience points required for the first level.
- **growth_factor** *(number)* - The growth factor for experience points.

### Returns:
- *(number)* - The required XP for the next level.

### Example Usage:
```lua
local required_xp = XP.calculate_required_xp(5, 100, 1.5)
print("XP needed for next level:", required_xp)
```

---

# Client

## get_all_xp()
Retrieves all XP data for the player.

### Returns:
- *(table|nil)* - The XP data for the player.

### Example Usage:
```lua
local xp_data = XP.get_all()
if xp_data then
    print("Player XP:", json.encode(xp_data))
end
```