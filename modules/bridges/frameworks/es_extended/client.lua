if GetConvar('utils:framework', ''):lower() ~= 'es_extended' or GetResourceState('es_extended') ~= 'started' then return end

local fw = {}

--- Get ESX
local core = exports.es_extended:getSharedObject()

--- Retrieves a player's client-side data based on the active framework.
--- @param key string (optional): The key of the data to retrieve.
--- @return table: The requested player data.
local function get_data()
    local player_data = core.GetPlayerData()
    return player_data
end

exports('get_data', get_data)
fw.get_data = get_data

--- Retrieves a players identity information.
--- @return table: The players identity information (first name, last name, date of birth, sex, nationality).
local function get_identity()
    local player = get_data()
    if not player then return false end
    return {
        first_name = player.firstName or 'firstName missing',
        last_name = player.lastName or 'lastName missing',
        dob = player.dateofbirth or 'dateofbirth missing',
        sex = player.sex or 'sex missing',
        nationality = 'LS, Los Santos'
    }
end

exports('get_identity', get_identity)
fw.get_identity = get_identity

--- Retrieves player unique id.
--- @return Players main identifier.
local function get_player_id()
    local player = get_data()
    if not player then return false end
    local player_id = player.identifier
    if not player_id then return false end
    return player_id
end

exports('get_player_id', get_player_id)
fw.get_player_id = get_player_id

return fw