# Environment Module

## Overview

The Environment Module provides utility functions for retrieving and analyzing various in-game environmental details. It is designed for client-side use and offers information such as time, date, weather, seasons, and proximity to water. Customizations allow developers to simulate and interact with environmental data for various gameplay scenarios.

## Features

- Retrieve game time and date in both raw and formatted formats.
- Simulate and determine seasons based on the in-game month.
- Calculate sunrise and sunset times based on weather conditions.
- Check if the current time is daytime.
- Measure the distance from the player to the nearest water body.
- Fetch detailed environmental information, including weather, time, date, and wind details.

## Usage

### Retrieving Game Time

The `get_game_time` function retrieves the current in-game time.

#### Example

```lua
local time_data = utils.environment.get_game_time()
print('Current Time:', time_data.formatted) -- Example output: "12:30"
```

### Retrieving Game Date

The `get_game_date` function retrieves the current in-game date.

#### Example

```lua
local date_data = utils.environment.get_game_date()
print('Current Date:', date_data.formatted) -- Example output: "15/07/2023"
```

### Determining Sunrise and Sunset Times

The `get_sunrise_sunset_times` function provides sunrise and sunset times based on the current weather.

#### Example

```lua
local weather = "CLEAR"
local times = utils.environment.get_sunrise_sunset_times(weather)
print('Sunrise:', times.sunrise) -- Example output: "06:00"
print('Sunset:', times.sunset)   -- Example output: "18:00"
```

### Checking Daytime Status

The `is_daytime` function checks if the current time is considered daytime.

#### Example

```lua
local daytime = utils.environment.is_daytime()
print('Is it daytime?', daytime) -- Example output: true
```

### Determining the Current Season

The `get_current_season` function simulates the current season based on the in-game month.

#### Example

```lua
local season = utils.environment.get_current_season()
print('Current Season:', season) -- Example output: "Summer"
```

### Measuring Distance to Water

The `get_distance_to_water` function calculates the distance from the player to the nearest water body.

#### Example

```lua
local distance = utils.environment.get_distance_to_water()
if distance >= 0 then
    print('Distance to water:', distance)
else
    print('No water nearby.')
end
```

### Retrieving Comprehensive Environment Details

The `get_environment_details` function retrieves detailed information about the environment.

#### Example

```lua
local env_details = utils.environment.get_environment_details()
print('Weather:', env_details.weather)
print('Time:', env_details.time.formatted)
print('Date:', env_details.date.formatted)
print('Season:', env_details.season)
print('Distance to Water:', env_details.distance_to_water)
```

## Example Workflow

**Objective**: Use the environment module to check if it's daytime and display a message accordingly.

### Client-Side Script

```lua
CreateThread(function()
    while true do
        local is_day = utils.environment.is_daytime()
        if is_day then
            print("It's daytime!")
        else
            print("It's nighttime!")
        end
        Wait(10000) -- Check every 10 seconds
    end
end)
```