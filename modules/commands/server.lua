local callbacks = utils.get_module('callbacks')

--- Get shared loader to construct.
local commands = {}

--- Stores chat suggestions
local chat_suggestions = {}

--- @section Local functions

--- Checks if a user has the required permission rank.
--- @param _src number: The source ID of the player.
--- @param required_rank string|table: The required rank or ranks.
--- @return boolean: True if the user has the required permission, false otherwise.
local function has_permission(_src, required_rank)
    local user = utils.get_user(_src)
    if not user then print('user not found when using command') return false end

    print('user found: ', json.encode(user))

    local user_rank = user.rank
    local ranks = type(required_rank) == 'table' and required_rank or { required_rank }
    for _, rank in ipairs(ranks) do
        if rank == user_rank or rank == 'all' then return true end
    end
    return false
end

--- Registers chat suggestions for autocomplete in the client chat input.
--- @param command string: The command for which the suggestion is being registered.
--- @param help string: The help text for the command.
--- @param params table: The parameters for the command.
local function register_chat_suggestion(command, help, params)
    chat_suggestions[#chat_suggestions + 1] = { command = command, help = help, params = params }
end

--- Registers a new command with the system.
--- @param command string: The command to register.
--- @param required_rank string|table: The required rank(s) to execute the command.
--- @param help string: The help text for the command.
--- @param params table: The parameters for the command.
--- @param handler function: The handler function to execute when the command is called.
local function register_command(command, required_rank, help, params, handler)
    if help and params then
        register_chat_suggestion(command, help, params)
    end

    RegisterCommand(command, function(source, args, raw)
        if has_permission(source, required_rank) then
            handler(source, args, raw)
        else
            TriggerClientEvent('chat:addMessage', source, {
                args = { '^1SYSTEM', 'You do not have permission to execute this command.' }
            })
        end
    end, false)
end

exports('register_command', register_command)
commands.register = register_command

--- @section Callbacks

callbacks.register('fivem_utils:sv:has_command_permission', has_permission)

return commands