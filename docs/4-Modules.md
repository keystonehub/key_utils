# 4 - Modules

The library is devided into useful `modules` you can import into your resource through the export `exports.key_utils:require(...)` or by adding `@key_utils/init.lua` into your manifest and using the `require(...)` function directly.

A CFX friendly require function has been included into the `init.lua` to handle overriding the default require function.

# Available Modules

Below is a quick list of all current available modules and a brief description of what the module can do.
For more detailed instructions on whats available in each module view **5-API-Reference.md**

## Bridges

Bridges allow seamless integration with multiple resources through a single API, reducing the need for writing framework-specific code.  
They detect available resources and route accordingly, making scripts more flexible and future-proof.

- **Framework Bridge:** Supported by default; `"esx", "keystone", "nd", "ox", "qb", "qbx"`.
- **DrawText UI Bridge:** Supported by default; `"default", "boii", "esx", "okok", "ox", "qb"`.
- **Notifications Bridge:** Supported by default; `"default", "boii", "esx", "okok", "ox", "qb"`.

## Standalone Replacement Systems

These systems are designed to replace framework-locked features, allowing resources to function independently of any specific core.  
They also provide a solution for supporting servers that lack certain mechanics.

- **Callbacks:** Unified callback system to replace framework-specific handlers.  
- **Commands:** Database-based command system with configurable permissions.  
- **Item Registry:** Standalone item system for managing usable items.  
- **Licence System:** Full licence handling, including theory/practical tests, points, and revocation.  
- **Player XP:** Leveling and experience system with growth factors and max levels.

## Other Modules

- **Characters:** A unique module covering everything related to character creation/customisation, including shared styles data.
- **Cooldowns:** Allows for setting player-specific, resource-based, or global cooldowns throughout the game world.
- **Debugging:** A set of useful debugging functions to aid development and troubleshooting.
- **Entities:** Covers everything related to entities (NPCs, vehicles, objects) within the game world.
- **Environment:** Functions to handle environmental elements such as time, weather, and simulated seasons.
- **Geometry:** A suite of functions to simplify geometric calculations in both 2D and 3D space.
- **Keys:** Provides a full static key list and functions for retrieving keys by name or value.
- **Maths:** Extends base `math.` functionality with additional useful mathematical functions.
- **Player:** Includes various player-related functions such as retrieving the player's cardinal direction or playing animations with prop support.
- **Requests:** Wrapper functions around CFX `Request` functions to simplify resource requests.
- **Scope:** Functions to manage player scopes, useful for proximity-based systems.
- **Strings:** Extends base `string.` functionality by adding additional helper functions.
- **Tables:** Enhances base `table.` functionality by providing additional utility functions.
- **Timestamps:** Handles everything related to server-side timestamps with formatted responses.
- **Vehicles:** A comprehensive suite of vehicle-related functions, covering all aspects needed for a vehicle customization system.
- **Version:** Provides resource version checking from an externally hosted `.json` file.

# Importing Modules

You can use the following methods in client/server/shared files to access the modules:

## Exports

```lua
local CALLBACKS <const> = exports.key_utils:require("modules.callbacks")
```

## require(...)

Adding `@key_utils/init.lua` into your `fxmanifest.lua` will allow access to the librarys `require(...)` function.
You can add this into any context where it is required however for ease of use `shared_script "@key_utils/init.lua"` is usually the best path.

```lua
local CALLBACKS <const> = require("modules.callbacks")
```

# Using Modules

Once you have imported a module it is ready to be used.
Below is a quick example of using the `callbacks` module. 

## Server

```lua
local CALLBACKS <const> = exports.key_utils:require("modules.callbacks")

CALLBACKS.register("some_event_name", function(source, data, cb)
    if source == 0 then 
        cb(false, "Callback must be triggered by a player!")
        return
    end
    cb(true, "Callback successful!")
end)
```

## Client

```lua
local CALLBACKS <const> = exports.key_utils:require("modules.callbacks")

CALLBACKS.trigger("some_event_name", nil, function(success, message)
    local success_text = success and "Success!" or "Failed!"
    print(("Callback %s Message: %s"):format(success_text, message)) 
    -- Output: "Callback Success! Message: Callback successful!" or "Callback Failed! Message: Callback must be triggered by a player!
end)
```

# Require Modules

Reminder: You can use `exports.key_utils:require(...)` or `require(...)`. 
To use `require` you need to add `@key_utils/init.lua` into your `fxmanifest.lua`.

```lua
require("modules.core") -- Framework Bridge
require("modules.notifications") -- Notifications Bridge
require("modules.drawtext") -- DrawText UI Bridge
require("modules.callbacks") -- Callbacks System
require("modules.characters") -- Character Customisation
require("modules.commands") -- Commands System
require("modules.debugging") -- Debugging Utilities
require("modules.entities") -- Entity Management
require("modules.environment") -- Environment Functions
require("modules.geometry") -- Geometry Calculations
require("modules.items") -- Item Registry
require("modules.keys") -- Key Management
require("modules.licences") -- Licence System
require("modules.maths") -- Extended Maths Functions
require("modules.player") -- Player Utilities
require("modules.requests") -- Request Handlers
require("modules.scope") -- Player Scope Management
require("modules.strings") -- Extended String Functions
require("modules.tables") -- Extended Table Functions
require("modules.timestamps") -- Timestamp Utilities
require("modules.vehicles") -- Vehicle Management
require("modules.version") -- Version Checking
require("modules.xp") -- XP System
```