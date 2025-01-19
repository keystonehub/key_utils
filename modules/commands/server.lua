local callbacks = utils.get_module('callbacks')

--- Get shared loader to construct.
local commands = {}

--- Stores chat suggestions
local chat_suggestions = {}

--- @section Local functions

--- Retrieves user data from the database based on the source.
--- @param _src number: The source ID of the player.
--- @return table|nil: The user data containing unique_id and rank, or nil if not found.
local function get_user_data(_src)
    return connected_users[_src] or nil
end

--- Checks if a user has the required permission rank.
--- @param _src number: The source ID of the player.
--- @param required_rank string|table: The required rank or ranks.
--- @return boolean: True if the user has the required permission, false otherwise.
local function has_permission(_src, required_rank)
    local user = get_user_data(_src)
    if not user then return false end

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

--- @section Events

RegisterServerEvent('fivem_utils:sv:request_chat_suggestions')
AddEventHandler('fivem_utils:sv:request_chat_suggestions', function()
    local _src = source
    for _, suggestion in ipairs(chat_suggestions) do
        TriggerClientEvent('fivem_utils:cl:register_chat_suggestion', _src, suggestion.command, suggestion.help, suggestion.params)
    end
end)

return commands