# Modules

## Overview

The modules in `fivem_utils` are designed to be highly modular and independent. Each module can be used independently via exports or collectively by retrieving all available modules. This ensures flexibility in integration, whether you're using specific features or the entire library.

## Features

- **Independent Usage**: Use any module individually with exports.
- **Collective Loading**: Load all modules at once if needed.
- **Shared Modules**: Some modules, like `shared`, provide base functionality for both server and client.
- **Custom Framework Bridges**: Add support for new frameworks by extending `init.lua`.

## Usage

### Accessing Modules

You can access individual modules using the following syntax:

```lua
local module_name = exports.fivem_utils:get_module('module_name')
```

Alternatively, you can retrieve all modules at once:

```lua
local all_modules = exports.fivem_utils:get_modules()
```

### Shared and Server Integration

If modules include any shared functions you should setup the module accordingly.
Here's an example using the `timestamps` module:

#### Shared Module

The shared portion initializes the base functionality.

```lua
--- Shared loader for timestamps.
local timestamps = {}

--- Get the current time for logging.
--- @return string: The formatted current time in 'YYYY-MM-DD HH:MM:SS' format.
local function get_current_time()
    local is_server = IsDuplicityVersion() and 'server' or 'client'
    return is_server and os.date('%Y-%m-%d %H:%M:%S') or (string.format('%04d-%02d-%02d %02d:%02d:%02d', GetLocalTime()) or "0000-00-00 00:00:00")
end

exports('get_current_time', get_current_time)
timestamps.get_current_time = get_current_time

return timestamps
```

#### Server-Side Extension

On the server, the shared module is extended by adding duplicity-specific functions.

```lua
--- Get shared loader to construct.
local timestamps = utils.get_module('timestamps')

--- Add duplicity-specific functions.
local function get_server_timestamp()
    local ts = os.time()
    return {
        timestamp = ts,
        formatted = os.date('%Y-%m-%d %H:%M:%S', ts)
    }
end

exports('get_server_timestamp', get_server_timestamp)
timestamps.get_server_timestamp = get_server_timestamp

--- Attach extended module back to utils.
utils.timestamps = timestamps
```

### Priority Loading and Framework Bridges

You can define priority loading for specific modules and include additional framework bridges in `init.lua`. 

#### Example

```lua
--- Frameworks available for detection and loading framework bridges.
--- @type table<number, string>: An array of framework resource names.
local FRAMEWORKS <const> = { 
    'boii_core', 
    'es_extended', 
    'ox_core', 
    'qb-core' 
}

--- Modules to be loaded with priority before others.
--- @type table<number, string>: An array of priority module names.
local PRIORITY_MODULES <const> = { 
    'callbacks',
    'commands'
}
```

## Notes

- Always attach extended functionality back to the shared module to ensure consistency across the system.
- Use `PRIORITY_MODULES` in `init.lua` to control the loading order of critical modules.
- Adding new framework bridges can be done by extending the `FRAMEWORKS` table in `init.lua`.

For further details or assistance, refer to the documentation or contact support via Discord.