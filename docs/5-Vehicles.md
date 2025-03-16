# 5 - API Vehicles

The Vehicles module provides utility functions for retrieving vehicle details, checking damage status, and handling vehicle modifications.

# Client

## get_vehicle_plate(vehicle)
Retrieves the license plate number of a vehicle.

### Parameters:
- **vehicle** *(number)* - The handle of the vehicle.

### Returns:
- *(string)* - The license plate text, trimmed of whitespace.

### Example Usage:
```lua
local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
local plate = VEHICLES.get_vehicle_plate(vehicle)
print("Vehicle Plate:", plate)
```
---

## get_vehicle_model(vehicle)
Retrieves the model name of a vehicle.

### Parameters:
- **vehicle** *(number)* - The handle of the vehicle.

### Returns:
- *(string)* - The lowercase model name of the vehicle.

### Example Usage:
```lua
local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
local model = VEHICLES.get_vehicle_model(vehicle)
print("Vehicle Model:", model)
```
---

## get_doors_broken(vehicle)
Retrieves a list of broken doors of a vehicle.

### Parameters:
- **vehicle** *(number)* - The handle of the vehicle.

### Returns:
- *(table)* - A table indicating which doors are damaged.

### Example Usage:
```lua
local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
local doors_broken = VEHICLES.get_doors_broken(vehicle)
for door, is_broken in pairs(doors_broken) do
    print("Door", door, "Broken:", is_broken)
end
```
---

## get_vehicle_details(use_current_vehicle)
Retrieves detailed information about a vehicle.

### Parameters:
- **use_current_vehicle** *(boolean)* - Specifies whether to use the vehicle the player is currently in.

### Returns:
- *(table)* - A table containing vehicle details, including:
  - **vehicle** *(number)* - The vehicle handle.
  - **plate** *(string)* - The vehicle's plate.
  - **model** *(string)* - The vehicle's model.
  - **doors_broken** *(table)* - A list of broken doors.

### Example Usage:
```lua
local vehicle_data = VEHICLES.get_vehicle_details(true)
if vehicle_data then
    print("Vehicle Model:", vehicle_data.model)
    print("Plate:", vehicle_data.plate)
end
```