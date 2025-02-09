# Developer Module

## Overview

The Developer Module provides toggleable display functions to render useful information on screen. 

## Features

- Toggle display of player coordinates in multiple formats.
- Display detailed vehicle information.
- Show player-specific information such as health, armor, and model details.
- Render environmental data like time, weather, and location.

## Exports

### Toggle Player Coordinates

**Function:** `toggle_coords`

**Description:** Toggles the display of the player’s current coordinates in various formats (vector2, vector3, vector4).

#### Example
```lua
utils.developer.toggle_coords()
```

---

### Toggle Vehicle Information

**Function:** `toggle_vehicle_info`

**Description:** Toggles the display of detailed vehicle information, including speed, health, and model data. Displays only when the player is inside a vehicle.

#### Example
```lua
utils.developer.toggle_vehicle_info()
```

---

### Toggle Player Information

**Function:** `toggle_player_info`

**Description:** Displays detailed player data, such as stamina, health, armor, coordinates, and model information.

#### Example
```lua
utils.developer.toggle_player_info()
```

---

### Toggle Environment Information

**Function:** `toggle_environment_info`

**Description:** Shows information about the environment, including in-game time, weather states, cardinal direction, and street name.

#### Example
```lua
utils.developer.toggle_environment_info()
```