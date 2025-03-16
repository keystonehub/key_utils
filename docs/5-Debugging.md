# 5 - API Debugging

The *Debugging module provides utilities for logging and timestamp management, useful for development and debugging across both server and client environments.

# Shared

## get_current_time()
Retrieves the current formatted timestamp.

### Returns:
- *(string)* - Formatted timestamp in `YYYY-MM-DD HH:MM:SS` format.

### Example Usage:
```lua
local current_time = DEBUGGING.get_current_time()
print("Current Time:", current_time)
```

---

## debug_print(level, message, data)
Logs debug messages with color-coded levels and optional data.

### Parameters:
- **level** *(string)* - The log level (`"debug"`, `"info"`, `"success"`, `"warn"`, `"error"`).
- **message** *(string)* - The message to log.
- **data** *(table|nil)* - Optional data to include in the log.

### Example Usage:
```lua
DEBUGGING.debug_print("info", "Player connected", { player_id = 1, name = "John Doe" })
```