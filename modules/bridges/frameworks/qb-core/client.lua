if GetConvar('utils:framework', ''):lower() ~= 'qb-core' or GetResourceState('qb-core') ~= 'started' then return end

local callbacks_module = utils.get_module('callbacks')

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

--- @section Callback functions

--- Callback function to check if a player has a required job.
--- @param jobs table: A table of job names to check against.
--- @param on_duty boolean: Toggle to only return true if player is on duty.
--- @param cb function: Callback function.
local function player_has_job(jobs, on_duty, cb)
    callbacks_module.trigger('fivem_utils:sv:player_has_job', { jobs = jobs, on_duty = on_duty }, function(has_job)
        cb(has_job)
    end)
end

exports('player_has_job', player_has_job)
fw.player_has_job = player_has_job

--- Callback function to check if a player has a required job.
--- @param jobs: A table of job names to check against.
--- @param on_duty: Toggle to only return true if player is on duty.
--- @param cb: Callback function.
local function get_player_job_grade(job, cb)
    callbacks_module.trigger('fivem_utils:sv:get_player_job_grade', { job = job }, function(players_grade)
        cb(players_grade)
    end)
end

exports('get_player_job_grade', get_player_job_grade)
fw.get_player_job_grade = get_player_job_grade

--- Callback function to get a players inventory data.
--- @param cb: Callback function.
local function get_inventory(cb)
    callbacks_module.trigger('fivem_utils:sv:get_inventory', {}, function(inventory)
        cb(inventory)
    end)
end

exports('get_inventory', get_inventory)
fw.get_inventory = get_inventory

--- Callback function to get a specific item.
--- @param item: The item ID to check.
--- @param cb: Callback function.
local function get_item(item, cb)
    local item = tostring(item)
    callbacks_module.trigger('fivem_utils:sv:get_item', { item_name = item }, function(item)
        cb(item)
    end)
end

exports('get_item', get_item)
fw.get_item = get_item

--- Callback function to check if a player has a required item and quantity.
--- @param item: The item ID to check.
--- @param amount: The amount of the item they should have.
--- @param cb: Callback function.
local function has_item(item, amount, cb)
    local item = tostring(item)
    local amount = tonumber(amount) or 1
    callbacks_module.trigger('fivem_utils:sv:has_item', { item_name = item, item_amount = amount }, function(has_item)
        cb(has_item)
    end)
end

exports('has_item', has_item)
fw.has_item = has_item

--- @section QB Metadata Conversions

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('fivem_utils:sv:run_qb_meta_convert')
end)

--- @section Assignment

return fw