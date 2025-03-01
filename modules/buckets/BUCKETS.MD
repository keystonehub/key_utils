# Buckets Module

## Overview

The Buckets Module provides tools for managing FiveM routing buckets, allowing for separation of players and entities into isolated worlds. 
This can be useful for implementing instances, events, or private spaces.

## Features

- Assign players to specific buckets with configurable settings.
- Retrieve information about buckets, such as players within them.
- Temporarily move players to a different bucket for a specified duration.
- Control population and lockdown modes for buckets.

## Exports

### Set Player Bucket

**Function:** `set_player_bucket`

**Description:** Sets a player into a specific bucket and applies the provided settings.

#### Example
```lua
utils.buckets.set_player_bucket(1, {
    bucket_id = 100,
    enable_population = true,
    lockdown_mode = false,
    max_players = 50,
    spawn_coords = vector3(200.0, 200.0, 30.0)
})
```

---

### Get Bucket Settings

**Function:** `get_bucket_settings`

**Description:** Retrieves settings for a specific bucket.

#### Parameters:
- `bucket_id` *(number)*: The ID of the bucket.

#### Returns:
- *(table)*: Settings for the specified bucket.

#### Example
```lua
local settings = utils.buckets.get_bucket_settings(100)
print(settings.max_players)
```

---

### Get Players in Bucket

**Function:** `get_players_in_bucket`

**Description:** Retrieves all players in a specific bucket.

#### Example
```lua
local players = utils.buckets.get_players_in_bucket(100)
for _, player_id in ipairs(players) do
    print("Player ID:", player_id)
end
```

---

### Temporary Bucket Assignment

**Function:** `temp_bucket`

**Description:** Temporarily moves a player to a specified bucket for a duration, then returns them to their original bucket.

#### Parameters:
- `player_id` *(number)*: The server ID of the player.
- `temporary_bucket_id` *(number)*: The temporary bucket ID to move the player to.
- `duration` *(number)*: Duration in seconds for the temporary assignment.

#### Example
```lua
utils.buckets.temp_bucket(1, 200, 60)
```