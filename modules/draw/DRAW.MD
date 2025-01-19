# Draw Module

## Overview

The Draw Module provides utility functions for handling rendering of text, shapes, and other elements on the screen or in the world. 

## Features

- Draw 2D and 3D text with advanced customization.
- Render 3D cuboids and rotated boxes.
- Display BINK movies and Scaleform movies.
- Draw interactive sprites and polygonal sprites.
- Create lights with customizable colors and shadows.

## Usage

### Drawing Text

The `draw_text` function renders text with customizable properties such as position, scale, color, alignment, and mode (2D or 3D).

#### Example

```lua
local params = {
    coords = vector3(0.5, 0.5, 0.0),
    content = 'Hello, world!',
    scale = 0.5,
    colour = {255, 255, 255, 255},
    font = 4,
    alignment = 'center',
    mode = '2d'
}
utils.draw.draw_text(params)
```

### Drawing 3D Cuboids

The `draw_3d_cuboid` function visualizes a 3D box at a specified location with defined dimensions and color.

#### Example

```lua
local center = vector3(0.0, 0.0, 0.0)
local dimensions = { width = 2.0, length = 3.0, height = 1.5 }
local heading = 0.0
local colour = {255, 0, 0, 255}
utils.draw.draw_3d_cuboid(center, dimensions, heading, colour)
```

### Rendering BINK Movies

The `draw_movie` function plays a BINK movie on the screen.

#### Example

```lua
local params = {
    bink = some_bink_handle,
    coords = {x = 0.5, y = 0.5},
    scale = {x = 1.0, y = 1.0},
    rotation = 0.0,
    colour = {255, 255, 255, 255}
}
utils.draw.draw_movie(params)
```

### Displaying Interactive Sprites

The `draw_interactive_sprite` function renders a sprite that can be interacted with.

#### Example

```lua
local params = {
    texture_dict = 'commonmenu',
    texture_name = 'interaction_bgd',
    coords = vector3(0.5, 0.5, 0.0),
    size = {width = 0.1, height = 0.1},
    rotation = 0.0,
    colour = {255, 255, 255, 255}
}
utils.draw.draw_interactive_sprite(params)
```

### Drawing Polygons

The `draw_sprite_poly` function creates a polygonal sprite in the world.

#### Example

```lua
local params = {
    vertices = {
        vector3(0.0, 0.0, 0.0),
        vector3(1.0, 0.0, 0.0),
        vector3(0.5, 1.0, 0.0)
    },
    texture_dict = 'deadline',
    texture_name = 'deadline_trail',
    colour = {255, 0, 0, 255}
}
utils.draw.draw_sprite_poly(params)
```

## Example Workflow

**Objective**: Continuously display a player's coordinates on the screen.

### Client-Side Script

```lua
CreateThread(function()
    while true do
        local player_coords = GetEntityCoords(PlayerPedId())
        utils.draw.draw_text({
            coords = vector3(0.5, 0.1, 0.0),
            content = string.format('Your Coordinates: ~b~%.2f, %.2f, %.2f~s~', player_coords.x, player_coords.y, player_coords.z),
            scale = 0.4,
            colour = {255, 255, 255, 255},
            font = 4,
            alignment = 'center',
            mode = '2d'
        })
        Wait(0) -- Keep updating every frame
    end
end)
```

### Notes

- This module uses `utils.geometry` and `utils.requests`. Ensure these modules are available in your project.