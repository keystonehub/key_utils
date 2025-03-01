# Character Creation Module

## Overview

The Character Creation Module is designed for building and managing character customization systems. 
It enables the creation of features like clothing stores, character customization builders, and tattoo stores. 
This module works in conjunction with the `utils.styles` shared module.

## Features

- **Custom Appearance Management**: Configure facial features, overlays, tattoos, and clothing.
- **Model Switching**: Switch player models based on character sex.
- **Real-Time Customization**: Adjust and preview character appearance in real-time.
- **Rotatable Ped**: Rotate the character model to view from different angles.
- **Persistent Style Data**: Load and apply saved character data.

## Exports

### Setting Appearance

#### `set_ped_appearance(player, data)`
Applies appearance settings (genetics, hair, overlays, tattoos, clothing) to a ped.

- **Parameters**:
  - `player`: Player's ped instance.
  - `data`: Table containing appearance settings.

### Updating Data

#### `update_ped_data(sex, category, id, value)`
Updates specific parts of the player's appearance data.

- **Parameters**:
  - `sex`: `'m'` or `'f'` to select the ped type.
  - `category`: The category to update (e.g., `genetics`, `barber`).
  - `id`: Identifier for the specific property.
  - `value`: New value to apply.

### Changing Player Model

#### `change_player_ped(sex)`
Switches the player's model based on the specified sex.

- **Parameters**:
  - `sex`: `'m'` for male or `'f'` for female.

### Rotating the Ped

#### `rotate_ped(direction)`
Rotates the ped model in a specified direction.

- **Parameters**:
  - `direction`: One of `'right'`, `'left'`, `'flip'`, or `'reset'`.

### Loading a Character Model

#### `load_character_model(data)`
Loads and applies a complete character model based on provided data.

- **Parameters**:
  - `data`: Table containing character identity, genetics, barber, clothing, and tattoos data.

### Retrieving Clothing and Prop Values

#### `get_clothing_and_prop_values(sex)`
Gets clothing and prop max values for UI inputs.

- **Parameters**:
  - `sex`: `'m'` or `'f'` for the current ped type.
- **Returns**:
  - Table with max values for each clothing and prop item.

## Example Usage

### Apply Appearance
```lua
local appearance_data = {
    genetics = {
        mother = 0,
        father = 1,
        resemblence = 0.5,
        skin = 0.5,
        eye_colour = 2
    },
    barber = {
        hair = 1,
        hair_colour = 0,
        highlight_colour = 1
    },
    clothing = {
        jacket_style = 2,
        jacket_texture = 0
    },
    tattoos = {
        head = { name = "Dragon", hash_m = "tattoo_hash_m", hash_f = "tattoo_hash_f", collection = "tattoo_collection" }
    }
}

local player_ped = PlayerPedId()
utils.character_creation.set_ped_appearance(player_ped, appearance_data)
```

### Change Player Model
```lua
utils.character_creation.change_player_ped('f')
```

### Rotate Ped
```lua
utils.character_creation.rotate_ped('right')
```

### Load Character Model
```lua
local character_data = {
    identity = { sex = 'm' },
    style = {
        genetics = { mother = 0, father = 1, resemblence = 0.5, skin = 0.5, eye_colour = 2 },
        barber = { hair = 1, hair_colour = 0, highlight_colour = 1 },
        clothing = { jacket_style = 2, jacket_texture = 0 },
        tattoos = { head = { name = "Dragon", hash_m = "tattoo_hash_m", hash_f = "tattoo_hash_f", collection = "tattoo_collection" } }
    }
}
utils.character_creation.load_character_model(character_data)
```

### Update Ped Data
```lua
utils.character_creation.update_ped_data('m', 'barber', 'hair_colour', 3)
```