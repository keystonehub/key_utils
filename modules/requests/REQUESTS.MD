# Requests Module

## Overview

The Requests Module provides utility wrapper functions for native FiveM "request" functions. 
These wrappers streamline the required logic.

## What Does the Requests Module Do?

- Loads models, animations, textures, and other resources into memory.

## How is This Useful?

- **Reduced Code Duplication**: Encapsulates common loading logic into reusable functions.

## Usage

### Requesting a Model

Use the `request_model` function to load a model into memory.

#### Example

```lua
local model = GetHashKey('a_m_y_hipster_01')
utils.requests.model(model)
```

### Requesting an Animation Dictionary

Use the `request_anim` function to load an animation dictionary.

#### Example

```lua
utils.requests.anim('amb@world_human_aa_smoke@male@base')
```

### Requesting a Texture Dictionary

Use the `request_texture` function to load a texture dictionary.

#### Example

```lua
utils.requests.texture('commonmenu', true)
```

### Requesting an Interior

Use the `request_interior` function to load an interior.

#### Example

```lua
local interior_id = GetInteriorAtCoords(440.84, -983.14, 30.69)
utils.requests.interior(interior_id)
```

### Requesting Collision at Coordinates

Use the `request_collision` function to ensure collision is loaded for a specific location.

#### Example

```lua
utils.requests.collision(440.84, -983.14, 30.69)
```

### Requesting an Animation Set

Use the `request_anim_set` function to load an animation set.

#### Example

```lua
utils.requests.anim_set('move_m@brave')
```

### Requesting a Clip Set

Use the `request_clip_set` function to load an animation clip set.

#### Example

```lua
utils.requests.clip_set('move_m@confident')
```

### Requesting a Script Audio Bank

Use the `request_audio_bank` function to load a script audio bank.

#### Example

```lua
utils.requests.audio_bank('DLC_HEISTS_GENERAL_FRONTEND_SOUNDS')
```

### Requesting a Scaleform Movie

Use the `request_scaleform_movie` function to load a scaleform movie.

#### Example

```lua
local scaleform_handle = utils.requests.scaleform_movie('instructional_buttons')
```

### Requesting a Cutscene

Use the `request_cutscene` function to load a cutscene.

#### Example

```lua
utils.requests.cutscene('example_cutscene_name')
```

### Requesting an IPL

Use the `request_ipl` function to load an IPL (Interior Proxy Library).

#### Example

```lua
utils.requests.ipl('hei_bi_hw1_13_door')
```

## Example Workflow

**Objective**: Spawn a ped with a weapon and animation in a specific interior.

### Workflow

1. **Request Assets**:

```lua
local model = GetHashKey('a_m_y_hipster_01')
local anim_dict = 'amb@world_human_aa_smoke@male@base'
local interior_id = GetInteriorAtCoords(440.84, -983.14, 30.69)

utils.requests.model(model)
utils.requests.anim(anim_dict)
utils.requests.interior(interior_id)
```

2. **Create and Set Up the Ped**:

```lua
local ped = CreatePed(4, model, 440.84, -983.14, 30.69, 0.0, false, true)
TaskPlayAnim(ped, anim_dict, 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
```

3. **Ensure Everything is Loaded**:

```lua
utils.requests.collision(440.84, -983.14, 30.69)
```

For further details or assistance, refer to the documentation or contact support via Discord.