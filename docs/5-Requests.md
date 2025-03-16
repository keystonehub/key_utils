# 5 - API Requests

The Request module provides utility functions to load various in-game assets such as models, interiors, animations, and textures efficiently.

# Client

## request_model(model)
Loads a model and waits until it's fully loaded.

### Parameters:
- **model** *(hash)* - The hash of the model to load.

### Example Usage:
```lua
REQUESTS.request_model(`prop_chair_01a`)
```

---

## request_interior(interior)
Loads an interior and waits until it's ready.

### Parameters:
- **interior** *(number)* - The ID of the interior to load.

### Example Usage:
```lua
local interior = GetInteriorAtCoords(345.6, -1023.4, 29.4)
REQUESTS.request_interior(interior)
```

---

## request_texture(texture, boolean)
Loads a texture dictionary.

### Parameters:
- **texture** *(string)* - The name of the texture dictionary.
- **boolean** *(boolean)* - Whether to wait until the texture is loaded.

### Example Usage:
```lua
REQUESTS.request_texture("commonmenu", true)
```

---

## request_collision(x, y, z)
Loads collision data at a specified coordinate.

### Parameters:
- **x, y, z** *(number)* - The world coordinates to load collision data for.

### Example Usage:
```lua
REQUESTS.request_collision(345.6, -1023.4, 29.4)
```

---

## request_anim(dict)
Loads an animation dictionary.

### Parameters:
- **dict** *(string)* - The name of the animation dictionary.

### Example Usage:
```lua
REQUESTS.request_anim("amb@world_human_seat_wall@male@hands_by_sides@idle_a")
```

---

## request_anim_set(set)
Loads an animation set.

### Parameters:
- **set** *(string)* - The name of the animation set.

### Example Usage:
```lua
REQUESTS.request_anim_set("move_m@drunk@moderatedrunk")
```

---

## request_clip_set(clip)
Loads an animation clip set.

### Parameters:
- **clip** *(string)* - The name of the clip set.

### Example Usage:
```lua
REQUESTS.request_clip_set("move_ped_crouched")
```

---

## request_audio_bank(audio)
Loads a script audio bank.

### Parameters:
- **audio** *(string)* - The name of the audio bank.

### Example Usage:
```lua
REQUESTS.request_audio_bank("MP_MISSION_COUNTDOWN_SOUNDSET")
```

---

## request_scaleform_movie(scaleform)
Loads a scaleform movie and waits until it's loaded.

### Parameters:
- **scaleform** *(string)* - The name of the scaleform movie.

### Returns:
- *(number)* - The handle of the loaded scaleform movie.

### Example Usage:
```lua
local scaleform = REQUESTS.request_scaleform_movie("instructional_buttons")
```

---

## request_cutscene(scene)
Loads a cutscene.

### Parameters:
- **scene** *(string)* - The name of the cutscene.

### Example Usage:
```lua
REQUESTS.request_cutscene("mp_intro_seq_01")
```

---

## request_ipl(str)
Loads an IPL (Interior Proxy Load).

### Parameters:
- **str** *(string)* - The name of the IPL.

### Example Usage:
```lua
REQUESTS.request_ipl("hei_sm_16_interior_v_bahama_milo_")
```

