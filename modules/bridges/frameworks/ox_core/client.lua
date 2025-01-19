if GetConvar('utils:framework', ''):lower() ~= 'ox_core' or GetResourceState('ox_core') ~= 'started' then return end


local fw = {}

--- Get OX
local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
local import = LoadResourceFile('ox_core', file)
local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))
chunk()

--- @section Local Functions

--- Retrieves a player's client-side data based on the active framework.
--- @param key string (optional): The key of the data to retrieve.
--- @return table: The requested player data.
local function get_data()
    local player_data = Ox.GetPlayerData()
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
        first_name = player.firstName,
        last_name = player.lastName,
        dob = player.dob,
        sex = player.gender,
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
    local player_id = player.stateId
    if not player_id then return false end
    return player_id
end

exports('get_player_id', get_player_id)
fw.get_player_id = get_player_id

return fw