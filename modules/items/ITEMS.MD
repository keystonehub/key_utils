# Items System Module

## Overview

The Items Module provides a standalone way to register usable items. 

## What is a Usable Item?

A usable item is an item in your server that triggers a specific function when used by a player, typically through an inventory UI. 
This module allows you to register items and define their behavior if you do not have a native system.

## What Does the Items System Module Do?

- Registers items as usable with custom functionality.
- Triggers registered functions when items are used by players.

## How is This Useful?

- **Standalone**: Provides a standalone item system for servers without one.
- **Custom Behavior**: Define unique functions for each item when used.
- **Centralized Management**: Keep all item logic in one place for easier maintenance.

## Usage

### Registering a Usable Item

To register an item, use the `register_item` function. 
Define the item ID and a function that specifies what happens when the item is used.

#### Example

```lua
utils.items.register('water', function(source, item_id)

    print(('Player %d used item: %s'):format(source, item_id))
    -- Add custom logic here, e.g., increase player thirst.
end)
```

### Triggering Item Use

When an item is used, the server triggers the `fivem_utils:sv:use_item` event. 
You can use this event to allow triggering item use from the client, e.g, in an inventory.
Make sure all item function handlers are correctly secured to avoid exploits.

#### Example

Server-side:

```lua
utils.items.use_item(source, 'water')
```

## Example Workflow

**Objective**: A player uses a health potion that restores their health.

### Server

1. **Register the Item**:

   ```lua
   utils.items.register('water', function(source, item_id)
       -- You can use utils.fw functions to validate if the player actually has the item.
       local has_item = utils.fw.has_item(source, 'water', 1)
       -- Exit if they do not have the item.
       if not has_item then print('Player doesnt have any water...') return end

       -- If they have water allow them to proceed.
       -- Add custom logic here.
   end)
   ```

2. **Trigger the Item Use Event**:

   ```lua
   TriggerServerEvent('fivem_utils:sv:use_item', 'water')
   ```

### Client

Trigger the `fivem_utils:sv:use_item` event when the player uses the item:

```lua
TriggerServerEvent('fivem_utils:sv:use_item', 'water')
```

The server responds by executing the registered function for the item.