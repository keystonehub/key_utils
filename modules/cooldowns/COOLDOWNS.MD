# Cooldowns Module

## Overview

The Cooldowns Module provides a way to manage cooldown periods for player and global actions. 
It ensures certain actions cannot be repeated by tracking the time since the last action was performed.

## What is a Cooldown?

A cooldown is a short waiting period that must pass before a player or system can perform a specific action again. 
The module supports both player-specific and global cooldowns.

## What Does the Cooldown Module Do?

- Adds player-specific or global cooldowns.
- Checks if a cooldown is currently active.
- Clears expired cooldowns automatically or on demand.
- Tracks which resource set the cooldown for easier cleanup.

## How is This Useful?

- **Prevents Exploits**: Limits repeated use of certain actions.
- **Better Game Balance**: Ensures fair intervals between specific actions.
- **Improved Performance**: Caches cooldown states to minimize unnecessary checks.

## Usage

### Adding a Cooldown

To set a cooldown, call the `add_cooldown` function. 
Define the player source (or leave it global), the cooldown type, the duration, and whether it’s global.

#### Example

```lua
utils.cooldowns.add(12345, 'begging', 60, false) -- Adds a player-specific cooldown for 60 seconds.
utils.cooldowns.add(nil, 'server_restart', 3600, true) -- Adds a global cooldown for 3600 seconds.
```

### Checking a Cooldown

To verify if a cooldown is active, use the `check_cooldown` function. Provide the player source (or leave it global), the cooldown type, and whether it’s global.

#### Example

```lua
local is_active = utils.cooldowns.check(12345, 'begging', false)
if is_active then
    print('Cooldown is still active.')
else
    print('No active cooldown.')
end
```

### Clearing a Cooldown

To remove a cooldown before it expires, use the `clear_cooldown` function. Provide the player source (or leave it global), the cooldown type, and whether it’s global.

#### Example

```lua
utils.cooldowns.clear(12345, 'begging', false) -- Clears a player-specific cooldown.
utils.cooldowns.clear(nil, 'server_restart', true) -- Clears a global cooldown.
```

### Periodic Cleanup

The module automatically clears expired cooldowns every minute, ensuring that the cooldown state remains efficient and up-to-date.

## Example Workflow

**Objective**: A player performs an action that has a cooldown, and the server ensures it can’t be repeated too soon.

### Server

```lua
-- Add a cooldown for player action
utils.cooldowns.add(source, 'heal', 30, false)

-- Later in code, check if the cooldown is active before allowing the action
local is_active = utils.cooldowns.check(source, 'heal', false)
if is_active then
    -- Deny the action
    print('Heal action is on cooldown.')
else
    -- Perform the action
    print('Player healed!')
end
```

### Client

```lua
-- Request server to check cooldown status
utils.cooldowns.check('heal', false, function(active)
    if active then
        print('Heal action is on cooldown.')
    else
        print('You can heal now!')
    end
end)
```