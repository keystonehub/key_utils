# 5 - API Scope

The Scope module provides functionality for managing player visibility and event broadcasting within a defined scope.

# Server

## get_player_scope(_src)
Retrieves the list of players in the scope of a specified player.

### Parameters:
- **_src** *(number)* - The player identifier whose scope should be retrieved.

### Returns:
- *(table)* - A table of player identifiers within the scope.

### Example Usage:
```lua
local scoped_players = SCOPE.get_player_scope(player_id)
print("Players in scope:", json.encode(scoped_players))
```

---

## add_to_scope(owner, target)
Adds a player to another player's scope.

### Parameters:
- **owner** *(number)* - The player who owns the scope.
- **target** *(number)* - The player being added to the scope.

### Example Usage:
```lua
SCOPE.add_to_scope(player_id, target_id)
```

---

## remove_from_scope(owner, target)
Removes a player from another player's scope.

### Parameters:
- **owner** *(number)* - The player who owns the scope.
- **target** *(number)* - The player being removed from the scope.

### Example Usage:
```lua
SCOPE.remove_from_scope(player_id, target_id)
```

---

## clear_player_scope(_src)
Clears scope data for a player (e.g., when they leave the server).

### Parameters:
- **_src** *(number)* - The player identifier.

### Example Usage:
```lua
SCOPE.clear_player_scope(player_id)
```

---

## trigger_scope_event(event_name, scope_owner, ...)
Triggers an event for all players within the scope of a specified player.

### Parameters:
- **event_name** *(string)* - The name of the event to trigger.
- **scope_owner** *(number)* - The player identifier whose scope will be used.
- **...** *(any)* - Additional parameters to pass along with the event.

### Example Usage:
```lua
SCOPE.trigger_scope_event("custom:event_name", player_id, {data = "example"})
```