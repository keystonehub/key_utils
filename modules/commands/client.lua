local commands = {}

--- @section Internal functions

--- Waits for the player's session to become active before requesting chat suggestions from the server.
--- This ensures chat suggestions are only requested when the player is fully connected.
local function request_chat_suggestions()
    CreateThread(function()
        while not NetworkIsSessionActive() and not NetworkIsPlayerActive(PlayerId()) do
            Wait(10)
        end
        TriggerServerEvent('fivem_utils:sv:request_chat_suggestions')
    end)
end
request_chat_suggestions()

--- @section Local functions

--- Sends a request to the server to get chat suggestions.
--- This can be called to refresh or re-fetch the suggestions if needed.
local function get_chat_suggestions()
    TriggerServerEvent('fivem_utils:sv:request_chat_suggestions')
end

exports('get_chat_suggestions', get_chat_suggestions)
commands.get_chat_suggestions = get_chat_suggestions

--- @section Events

--- Adds a chat suggestion to the player's chat input.
--- This event listens for server responses to dynamically add command suggestions.
--- @param command string: The command name (e.g., 'kick').
--- @param help string: Description or help text for the command (e.g., 'Kick a player from the server').
--- @param params table: An array of parameters for the command (e.g., { { name = 'id', help = 'Player ID' } }).
RegisterNetEvent('fivem_utils:cl:register_chat_suggestion', function(command, help, params)
    TriggerEvent('chat:addSuggestion', '/' .. command, help, params)
end)

return commands