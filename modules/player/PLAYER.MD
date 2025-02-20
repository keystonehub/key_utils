# Player Module

## Overview

The Player Module provides utilities to retrieve player-related information and perform actions such as animations with props. 

## What Does The Player Module Do?

- Retrieves player-related data like location, cardinal direction, or targeted entities.
- Run animations with props attached to the player.

## Features

- **Location Information**: Get street names, areas, or regions where the player is located.
- **Entity Interaction**: Identify and interact with entities the player is targeting.
- **Animations**: Run animations with detailed options, including props and callbacks.

## Usage

### Getting Player Information

#### Retrieve Cardinal Direction
Get the direction the player is facing.

```lua
local direction = utils.player.get_cardinal_direction(PlayerPedId())
print('Player is facing:', direction)
```

#### Get Current Street Name
Retrieve the street and area the player is on.

```lua
local street = utils.player.get_street_name(PlayerPedId())
print('Player is on:', street)
```

#### Get Detailed Player Information
Retrieve a comprehensive table of player details such as health, armor, and location.

```lua
local player_details = utils.player.get_player_details(PlayerPedId())
print('Player Details:', json.encode(player_details))
```

### Entity Interaction

#### Retrieve Targeted Entity
Identify the entity the player is currently aiming at.

```lua
local target_entity = utils.player.get_target_entity(PlayerPedId())
if target_entity and target_entity > 0 then
    print('Player is targeting entity ID:', target_entity)
else
    print('No entity targeted.')
end
```

#### Distance to Targeted Entity
Calculate the distance between the player and a specific entity.

```lua
local distance = utils.player.get_distance_to_entity(PlayerPedId(), target_entity)
print('Distance to targeted entity:', distance)
```

### Running Animations

#### Play Animation with Props
Run an animation with optional props and a callback.

```lua
local player_ped = PlayerPedId()
utils.player.play_animation(player_ped, {
    dict = 'missheistdockssetup1clipboard@base',
    anim = 'base',
    flags = 49,
    duration = 5000,
    freeze = true,
    props = {
        {
            model = 'prop_cs_burger_01',
            bone = 57005,
            coords = vector3(0.13, 0.05, 0.02),
            rotation = vector3(-50.0, 16.0, 60.0),
        },
        {
            model = 'ba_prop_club_water_bottle',
            bone = 60309,
            coords = vector3(0.0, 0.0, 0.05),
        }
    }
}, function()
    print('Animation completed!')
end)
```

## Example Workflow

**Objective**: Retrieve the player's location and run an animation at their position.

### Server

```lua
RegisterCommand('show_location', function(source, args, rawCommand)
    local player_ped = GetPlayerPed(-1)
    local location = utils.player.get_street_name(player_ped)
    print('Player is at:', location)

    utils.player.play_animation(player_ped, {
        dict = 'amb@world_human_hang_out_street@male_a@base',
        anim = 'base',
        freeze = true,
        duration = 3000
    }, function()
        print('Animation completed at location:', location)
    end)
end)
```

For further details or assistance, refer to the documentation or contact support via Discord.