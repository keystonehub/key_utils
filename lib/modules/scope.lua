local scope = {}

if ENV.IS_SERVER then

    --- @section Tables

    --- Table to store player scopes
    local player_scopes = {}

    --- @section Local Functions

    --- Gets players in the scope of the specified player.
    --- @param _src number: The player identifier for whom to retrieve the scope.
    --- @return table: A table of player identifiers within the scope.
    local function get_player_scope(_src)
        return player_scopes[_src] or {}
    end

    --- Adds a player to another player's scope.
    --- @param owner number: The player who owns the scope.
    --- @param target number: The player being added to the scope.
    local function add_to_scope(owner, target)
        if not owner or not target or owner == target then return end
        
        player_scopes[owner] = player_scopes[owner] or {}
        player_scopes[owner][target] = true
    end

    --- Removes a player from another player's scope.
    --- @param owner number: The player who owns the scope.
    --- @param target number: The player being removed from the scope.
    local function remove_from_scope(owner, target)
        if player_scopes[owner] then
            player_scopes[owner][target] = nil
            if next(player_scopes[owner]) == nil then
                player_scopes[owner] = nil
            end
        end
    end

    --- Clears scope data for a player (e.g., when they leave).
    --- @param _src number: The player identifier.
    local function clear_player_scope(_src)
        player_scopes[_src] = nil

        for owner, scope in pairs(player_scopes) do
            scope[_src] = nil
            if next(scope) == nil then
                player_scopes[owner] = nil
            end
        end
    end

    --- Triggers an event to all players within the scope of a specified player.
    --- @param event_name string: The name of the event to trigger.
    --- @param scope_owner number: The player identifier whose scope will be used.
    --- @param ... any: Additional parameters to pass along with the event.
    local function trigger_scope_event(event_name, scope_owner, ...)
        local targets = player_scopes[scope_owner]

        if targets then
            for target, _ in pairs(targets) do
                TriggerClientEvent(event_name, target, ...)
            end
        end

        TriggerClientEvent(event_name, scope_owner, ...)
    end

    --- @section Function Assignments

    scope.get_player_scope = get_player_scope
    scope.add_to_scope = add_to_scope
    scope.remove_from_scope = remove_from_scope
    scope.clear_player_scope = clear_player_scope
    scope.trigger_scope_event = trigger_scope_event

    --- @section Exports

    exports('get_player_scope', get_player_scope)
    exports('add_to_scope', add_to_scope)
    exports('remove_from_scope', remove_from_scope)
    exports('clear_player_scope', clear_player_scope)
    exports('trigger_scope_event', trigger_scope_event)

end

return scope
