if GetConvar('utils:framework', ''):lower() ~= 'boii_core' or GetResourceState('boii_core') ~= 'started' then return end

local fw = {}

--- Retrieves a player's client-side data based on the active framework.
--- @param key string (optional): The key of the data to retrieve.
--- @return table: The requested player data.
local function get_data(key)
    local player_data = exports.boii_core:get_data(key)
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
        first_name = player.identity.first_name,
        middle_name = player.identity.middle_name or nil,
        last_name = player.identity.last_name,
        dob = player.identity.date_of_birth,
        sex = player.identity.sex,
        nationality = player.identity.nationality
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