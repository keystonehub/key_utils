# Skills Module

## Overview

The Skills Module provides functionality for managing player skills. 
It offers an alternative for frameworks without a built-in skill system or an alternative to framework implementations.

## Features

- **Experience Points (XP):** Manage XP and levels for player skills.
- **Leveling System:** Supports custom XP growth factors and maximum levels.
- **Standalone Compatibility:** Works without reliance on specific frameworks.

## Server Functions

### Adding or Modifying Skill Data

Modify a player's skill data, including XP and levels.

#### Example

```lua
local player_id = 1
local skill_name = 'strength'
local xp_value = 100
local operation = 'add' -- options: 'add', 'remove', 'set'

utils.skills.modify_skill(player_id, skill_name, xp_value, operation)
```

### Fetching All Skills

Retrieve all skills for a specific player.

#### Example

```lua
local player_id = 1
local skills_data = utils.skills.get_skills(player_id)
print(json.encode(skills_data))
```

### Fetching a Specific Skill

Retrieve data for a specific skill.

#### Example

```lua
local player_id = 1
local skill_name = 'strength'
local skill_data = utils.skills.get_skill(player_id, skill_name)
print(json.encode(skill_data))
```

### Calculating Required XP for Level Up

Calculate the XP needed for the next level of a skill.

#### Example

```lua
local current_level = 5
local first_level_xp = 1000
local growth_factor = 1.5

local required_xp = utils.skills.calculate_required_xp(current_level, first_level_xp, growth_factor)
print('Required XP: ' .. required_xp)
```

## Client Functions

### Retrieving All Skills

Fetch all skill data for the player.

#### Example

```lua
utils.skills.get_skills(function(skills_data)
    if skills_data then
        print(json.encode(skills_data))
    else
        print('Failed to fetch skills data.')
    end
end)
```

### Retrieving Specific Skill Data

Retrieve details for a specific skill.

#### Example

```lua
local skill_name = 'strength'
utils.skills.get_skill(skill_name, function(skill_data)
    if skill_data then
        print(json.encode(skill_data))
    else
        print('Skill data not found.')
    end
end)
```

## Example Workflow

**Objective:** Implement a skill progression system for a "fishing" skill.

### Setup

1. **Define Skill in Utils Configuration:**

```lua
config.skills['fishing'] = {
    level = 1,
    start_xp = 0,
    first_level_xp = 500,
    growth_factor = 1.2,
    max_level = 10
}
```

2. **Modify Skill on Fishing Success:**

```lua
local player_id = 1
local skill_name = 'fishing'
local xp_gained = 50

utils.skills.modify_skill(player_id, skill_name, xp_gained, 'add')
```

3. **Display Skill Progress:**

```lua
utils.skills.get_skill('fishing', function(skill_data)
    if skill_data then
        print(('Fishing Level: %d | XP: %d/%d'):format(skill_data.level, skill_data.current_xp, skill_data.required_xp))
    end
end)
```

4. **Level Up Logic:**

Automatically handled in `modify_skill`. Players gain levels once their XP exceeds the required XP.

## Notes

- Ensure the database table `player_skills` exists with the appropriate schema.
- This system is framework-agnostic but includes helper functions to integrate with framework-specific identifiers.