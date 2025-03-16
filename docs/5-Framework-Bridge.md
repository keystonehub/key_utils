# 5 - API Framework Bridge

This file is rather long, as the library is quite extensive.
You can use this file as a guide throughout development until you are consistent with the available API.

# Framework Bridge

You can access the bridge functions through `require("modules.core")`.

```lua
local CORE <const> = require("modules.core")

local players = CORE.get_players()
```

## Server

### get_players()
Retrieves all players for the active framework.

```lua
local players = CORE.get_players()
```

### get_player(source)
Retrieves player data based on the framework.

```lua
local player_data = CORE.get_player(1)
```

### get_id_params(source)
Prepares query parameters for database operations.

```lua
local query, params = CORE.get_id_params(1)
```

### get_player_id(source)
Retrieves the player's unique identifier.

```lua
local player_id = CORE.get_player_id(1)
```

### get_identity(source)
Retrieves a player's identity information.

```lua
local identity = CORE.get_identity(1)
```

### get_inventory(source)
Retrieves a player's inventory data.

```lua
local inventory = CORE.get_inventory(1)
```

### get_item(source, item_name)
Retrieves a specific item from the player's inventory.

```lua
local item = CORE.get_item(1, "water")
```

### has_item(source, item_name, item_amount)
Checks if a player has a specific item in their inventory.

```lua
local hasWater = CORE.has_item(1, "water", 2)
```

### add_item(source, item_id, amount, data)
Adds an item to a player's inventory.

```lua
CORE.add_item(1, "water", 5)
```

### remove_item(source, item_id, amount)
Removes an item from a player's inventory.

```lua
CORE.remove_item(1, "water", 2)
```

### get_balances(source)
Retrieves all balances of a player.

```lua
local balances = CORE.get_balances(1)
```

### get_balance_by_type(source, balance_type)
Retrieves a specific balance of a player by type.

```lua
local cash_balance = CORE.get_balance_by_type(1, "cash")
```

### add_balance(source, balance_type, amount)
Adds money to a player's balance.

```lua
CORE.add_balance(1, "cash", 100)
```

### remove_balance(source, balance_type, amount)
Removes money from a player's balance.

```lua
CORE.remove_balance(1, "cash", 50)
```

### get_player_jobs(source)
Retrieves a player's job(s) and duty status.

```lua
local jobs = CORE.get_player_jobs(1)
```

### player_has_job(source, job_names)
Checks if a player has a specific job.

```lua
local isPolice = CORE.player_has_job(1, {"police"})
```

### count_players_by_job(job_names, check_on_duty)
Counts players with a specific job.

```lua
local total, on_duty = CORE.count_players_by_job({"police"}, true)
```

### get_player_job_name(source)
Returns a player's job name.

```lua
local job_name = CORE.get_player_job_name(1)
```

### adjust_statuses(source, statuses)
Modifies a player's server-side statuses.

```lua
CORE.adjust_statuses(1, {hunger = {add = {min = 5, max = 10}}})
```

### register_item(item, cb)
Registers an item as usable.

```lua
CORE.register_item("medkit", function(source)
    print("Player used a medkit!")
end)
```

## Client

### get_data()
Retrieves client-side player data.

```lua
local player_data = CORE.get_data()
```

### get_identity()
Retrieves client-side player identity.

```lua
local identity = CORE.get_identity()
```

### get_player_id()
Retrieves client-side player unique identifier.

```lua
local player_id = CORE.get_player_id()
```