# License Module

## Overview

The License Module provides a standalone solution for managing player licenses. 
The framework bridges will convert framework licence data into usable utils data.

Currently only qbcore metadata -> utils licences is covered by conversions. ESX and others will follow a.s.a.p.

## What is a License?

A license is a representation of a player's status for specific activities, such as driving, piloting, or any other action requiring eligibility verification. Each license includes test results, timestamps, and optional data.

## What Does the License System Do?

- Initializes default licenses for new players.
- Fetches and updates player license data from the database.
- Tracks the status of theory and practical tests for licenses.
- Provides callbacks and exports for seamless integration with other modules.

## How is This Useful?

- **Standalone**: Works independently of frameworks while supporting integration.
- **Customizability**: Easily define and manage license types and associated logic.
- **Database-Driven**: Persistently stores license data for consistent tracking.

## Usage

### Registering Default Licenses

When a player connects for the first time, their license data is initialized with default values. This ensures all players have the same baseline license structure.

#### Example

```lua
-- Automatically initializes default licenses on player connection.
utils.licences.get(source) -- Fetches license data for the player.
```

### Fetching Licenses

Use the `get_licences` function to retrieve all license data for a player.

#### Example

```lua
local licences_data = utils.licences.get(source)
if licences_data then
    print('Licenses:', json.encode(licences_data))
else
    print('No license data found.')
end
```

### Updating License Status

Update a specific license test (e.g., theory or practical) for a player using `update_licence`.

#### Example

```lua
utils.licences.update(source, 'driving', 'theory', true) -- Marks the theory test for driving as passed.
```

### Checking License Status

Check if a player has passed a specific license test with `check_licence_passed`.

#### Example

```lua
local passed = utils.licences.check_passed(source, 'driving', 'practical')
if passed then
    print('Player has passed the practical test for driving.')
else
    print('Player has not passed the practical test for driving.')
end
```

### Updating Custom License Data

Update additional data associated with a license using `update_data`.

#### Example

```lua
utils.licences.update_data(source, { licence_id = 'driving', licence_data = { points = 5 } })
```

## Example Workflow

**Objective**: A player takes a theory test for a driving license. The server checks if they pass and updates their license accordingly.

### Server

```lua
local function handle_theory_test(source, licence_id, passed)
    if passed then
        utils.licences.update(source, licence_id, 'theory', true)
        print('Theory test passed! License updated.')
    else
        print('Theory test failed. No changes made.')
    end
end

RegisterCommand('take_theory_test', function(source, args)
    local licence_id = args[1]
    local passed = tonumber(args[2]) == 1
    handle_theory_test(source, licence_id, passed)
end)
```

### Client

```lua
-- Fetch all licenses for the player.
utils.licences.get_licences()

-- Check license status.
utils.licences.check_licence('driving', 'theory', function(passed)
    if passed then
        print('You passed the theory test!')
    else
        print('You failed the theory test. Try again!')
    end
end)
```

For further details or assistance, refer to the documentation or contact support via Discord.

