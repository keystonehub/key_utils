# Zones Module

## Overview

The Zones Module provides tools for creating, managing, and interacting with zones. 
These zones can be either circle or box, and they can be used for various purposes such as triggers, area-specific effects, or player detection.

## Features

- Define circle or box zones with customizable options.
- Synchronize zones between the server and clients.
- Check if a point is inside any defined zone.
- Debug zones with visual markers or cuboids.
- Add or remove zones dynamically.

## How It Works

- Stores all zones in memory.
- Syncs zones to connected clients when added, removed, or when a player connects.
- Renders debug markers or shapes for zones.
- Checks if a point is inside a zone.

## Usage

### Adding a Circle Zone
Use the `add_circle_zone` function to add a circular zone.

#### Example

```lua
local circle_zone = {
    id = 'circle_1',
    coords = vector3(-254.0, -971.0, 31.22),
    radius = 50.0,
    debug = true
}

utils.zones.add_circle(circle_zone)
```

### Adding a Box Zone
Use the `add_box_zone` function to add a box zone.

#### Example

```lua
local box_zone = {
    id = 'box_1',
    coords = vector3(-254.0, -971.0, 31.22),
    width = 20.0,
    depth = 20.0,
    height = 5.0,
    heading = 0.0,
    debug = true
}

utils.zones.add_box(box_zone)
```

### Removing a Zone
Use the `remove_zone` function to remove a zone by its ID.

#### Example

```lua
utils.zones.remove_zone('circle_1')
```

### Checking if a Point is Inside a Zone
Use the `is_in_zone` function to determine if a given point is inside any defined zone.

#### Example

```lua
local player_coords = GetEntityCoords(PlayerPedId())
local inside_zone = utils.zones.is_in_zone(player_coords)
if inside_zone then
    print("Player is inside a zone.")
else
    print("Player is outside all zones.")
end
```

### Debugging Zones
Enable the `debug` option when adding a zone to render visual markers or shapes for the zone.

#### Example

```lua
local debug_zone = {
    id = 'debug_circle',
    coords = vector3(-254.0, -971.0, 31.22),
    radius = 50.0,
    debug = true
}

utils.zones.add_circle(debug_zone)
```

## Example Workflow

**Objective**: Create a restricted area using zones and alert players when they enter or leave.

### Steps

1. **Define the Zone**:

```lua
local restricted_area = {
    id = 'restricted_zone',
    coords = vector3(100.0, 200.0, 20.0),
    radius = 30.0,
    debug = true
}

utils.zones.add_circle(restricted_area)
```

2. **Check Player Position**:

```lua
CreateThread(function()
    while true do
        local player_coords = GetEntityCoords(PlayerPedId())
        local inside_zone = utils.zones.is_in_zone(player_coords)
        if inside_zone then
            print("You are inside the restricted area.")
        else
            print("You are outside the restricted area.")
        end
        Wait(1000)
    end
end)
```

3. **Remove the Zone When No Longer Needed**:

```lua
utils.zones.remove_zone('restricted_zone')
```