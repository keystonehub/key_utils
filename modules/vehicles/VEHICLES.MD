# Vehicles Module

## Overview

The Vehicles Module utility functions for retrieving, modifying, and customizing vehicles in the game. 
Mainly useful for creating vehicle customization scripts, vehicle stores, and similar functionalities.

---

## Features

- **Vehicle Details**: Retrieve vehicle plate, model, class, and properties.
- **Customization**: Get and apply vehicle mods, colors, and extras.
- **Damage and Maintenance**: Retrieve the status of windows, doors, tires, and maintenance properties.
- **Vehicle Creation**: Spawn vehicles with extensive customization options.

---

## Functions

### `get_vehicle_plate(vehicle)`
Retrieves the license plate of a vehicle.
```lua
local plate = utils.vehicles.get_vehicle_plate(vehicle)
print('Plate:', plate)
```

---

### `get_vehicle_model(vehicle)`
Retrieves the model name of a vehicle.
```lua
local model = utils.vehicles.get_vehicle_model(vehicle)
print('Model:', model)
```

---

### `get_doors_broken(vehicle)`
Gets the status of the vehicle's doors.
```lua
local doors = utils.vehicles.get_doors_broken(vehicle)
for door_id, broken in pairs(doors) do
    print('Door', door_id, broken and 'Broken' or 'Intact')
end
```

---

### `get_windows_broken(vehicle)`
Gets the status of the vehicle's windows.
```lua
local windows = utils.vehicles.get_windows_broken(vehicle)
for window_id, broken in pairs(windows) do
    print('Window', window_id, broken and 'Broken' or 'Intact')
end
```

---

### `get_tyre_burst(vehicle)`
Retrieves the status of the vehicle's tires.
```lua
local tires = utils.vehicles.get_tyre_burst(vehicle)
for tire_id, burst in pairs(tires) do
    print('Tire', tire_id, burst and 'Burst' or 'Intact')
end
```

---

### `get_vehicle_extras(vehicle)`
Gets the status of the extras on a vehicle.
```lua
local extras = utils.vehicles.get_vehicle_extras(vehicle)
for extra_id, enabled in pairs(extras) do
    print('Extra', extra_id, enabled and 'Enabled' or 'Disabled')
end
```

---

### `get_vehicle_properties(vehicle)`
Retrieves various properties of a vehicle.
```lua
local properties = utils.vehicles.get_vehicle_properties(vehicle)
print('Plate:', properties.plate)
print('Primary Color:', properties.color1)
```

---

### `spawn_vehicle(vehicle_data)`
Spawns a vehicle with the specified properties and modifications.
#### Example
```lua
local vehicle_data = {
    model = 'adder',
    coords = vector4(-75.0, -820.0, 326.0, 0.0),
    custom_plate = 'CUSTOM1',
    maintenance = { fuel = 80.0, engine = 900.0 },
    mods = {
        custom_paint = {
            primary = { r = 255, g = 0, b = 0 },
            secondary = { r = 0, g = 255, b = 0 }
        },
        bulletproof_tyres = true
    }
}
local vehicle = utils.vehicles.spawn_vehicle(vehicle_data)
```

---

## Usage Workflow

**Objective**: Retrieve vehicle details and customize the player's current vehicle.

### Script Example

```lua
local function spawn_vehicle()
    local player_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    
    if player_vehicle then
        -- Retrieve details
        local plate = utils.vehicles.get_vehicle_plate(player_vehicle)
        local model = utils.vehicles.get_vehicle_model(player_vehicle)
        print('Vehicle Plate:', plate)
        print('Vehicle Model:', model)

        -- Apply customization
        local custom_data = {
            mods = {
                custom_paint = {
                    primary = { r = 50, g = 150, b = 200 },
                },
                xenon_lights = {
                    colour = 2
                }
            }
        }
        utils.vehicles.spawn_vehicle(custom_data)
    else
        print('No vehicle found.')
    end
end
```