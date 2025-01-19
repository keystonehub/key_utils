if GetConvar('utils:framework', ''):lower() ~= 'qb-core' or GetResourceState('qb-core') ~= 'started' then return end

local fw = {}

--- Get QBCore
local core = exports['qb-core']:GetCoreObject()

--- @section Local Functions

--- Retrieves a player's client-side data based on the active framework.
--- @param key string (optional): The key of the data to retrieve.
--- @return table: The requested player data.
local function get_data()
    local player_data = core.Functions.GetPlayerData()
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
        first_name = player.charinfo.firstname,
        last_name = player.charinfo.lastname,
        dob = player.charinfo.birthdate,
        sex = player.charinfo.gender,
        nationality = player.charinfo.nationality
    }
end

exports('get_identity', get_identity)
fw.get_identity = get_identity

--- Retrieves player unique id.
--- @return Players main identifier.
local function get_player_id()
    local player = get_data()
    if not player then return false end
    local player_id = player.citizenid
    if not player_id then return false end
    return player_id
end

exports('get_player_id', get_player_id)
fw.get_player_id = get_player_id

--- @section QB Metadata Conversions

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('fivem_utils:sv:run_qb_meta_convert')
end)

--- @section Assignment

return fw