# 5 - API Characters

The Characters module is responsible for handling player customization, including styles, genetics, clothing, and tattoos. 
It provides various functions to manage and modify character appearance.

## Character Data

The system includes predefined mappings for:
- **Facial Features** (e.g., nose width, eyebrow height, lip thickness)
- **Overlays** (e.g., tattoos, makeup, scars)
- **Clothing Items** (e.g., shirts, pants, hats, accessories)

# Client

## get_style(sex)
Retrieves the default style settings for the specified sex (`m` or `f`).

### Parameters:
- **sex** *(string)* - "m" or "f".

### Example Usage:
```lua
local style = CHARACTERS.get_style("m")
```

---

## reset_styles()
Resets character styles to default values.

### Example Usage:
```lua
CHARACTERS.reset_styles()
```

---

## get_clothing_and_prop_values(sex)
Retrieves maximum values for clothing and props based on sex.

### Parameters:
- **sex** *(string)* - "m" or "f".

### Example Usage:
```lua
local values = CHARACTERS.get_clothing_and_prop_values("m")
```

---

## set_ped_appearance(player, data)
Applies a complete character appearance update.

### Parameters:
- **player** *(number)* - The player's ped instance.
- **data** *(table)* - Character customization data.

### Example Usage:
```lua
CHARACTERS.set_ped_appearance(PlayerPedId(), player_data)
```

---

## update_ped_data(sex, category, id, value)
Updates the player's character data dynamically.

### Parameters:
- **sex** *(string)* - "m" or "f".
- **category** *(string)* - Type of customization (e.g., "barber", "clothing").
- **id** *(string)* - Specific attribute being updated.
- **value** *(any)* - The new value.

### Example Usage:
```lua
CHARACTERS.update_ped_data("m", "barber", "hair", 5)
```

---

## change_player_ped(sex)
Switches the player's ped model based on sex.

### Parameters:
- **sex** *(string)* - "m" or "f".

### Example Usage:
```lua
CHARACTERS.change_player_ped("f")
```

---

## rotate_ped(direction)
Rotates the player's ped in a specific direction.

### Parameters:
- **direction** *(string)* - "right", "left", "flip", or "reset".

### Example Usage:
```lua
CHARACTERS.rotate_ped("right")
```

---

## load_character_model(data)
Loads a full character model with all saved appearance data.

### Parameters:
- **data** *(table)* - Character appearance data.

### Example Usage:
```lua
CHARACTERS.load_character_model(saved_data)
```