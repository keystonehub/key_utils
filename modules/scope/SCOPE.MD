# Scope Module

## Overview

The Scope Module provides a server-side system to manage and track player scopes. 
It enables developers to determine which players are within the scope of a specified player and trigger events for those players.

## What Does the Player Scopes Module Do?

- Tracks the players in the scope of other players.
- Triggers events for all players within a specified player’s scope.
- Automatically manages scope data when players enter, leave, or disconnect.

## How is This Useful?

- **Event Optimization**: Send targeted events to relevant players instead of broadcasting to the entire server.
- **Scope Management**: Automatically tracks which players are in each other's scopes.
- **Cleanup Automation**: Handles cleanup of scope data when players disconnect or the resource stops.

## Usage

### Retrieving a Player’s Scope

To get the players within the scope of a specific player, use the `get_player_scope` function.

#### Example

```lua
local scope_players = utils.scope.get_player_scope(source)
for _, player in pairs(scope_players) do
    print("Player in scope:", player)
end
```

### Triggering Events for Players in Scope

To send an event to all players within the scope of a specific player, use the `trigger_scope_event` function.

#### Example

```lua
utils.scope.trigger_scope_event('custom_event_name', source, 'additional_data')
```

In this example:
- `'custom_event_name'` is the event to trigger.
- `source` is the player whose scope will be used.
- `'additional_data'` is any additional parameter passed with the event.

### Event Handling

The module automatically handles the following scenarios:

- **Player Entering Scope**: When a player enters the scope of another player, the `playerEnteredScope` event is triggered and handled.
- **Player Leaving Scope**: When a player leaves the scope of another player, the `playerLeftScope` event is triggered and handled.
- **Player Disconnect**: When a player disconnects, their scope data is automatically cleaned up.
- **Resource Stop**: When the resource stops, all scope data is cleared.

## Example Workflow

**Objective**: Send a message to all players within the scope of a specific player when they perform an action.

### Workflow

1. **Define the Event**:

```lua
RegisterServerEvent('your_custom_event')
AddEventHandler('your_custom_event', function()
    local _src = source
    utils.scope.trigger_scope_event('notify_scope', _src, 'An event was triggered on your scope.')
end)
```

2. **Handle the Notification Client-Side**:

```lua
RegisterNetEvent('notify_scope')
AddEventHandler('notify_scope', function(message)
    print(message) -- Replace with actual notification logic
end)
```

In this example:
- When a player triggers the `your_custom_event` event, all players in their scope receive the `notify_scope` event.

For further details or assistance, refer to the documentation or contact support via Discord.