# 5 - API Environment

The Environment module provides various utility functions to retrieve information about the game world, such as weather, time, seasons, and environmental conditions.

# Client

## get_weather_name(hash)
Retrieves the human-readable name of the weather from its hash.

### Parameters:
- **hash** *(number)* - The hash key of the weather type.

### Returns:
- *(string)* - The human-readable name of the weather.

### Example Usage:
```lua
local weather = ENVIRONMENT.get_weather_name(GetPrevWeatherTypeHashName())
print("Current Weather:", weather)
```

---

## get_game_time()
Retrieves the current in-game time.

### Returns:
- *(table)* - Contains raw time data `{hour, minute}` and formatted string `HH:MM`.

### Example Usage:
```lua
local time = ENVIRONMENT.get_game_time()
print("In-Game Time:", time.formatted)
```

---

## get_game_date()
Retrieves the current in-game date.

### Returns:
- *(table)* - Contains raw date data `{day, month, year}` and formatted string `DD/MM/YYYY`.

### Example Usage:
```lua
local date = ENVIRONMENT.get_game_date()
print("In-Game Date:", date.formatted)
```

---

## get_sunrise_sunset_times(weather)
Retrieves estimated sunrise and sunset times based on the current weather.

### Parameters:
- **weather** *(string)* - The current weather type.

### Returns:
- *(table)* - `{sunrise, sunset}` times in `HH:MM` format.

### Example Usage:
```lua
local times = ENVIRONMENT.get_sunrise_sunset_times("CLEAR")
print("Sunrise:", times.sunrise, "Sunset:", times.sunset)
```

---

## is_daytime()
Checks if the current time is daytime.

### Returns:
- *(boolean)* - `true` if daytime, `false` otherwise.

### Example Usage:
```lua
if ENVIRONMENT.is_daytime() then
    print("It's daytime.")
else
    print("It's nighttime.")
end
```

---

## get_current_season()
Retrieves the current season based on the in-game month.

### Returns:
- *(string)* - The name of the current season (`Winter`, `Spring`, `Summer`, `Autumn`).

### Example Usage:
```lua
print("Current Season:", ENVIRONMENT.get_current_season())
```

---

## get_distance_to_water()
Retrieves the distance from the player to the nearest water body.

### Returns:
- *(number)* - The distance to the nearest water body, or `-1` if none found.

### Example Usage:
```lua
print("Distance to Water:", ENVIRONMENT.get_distance_to_water())
```

---

## get_zone_scumminess()
Retrieves the scumminess level of the player's current zone.

### Returns:
- *(integer)* - The scumminess level (0-5) or `-1` if unknown.

### Example Usage:
```lua
print("Zone Scumminess:", ENVIRONMENT.get_zone_scumminess())
```

---

## get_ground_material()
Retrieves the ground material type at the player's position.

### Returns:
- *(number)* - The ground material hash.

### Example Usage:
```lua
print("Ground Material Hash:", ENVIRONMENT.get_ground_material())
```

---

## get_wind_direction()
Retrieves the wind direction as a readable compass value.

### Returns:
- *(string)* - Compass direction (`N`, `NE`, `E`, `SE`, `S`, `SW`, `W`, `NW`).

### Example Usage:
```lua
print("Wind Direction:", ENVIRONMENT.get_wind_direction())
```

---

## get_altitude()
Retrieves the player's altitude above sea level.

### Returns:
- *(number)* - Altitude value.

### Example Usage:
```lua
print("Current Altitude:", ENVIRONMENT.get_altitude())
```

---

## get_environment_details()
Retrieves a structured summary of the current environment conditions.

### Returns:
- *(table)* - A detailed table containing:
  - **weather** *(string)* - Current weather name.
  - **time** *(table)* - `{hour, minute}`
  - **date** *(table)* - `{day, month, year}`
  - **season** *(string)* - Current season.
  - **sunrise_sunset** *(table)* - `{sunrise, sunset}`
  - **is_daytime** *(boolean)* - `true` or `false`
  - **distance_to_water** *(number)* - Distance to nearest water.
  - **scumminess** *(integer)* - Scumminess level.
  - **ground_material** *(number)* - Ground material hash.
  - **rain_level** *(number)* - Rain intensity.
  - **wind_speed** *(number)* - Wind speed.
  - **wind_direction** *(string)* - Compass direction of wind.
  - **snow_level** *(number)* - Snow intensity.
  - **altitude** *(number)* - Player altitude.

### Example Usage:
```lua
local env_details = ENVIRONMENT.get_environment_details()
print(json.encode(env_details, { indent = true }))
```