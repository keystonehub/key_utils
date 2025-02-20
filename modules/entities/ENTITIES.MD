# Entity Module

## Overview

The Entity Module provides utility functions to simplify the process of interacting with entities. 
This includes finding nearby objects, players, peds, and vehicles, as well as retrieving information about targeted entities.

## Features

- Retrieve nearby objects, peds, players, and vehicles.
- Identify the closest entity of a specific type.
- Find entities directly in front of the player within a field of view (FOV).
- Support for filtering entities based on custom logic.

## Usage

### Getting Nearby Entities

#### Nearby Objects

**Function:** `get_nearby_objects`

**Description:** Retrieves all objects within a specified radius.

##### Example
```lua
local coords = GetEntityCoords(PlayerPedId())
local nearby_objects = utils.entities.get_nearby_objects(coords, 10.0)
for _, object in ipairs(nearby_objects) do
    print('Object ID:', object.entity, 'Coords:', object.coords)
end
```

---

#### Nearby Peds

**Function:** `get_nearby_peds`

**Description:** Retrieves all non-player peds within a specified radius.

##### Example
```lua
local coords = GetEntityCoords(PlayerPedId())
local nearby_peds = utils.entities.get_nearby_peds(coords, 10.0)
for _, ped in ipairs(nearby_peds) do
    print('Ped ID:', ped.entity, 'Coords:', ped.coords)
end
```

---

#### Nearby Players

**Function:** `get_nearby_players`

**Description:** Retrieves all players within a specified radius, optionally including the executing player.

##### Example
```lua
local coords = GetEntityCoords(PlayerPedId())
local nearby_players = utils.entities.get_nearby_players(coords, 10.0, false)
for _, player in ipairs(nearby_players) do
    print('Player ID:', player.entity, 'Coords:', player.coords)
end
```

---

#### Nearby Vehicles

**Function:** `get_nearby_vehicles`

**Description:** Retrieves all vehicles within a specified radius, optionally excluding the player's vehicle.

##### Example
```lua
local coords = GetEntityCoords(PlayerPedId())
local nearby_vehicles = utils.entities.get_nearby_vehicles(coords, 20.0, true)
for _, vehicle in ipairs(nearby_vehicles) do
    print('Vehicle ID:', vehicle.entity, 'Coords:', vehicle.coords)
end
```

## Getting Closest Entities

#### Closest Object

**Function:** `get_closest_object`

**Description:** Retrieves the closest object within a specified radius.

##### Example
```lua
local coords = GetEntityCoords(PlayerPedId())
local closest_object, object_coords = utils.entities.get_closest_object(coords, 10.0)
if closest_object then
    print('Closest Object ID:', closest_object, 'Coords:', object_coords)
end
```

---

#### Closest Ped

**Function:** `get_closest_ped`

**Description:** Retrieves the closest ped within a specified radius, excluding players.

##### Example
```lua
local coords = GetEntityCoords(PlayerPedId())
local closest_ped, ped_coords = utils.entities.get_closest_ped(coords, 15.0)
if closest_ped then
    print('Closest Ped ID:', closest_ped, 'Coords:', ped_coords)
end
```

---

#### Closest Player

**Function:** `get_closest_player`

**Description:** Retrieves the closest player within a specified radius, optionally including the executing player.

##### Example
```lua
local coords = GetEntityCoords(PlayerPedId())
local closest_player, player_ped, player_coords = utils.entities.get_closest_player(coords, 20.0, false)
if closest_player then
    print('Closest Player ID:', closest_player, 'Coords:', player_coords)
end
```

---

#### Closest Vehicle

**Function:** `get_closest_vehicle`

**Description:** Retrieves the closest vehicle within a specified radius, optionally excluding the player's vehicle.

##### Example
```lua
local coords = GetEntityCoords(PlayerPedId())
local closest_vehicle, vehicle_coords = utils.entities.get_closest_vehicle(coords, 25.0, false)
if closest_vehicle then
    print('Closest Vehicle ID:', closest_vehicle, 'Coords:', vehicle_coords)
end
```

## Specialized Functions

### Entities in Front of Player

**Function:** `get_entities_in_front_of_player`

**Description:** Retrieves the entity directly in front of the player within a specified FOV and distance.

##### Example
```lua
local entity = utils.entities.get_entities_in_front_of_player(30.0, 5.0)
if entity then
    print('Entity in front ID:', entity)
end
```

---

### Target Ped

**Function:** `get_target_ped`

**Description:** Retrieves the ped directly in front of the player within a specified FOV and distance or the nearest ped if none found.

##### Example
```lua
local player_ped = PlayerPedId()
local target_ped, ped_coords = utils.entities.get_target_ped(player_ped, 45.0, 10.0)
if target_ped then
    print('Target Ped ID:', target_ped, 'Coords:', ped_coords)
end
```

## Example Workflow

**Objective**: Find all nearby entities and log their details.

### Client-Side Script

```lua
local coords = GetEntityCoords(PlayerPedId())

-- Nearby Objects
local objects = utils.entities.get_nearby_objects(coords, 15.0)
for _, obj in ipairs(objects) do
    print('Nearby Object ID:', obj.entity)
end

-- Nearby Peds
local peds = utils.entities.get_nearby_peds(coords, 15.0)
for _, ped in ipairs(peds) do
    print('Nearby Ped ID:', ped.entity)
end

-- Closest Vehicle
local vehicle, vehicle_coords = utils.entities.get_closest_vehicle(coords, 20.0, false)
if vehicle then
    print('Closest Vehicle ID:', vehicle, 'Coords:', vehicle_coords)
end
```