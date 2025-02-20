local zones = {}

--- @section Tables

--- Stores zones server side for syncing.
local stored_zones = {}

--- @section Local functions

--- Gets all zones
local function get_zones()
    return stored_zones
end

exports('get_zones', get_zones)
zones.get_zones = get_zones

--- Send zones to players.
--- @param _src: Source player.
local function send_zones(_src)
    TriggerClientEvent('fivem_utils:cl:update_zones', _src, zones)
end

--- @section Events

--- Adds a new zone to server side table and syncs back to clients.
--- @param id: ID of the new zone.
--- @param zone: Zone options table.
RegisterNetEvent('fivem_utils:sv:add_zone', function(id, zone)
    stored_zones[id] = zone
    TriggerClientEvent('fivem_utils:cl:update_zones', -1, zones)
end)

--- Removes a zone from server side table and syncs back to clients.
--- @param id: ID of the new zone.
RegisterNetEvent('fivem_utils:sv:remove_zone', function(id)
    stored_zones[id] = nil
    TriggerClientEvent('fivem_utils:cl:update_zones', -1, zones)
end)

--- Send all zones to a newly connected player
AddEventHandler('playerConnecting', function()
    local _src = source
    send_zones(_src)
end)

return zones