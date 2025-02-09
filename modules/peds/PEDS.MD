# Peds Module

## Overview

The Peds Module simplifies the management and manipulation of NPCs. 
You can use this spawn, customize, and control peds.

## What Does the Peds Module Do?

- Spawns single or multiple peds at specified locations.
- Assigns animations, scenarios, and weapons to peds.
- Provides utilities to remove peds individually, in bulk, or by category.
- Maintains a list of created peds for better management.

## How is This Useful?

- **Customizable NPCs**: Create peds with specific attributes, animations, and weapons.
- **Efficient Management**: Group and manage peds using categories.
- **Improved Control**: Easily remove or modify peds as needed.

## Usage

### Creating a Ped

To create a single ped, use the `create_ped` function and provide a data table containing base, animation, and weapon data.

#### Example

```lua
local ped_data = {
    base_data = {
        model = 'a_m_m_business_01',
        coords = vector3(-254.09, -971.48, 31.22),
        scenario = 'WORLD_HUMAN_AA_COFFEE',
        networked = false
    },
    animation_data = {
        dict = 'amb@world_human_aa_coffee@base',
        anim = 'base',
        blend_in = 8.0,
        blend_out = -8.0,
        duration = -1,
        flag = 49,
        playback_rate = 1.0
    },
    weapon_data = {
        weapon_name = 'WEAPON_PISTOL',
        ammo = 100,
        equip_now = true,
        is_hidden = false,
        accuracy = 100.0,
        invincible = true
    }
}

local ped = utils.peds.create_ped(ped_data)
```

### Creating Multiple Peds

To spawn multiple peds at once, use the `create_peds` function with a configuration table.

#### Example

```lua
local ped_config = {
    {
        base_data = {
            model = 'a_m_y_hipster_01',
            coords = vector3(-100.0, 200.0, 20.0)
        }
    },
    {
        base_data = {
            model = 'a_m_y_business_01',
            coords = vector3(-102.0, 202.0, 20.0)
        }
    }
}

utils.peds.create_peds(ped_config)
```

### Removing a Ped

To remove a specific ped, use the `remove_ped` function.

#### Example

```lua
utils.peds.remove_ped(ped)
```

### Removing All Peds

To clear all created peds, use the `remove_all_peds` function.

#### Example

```lua
utils.peds.remove_all_peds()
```

### Removing Peds by Category

To remove peds assigned to specific categories, use the `remove_peds_by_categories` function.

#### Example

```lua
local categories = { 'guards', 'civilians' }
utils.peds.remove_peds_by_categories(categories)
```

## Example Workflow

**Objective**: Spawn a security guard ped with a weapon, assign it to a "guards" category, and remove it later by category.

### Workflow

1. **Create the Ped**:

```lua
local function create_guard(coords)
    local ped_data = {
        base_data = {
            model = 's_m_m_security_01',
            coords = coords,
            category = 'guards'
        },
        weapon_data = {
            weapon_name = 'WEAPON_PUMPSHOTGUN',
            ammo = 50,
            equip_now = true,
            accuracy = 75.0,
            invincible = false
        }
    }

    return utils.peds.create_ped(ped_data)
end
```

2. **Example Usage:**

```lua
-- Create a guard at the specified location
local guard = create_guard(vector3(-253.0, -970.0, 31.22))

-- Make the guard hostile towards the player
TaskCombatPed(guard, PlayerPedId(), 0, 16)
```

3. **Remove the Ped by Category**:

```lua
local categories = { 'guards' }
utils.peds.remove_peds_by_categories(categories)
```

For further details or assistance, refer to the documentation or contact support via Discord.