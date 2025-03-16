# 5 - API Callbacks

The Callbacks module provides a standalone way to register and trigger callbacks between the server and client.
Removes the need for coding multiple different callbacks for each core.

# Server

## register_callback(name, cb)
Registers a server-side callback.

### Parameters:
- **name** *(string)* - The event name of the callback.
- **cb** *(function)* - The function to execute when the callback is triggered.

### Example Usage:
```lua
local CALLBACKS = require("modules.callbacks")

CALLBACKS.register("get_player_data", function(source, data, cb)
    local player_data = { id = source, money = 1000 }
    cb(player_data)
end)
```

# Client

## trigger_callback(name, data, cb)
Triggers a server callback from the client and waits for a response.

### Parameters:
- **name** *(string)* - The event name of the callback.
- **data** *(table)* - The data to send to the server.
- **cb** *(function)* - The function to execute when the response is received.

### Example Usage:
```lua
local CALLBACKS = require("modules.callbacks")

CALLBACKS.trigger("get_player_data", nil, function(response)
    print("Received Player Data:", response.id, response.money)
end)
```