# 5 - API Entities

The Entities module provides functions for detecting nearby and closest entities such as objects, peds, players, and vehicles.

# Client

## get_nearby_objects(coords, max_distance)
Finds nearby objects within a specified distance.

### Parameters:
- **coords** *(vector3)* - The center point of the search.
- **max_distance** *(number)* - The search radius.

### Returns:
- *(table)* - A list of nearby objects and their coordinates.

### Example Usage:
```lua
local nearby_objects = ENTITIES.get_nearby_objects(GetEntityCoords(PlayerPedId()), 10.0)
```

---

## get_nearby_peds(coords, max_distance)
Finds nearby peds, excluding players.

### Parameters:
- **coords** *(vector3)* - The center point of the search.
- **max_distance** *(number)* - The search radius.

### Returns:
- *(table)* - A list of nearby peds and their coordinates.

### Example Usage:
```lua
local nearby_peds = ENTITIES.get_nearby_peds(GetEntityCoords(PlayerPedId()), 10.0)
```

---

## get_nearby_players(coords, max_distance, include_player)
Finds nearby players.

### Parameters:
- **coords** *(vector3)* - The center point of the search.
- **max_distance** *(number)* - The search radius.
- **include_player** *(boolean)* - Whether to include the executing player in results.

### Returns:
- *(table)* - A list of nearby players, their peds, and coordinates.

### Example Usage:
```lua
local nearby_players = ENTITIES.get_nearby_players(GetEntityCoords(PlayerPedId()), 10.0, false)
```

---

## get_nearby_vehicles(coords, max_distance, include_player_vehicle)
Finds nearby vehicles.

### Parameters:
- **coords** *(vector3)* - The center point of the search.
- **max_distance** *(number)* - The search radius.
- **include_player_vehicle** *(boolean)* - Whether to include the player’s vehicle.

### Returns:
- *(table)* - A list of nearby vehicles and their coordinates.

### Example Usage:
```lua
local nearby_vehicles = ENTITIES.get_nearby_vehicles(GetEntityCoords(PlayerPedId()), 10.0, false)
```

---

## get_closest_object(coords, max_distance)
Finds the closest object.

### Parameters:
- **coords** *(vector3)* - The center point of the search.
- **max_distance** *(number)* - The search radius.

### Returns:
- *(number)* - The closest object found.
- *(vector3)* - The coordinates of the object.

### Example Usage:
```lua
local object, object_coords = ENTITIES.get_closest_object(GetEntityCoords(PlayerPedId()), 10.0)
```

---

## get_closest_ped(coords, max_distance)
Finds the closest ped, excluding players.

### Parameters:
- **coords** *(vector3)* - The center point of the search.
- **max_distance** *(number)* - The search radius.

### Returns:
- *(number)* - The closest ped found.
- *(vector3)* - The coordinates of the ped.

### Example Usage:
```lua
local ped, ped_coords = ENTITIES.get_closest_ped(GetEntityCoords(PlayerPedId()), 10.0)
```

---

## get_closest_player(coords, max_distance, include_player)
Finds the closest player.

### Parameters:
- **coords** *(vector3)* - The center point of the search.
- **max_distance** *(number)* - The search radius.
- **include_player** *(boolean)* - Whether to include the executing player.

### Returns:
- *(number)* - The closest player’s ID.
- *(number)* - The closest player’s ped.
- *(vector3)* - The closest player’s coordinates.

### Example Usage:
```lua
local player_id, ped, coords = ENTITIES.get_closest_player(GetEntityCoords(PlayerPedId()), 10.0, false)
```

---

## get_closest_vehicle(coords, max_distance, include_player_vehicle)
Finds the closest vehicle.

### Parameters:
- **coords** *(vector3)* - The center point of the search.
- **max_distance** *(number)* - The search radius.
- **include_player_vehicle** *(boolean)* - Whether to include the player’s vehicle.

### Returns:
- *(number)* - The closest vehicle found.
- *(vector3)* - The coordinates of the vehicle.

### Example Usage:
```lua
local vehicle, vehicle_coords = ENTITIES.get_closest_vehicle(GetEntityCoords(PlayerPedId()), 10.0, false)
```

---

## get_entities_in_front_of_player(fov, distance)
Finds the entity in front of the player within a given field of view and distance.

### Parameters:
- **fov** *(number)* - Field of view in degrees.
- **distance** *(number)* - Search distance.

### Returns:
- *(number|nil)* - The entity found or `nil`.

### Example Usage:
```lua
local entity = ENTITIES.get_entities_in_front_of_player(45, 5.0)
```

---

## get_target_ped(player_ped, fov, distance)
Finds a target ped in front of the player or the closest ped.

### Parameters:
- **player_ped** *(number)* - The player’s ped.
- **fov** *(number)* - Field of view in degrees.
- **distance** *(number)* - Search distance.

### Returns:
- *(number)* - The target ped found.
- *(vector3)* - The coordinates of the target ped.

### Example Usage:
```lua
local target_ped, ped_coords = ENTITIES.get_target_ped(PlayerPedId(), 45, 5.0)
```