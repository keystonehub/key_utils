local scope = {}

--- @section Tables

--- Table to store player scopes
local player_scopes = {}

---- @section Local functions

--- Gets players in the scope of the specified player.
--- @param _src The player identifier for whom to retrieve the scope.
--- @return A table of player identifiers within the scope of the specified player.
local function get_player_scope(_src)
    return player_scopes[_src] or {}
end

exports('get_player_scope', get_player_scope)
scope.get_player_scope = get_player_scope

--- Triggers an event to all players within the scope of a specified player.
--- @param event_name The name of the event to trigger.
--- @param scope_owner The player identifier whose scope will be used.
--- @param ... Additional parameters to pass along with the event.
local function trigger_scope_event(event_name, scope_owner, ...)
    local targets = player_scopes[scope_owner]
    if targets then
        for target, _ in pairs(targets) do
            TriggerClientEvent(event_name, target, ...)
        end
    end
    TriggerClientEvent(event_name, scope_owner, ...)
end

exports('trigger_scope_event', trigger_scope_event)
scope.trigger_scope_event = trigger_scope_event

---- @section Events

--- Event handler when a player enters the scope of another player
AddEventHandler('playerEnteredScope', function(data)
    local player_entering, player = data['player'], data['for']
    player_scopes[player] = player_scopes[player] or {}
    player_scopes[player][player_entering] = true
end)

--- Event handler when a player leaves the scope of another player
AddEventHandler('playerLeftScope', function(data)
    local player_leaving, player = data['player'], data['for']
    if player_scopes[player] then
        player_scopes[player][player_leaving] = nil
    end
end)

--- Cleanup when a player drops
AddEventHandler('playerDropped', function()
    local _src = source
    if not _src then return end
    player_scopes[_src] = nil
    for owner, tbl in pairs(player_scopes) do
        if tbl[_src] then
            tbl[_src] = nil
        end
    end
end)

--- Cleanup when the resource stops
AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    player_scopes = {}
end)

return scope