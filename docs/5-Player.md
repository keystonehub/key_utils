# 5 - API Player


The Player module provides various utility functions related to players, including retrieving player details, distances, and animations.

# Shared

## get_cardinal_direction(player_ped)
Gets a player's cardinal direction based on their current heading.

### Parameters:
- **player_ped** *(number)* - The player's ped entity.

### Returns:
- *(string)* - The cardinal direction the player is facing.

### Example Usage:
```lua
local direction = PLAYER.get_cardinal_direction(PlayerPedId())
print("Player is facing:", direction)
```

---

## get_distance_to_entity(player_ped, entity)
Calculates the distance between a player and an entity.

### Parameters:
- **player_ped** *(number)* - The player's ped entity.
- **entity** *(number)* - The target entity.

### Returns:
- *(number)* - The distance between the player and the entity.

### Example Usage:
```lua
local distance = PLAYER.get_distance_to_entity(PlayerPedId(), someEntity)
print("Distance to entity:", distance)
```

# Client

## get_street_name(player_ped)
Retrieves the street name and area where a player is currently located.

### Parameters:
- **player_ped** *(number)* - The player entity.

### Returns:
- *(string)* - The street and area name the player is on.

### Example Usage:
```lua
local street = PLAYER.get_street_name(PlayerPedId())
print("Player is on:", street)
```

---

## get_region(player_ped)
Retrieves the name of the region a player is currently in.

### Parameters:
- **player_ped** *(number)* - The player entity.

### Returns:
- *(string)* - The region name the player is in.

### Example Usage:
```lua
local region = PLAYER.get_region(PlayerPedId())
print("Player is in region:", region)
```

---

## get_player_details(player_ped)
Retrieves detailed information about a PLAYER.

### Parameters:
- **player_ped** *(number)* - The player entity.

### Returns:
- *(table)* - A table containing detailed information about the PLAYER.

### Example Usage:
```lua
local details = PLAYER.get_player_details(PlayerPedId())
print(details)
```

---

## get_target_entity(player_ped)
Retrieves the entity a player is targeting.

### Parameters:
- **player_ped** *(number)* - The player entity.

### Returns:
- *(number)* - The entity that the player is targeting.

### Example Usage:
```lua
local target = PLAYER.get_target_entity(PlayerPedId())
if target ~= 0 then
    print("Player is targeting entity:", target)
end
```

---

## play_animation(player_ped, options, callback)
Runs an animation on the player with optional props and progress.

### Parameters:
- **player_ped** *(number)* - The player entity.
- **options** *(table)* - Table of options for the animation.
- **callback** *(function)* - Function to call when animation completes.

### Example Usage:
```lua
PLAYER.play_animation(PlayerPedId(), {
    dict = 'missheistdockssetup1clipboard@base',
    anim = 'base',
    duration = 5000,
    freeze = true,
    progress = { type = 'circle', message = 'Performing action...' },
    props = {
        {
            model = 'prop_cs_burger_01',
            bone = 57005,
            coords = vector3(0.13, 0.05, 0.02),
            rotation = vector3(-50.0, 16.0, 60.0),
        }
    }
}, function()
    print('Animation finished')
end)
```