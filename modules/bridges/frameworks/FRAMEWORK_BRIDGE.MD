# Framework Bridge Module

## Overview

The Framework Bridge Module allows scripts to work across multiple FiveM frameworks by handling framework-specific differences internally.

It was originally developed in-house for BOII Development multi-framework releases and has been tested in live servers.
The module continues to be actively used and updated as needed.

For adding additional bridges, refer to the documentation.
If you need further assistance, contact support via Discord.

## What is a Bridge?

A bridge is a layer between your scripts and the framework.
It provides a straightforward API (`core`) to access framework-specific functionality without requiring changes to your scripts.

## What Does the Framework Bridge Do?

- Detects the active framework by checking folder names in `modules/bridges/frameworks/`.
- Provides framework-specific functions through `core`.
- Handles tasks like retrieving player data, managing jobs, adding items, or adjusting balances.

## How is This Useful?

- **Cross-Framework Compatibility**: Write scripts once, and they will work with supported frameworks.
- **Centralized Management**: Framework-specific changes are isolated to the bridge.
- **Extensible**: Add support for additional frameworks by creating new bridge folders.

## Usage

### Getting the Framework Module

To access the framework bridge, use:

```lua
local core = exports.fivem_utils:get_module('fw')
```

This ensures you are only loading the framework bridge instead of all modules.

#### Client Side

1. **Retrieve Player Identity**:

```lua
local identity = core.get_identity()
if identity then
    print('Player Name:', identity.first_name, identity.last_name)
    print('Date of Birth:', identity.dob)
else
    print('Failed to retrieve player identity.')
end
```

2. **Retrieve Player Unique ID**:

```lua
local player_id = core.get_player_id()
if player_id then
    print('Player Unique ID:', player_id)
else
    print('Failed to retrieve player unique ID.')
end
```

#### Server Side

1. **Check if a Player Has an Item**:

```lua
local has_item = core.has_item(source, 'water', 1)
if has_item then
    print('Player has water.')
else
    print('Player does not have water.')
end
```

2. **Adjust Player Balance**:

```lua
core.adjust_balance(source, {
    operations = {
        { action = 'add', balance_type = 'cash', amount = 500 },
        { action = 'remove', balance_type = 'bank', amount = 200 }
    }
})
print('Player balance adjusted.')
```

3. **Get Player Job Details**:

```lua
local jobs = core.get_player_jobs(source)
if jobs then
    print('Player Jobs:', table.concat(jobs, ', '))
else
    print('No jobs found for player.')
end
```

## Workflow Example

**Objective**: A player picks up an item, and the server validates the item's cost before deducting money and adding the item to the player's inventory.

### Client

```lua
callbacks.trigger('server_check_balance_and_give_item', { item = 'water' }, function(success)
    if success then
        print('Transaction completed. Item added.')
    else
        print('Transaction failed. Insufficient funds.')
    end
end)
```

### Server

```lua
callbacks.register('server_check_balance_and_give_item', function(source, data, cb)
    local item_prices = {
        water = 100,
        bread = 50
    }

    local item = data.item
    local cost = item_prices[item]

    if not cost then
        print('Invalid item:', item)
        cb(false)
        return
    end

    local balance = core.get_balance_by_type(source, 'cash')
    if balance >= cost then
        core.adjust_balance(source, {
            operations = {
                { action = 'remove', balance_type = 'cash', amount = cost }
            }
        })
        core.adjust_inventory(source, {
            items = {
                { action = 'add', item_id = item, amount = 1 }
            }
        })
        cb(true)
    else
        cb(false)
    end
end)
```

## Additional Information

### Folder Structure

```
modules/
  bridges/
    frameworks/
      es_extended/  # Folder name must match the resource name; see **Renamed Core Folders** below.
      qb-core/
```

### Renamed Core Folders

If your server uses a renamed core resource folder, this information is **crucial**.

To ensure proper functionality, the folder name of your core resource **must** match one of the frameworks listed inside the **FRAMEWORKS** array in the `init.lua` file.
If your core has been renamed, update the corresponding framework folder name to match the renamed core resource folder.

For example:

- If the core resource is renamed from `es_extended` to `custom_core`
- Rename `es_extended` inside the **FRAMEWORKS** array in the `init.lua` file to `custom_core`.
- Rename the `es_extended` folder under `frameworks/` to `custom_core`.