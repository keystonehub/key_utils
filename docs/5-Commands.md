# 5 - API Commands

The Commands module is a standalone SQL-based permission system that allows for registering and handling chat commands without relying on a framework. 
This module ensures that commands are managed securely with role-based permissions.

# Server

## register_command(command, required_rank, help, params, handler)
Registers a new chat command with permission control.

### Parameters:
- **command** *(string)* - The name of the command.
- **required_rank** *(string|table)* - The required rank(s) to execute the command.
- **help** *(string)* - The help text for the command.
- **params** *(table)* - The expected parameters for the command.
- **handler** *(function)* - The function that executes when the command is used.

### Example Usage:
```lua
COMMANDS.register("give_money", {"admin", "dev", "owner"}, "Give money to a player", {{name = "player_id", help = "Target player ID"}, {name = "amount", help = "Amount to give"}},
    function(source, args, raw)
        local target = tonumber(args[1])
        local amount = tonumber(args[2])
        if target and amount then
            print("Giving", amount, "to player", target)
        else
            print("Invalid arguments!")
        end
    end)
```

---

# Client

## get_chat_suggestions()
Requests chat suggestions from the server.

### Example Usage:
```lua
COMMANDS.get_chat_suggestions()
```