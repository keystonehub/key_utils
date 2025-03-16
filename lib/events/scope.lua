local scope = require("modules.scope")

if ENV.IS_SERVER then

    --- Event handler when a player enters the scope of another player
    AddEventHandler('playerEnteredScope', function(data)
        scope.add_to_scope(data['for'], data['player'])
    end)

    --- Event handler when a player leaves the scope of another player
    AddEventHandler('playerLeftScope', function(data)
        scope.remove_from_scope(data['for'], data['player'])
    end)

    --- Cleanup when a player drops
    AddEventHandler('playerDropped', function()
        local _src = source
        if _src then
            scope.clear_player_scope(_src)
        end
    end)

    --- Cleanup when the resource stops
    AddEventHandler('onResourceStop', function(res)
        if res == GetCurrentResourceName() then
            player_scopes = {} -- Optional, can be handled within scope module
        end
    end)

end
