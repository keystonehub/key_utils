# Commands Module

## Overview

The Commands Module allows developers to define and manage server commands with custom permissions based on user ranks. 
Ranks are stored in the database and loaded into a user object when a player connects to the server. 
This avoids repeated database queries and improves performance.

## What is a Command?

A command is a server-side function that players can execute by typing specific inputs in the chat. 

## What Does the Commands Module Do?

- Registers server-side commands with rank-based access control.
- Sends chat suggestions to the client for registered commands.
- Provides permission checks for command execution.

## How is This Useful?

- **Customizable Permissions**: Define ranks and permissions for each command.
- **Framework Independence**: Write callbacks once, and they will work regardless of the framework.

## Usage

### Registering a Command

To register a command, use the `register_command` function. 
Define the command name, required rank(s), help text, parameters, and the handler function.

#### Example

```lua
utils.commands.register('vehicle', { 'dev' }, 'Spawn a vehicle at your location.', {
    { name = 'model', help = 'Vehicle model name or hash.' }
}, function(source, args, raw)
    local model = args[1]
    if not model then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^1SYSTEM', 'Usage: /vehicle [model]' }
        })
        return
    end
    
    TriggerEvent('boii:sv:spawn_vehicle', source, model)
end)
```

### Checking Permissions

Permissions are validated automatically for registered commands. You can also use the `has_permission` function directly if needed.

#### Example

```lua
local has_access = utils.commands.has_permission(source, { 'dev', 'admin' })
if has_access then
    print('User has the required permission.')
else
    print('User does not have permission.')
end
```

## Example Workflow

**Objective**: Create a `/kick` command that allows devs and admins to kick a player from the server.

### Server

```lua
utils.commands.register('kick', {'dev', 'admin'}, 'Kick a player from the server.', {
    { name = 'player_id', help = 'The ID of the player to kick.' },
    { name = 'reason', help = 'Reason for kicking the player.' }
}, function(source, args, rawCommand)
    local player_id = tonumber(args[1])
    local reason = args[2] or 'No reason provided.'

    if not player_id then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^1SYSTEM', 'Usage: /kick [player_id] [reason]' }
        })
        return
    end

    DropPlayer(player_id, 'You have been kicked from the server. Reason: ' .. reason)
    TriggerClientEvent('chat:addMessage', -1, {
        args = { '^1SYSTEM', ('Player %d was kicked. Reason: %s'):format(player_id, reason) }
    })
end)
```

### Client

1. The player’s session becomes active.
2. The client requests chat suggestions from the server.
3. The `/kick` command appears as a chat suggestion with its parameters.