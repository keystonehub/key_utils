if config.framework ~= 'qb-core' or GetResourceState('qb-core') ~= 'started' then return end

local callbacks_module = utils.get_module('callbacks')
local tables_module = utils.get_module('tables')

local fw = {}

local core = exports['qb-core']:GetCoreObject()

--- @section Local Functions

--- Retrieves all players
--- @return players table
local function get_players()
    local players = core.Functions.GetPlayers()
    return players
end

exports('get_players', get_players)
fw.get_players = get_players

--- Retrieves player data from the server based on the framework.
--- @param _src number: Player source identifier.
--- @return Player data object.
local function get_player(_src)
    local player = core.Functions.GetPlayer(_src)
    return player
end

exports('get_player', get_player)
fw.get_player = get_player

--- Retrieves player character unique id.
--- @param _src number: Player source identifier.
--- @return Players main identifier.
local function get_player_id(_src)
    local player = get_player(_src)
    if not player then print('No player found for source: '.._src) return false end

    local player_id = player.PlayerData.citizenid
    return player_id
end

exports('get_player_id', get_player_id)
fw.get_player_id = get_player_id

--- Prepares query parameters for database operations.
--- @param _src number: Player source identifier.
--- @return Query part and parameters.
local function get_id_params(_src)
    local player = get_player(_src)
    local query, params = 'citizenid = ?', { player.PlayerData.citizenid }
    return query, params
end

exports('get_id_params', get_id_params)
fw.get_id_params = get_id_params

--- Prepares data for SQL INSERT operations.
--- @param _src number: Player source identifier.
--- @param data_type string: The type of data being inserted.
--- @param data_name string: The name of the data field.
--- @param data table: The data to insert.
--- @return Columns, values, and parameters.
local function get_insert_params(_src, data_type, data_name, data)
    local player = get_player(_src)
    local columns, values, params = {'citizenid', data_type}, '?, ?', { player.PlayerData.citizenid, json.encode(data) }
    return columns, values, params
end

exports('get_insert_params', get_insert_params)
fw.get_insert_params = get_insert_params

--- Retrieves a player's identity information.
--- @param _src number: Player source identifier.
--- @return Table of players identity information.
local function get_identity(_src)
    local player = get_player(_src)
    if not player then return false end

    local player_data = {
        first_name = player.PlayerData.charinfo.firstname,
        last_name = player.PlayerData.charinfo.lastname,
        dob = player.PlayerData.charinfo.birthdate,
        sex = player.PlayerData.charinfo.gender,
        nationality = player.PlayerData.charinfo.nationality
    }
    return player_data
end

exports('get_identity', get_identity)
fw.get_identity = get_identity

--- Retrieves a player's identity information by their id (citizenid, unique_id+char_id, etc..)
--- @param unique_id string: The id of the user to retrieve identity information for.
--- @return Table of identity information.
local function get_identity_by_id(unique_id)
    local players = get_players()
    for _, player in ipairs(players) do
        if type(player) == 'table' then
            p_source = player.source
        else
            p_source = player
        end
        local p_id = get_player_id(p_source)
        if p_id == unique_id then
            local identity = get_identity(p_source)
            return identity
        end
    end
    return nil
end

exports('get_identity_by_id', get_identity_by_id)
fw.get_identity_by_id = get_identity_by_id

--- Checks if a player has a specific item in their inventory.
--- @param _src number: Player source identifier.
--- @param item_name string: Name of the item to check.
--- @param item_amount number: (Optional) Amount of the item to check for.
--- @return True if the player has the item (and amount), False otherwise.
local function has_item(_src, item_name, item_amount)
    local player = get_player(_src)
    if not player then 
        print("Player not found:", _src)
        return false 
    end

    local required_amount = item_amount or 1

    -- ox_inventory
    if GetResourceState('ox_inventory') == 'started' then
        local count = exports.ox_inventory:Search(_src, 'count', item_name)
        return count ~= nil and count >= required_amount
    end
    
    local item = player.Functions.GetItemByName(item_name)
    return item ~= nil and item.amount >= required_amount
end

exports('has_item', has_item)
fw.has_item = has_item

--- Retrieves an item from the players inventory.
--- @param _src number: Player source identifier.
--- @param item_name string: Name of the item to retrieve.
--- @return Item object if found, nil otherwise.
local function get_item(_src, item_name)
    local player = get_player(_src)
    if not player then return nil end

    local item

    --- ox_inventory
    if GetResourceState('ox_inventory') == 'started' then
        local items = exports.ox_inventory:Search(_src, 'items', item_name)
        if items and #items > 0 then
            item = items[1]
            return item
        end
    end

    item = player.Functions.GetItemByName(item_name)
    return item
end

exports('get_item', get_item)
fw.get_item = get_item

--- Gets a player's inventory data
--- @param _src Player source identifier.
--- @return The players inventory.
local function get_inventory(_src)
    local player = get_player(_src)
    if not player then return false end

    local inventory

    --- ox_inventory
    if GetResourceState('ox_inventory') == 'started' then
        inventory = exports.ox_inventory:GetInventory(_src, false)
        return inventory
    end

    inventory = player.PlayerData.inventory
    return inventory
end

exports('get_inventory', get_inventory)
fw.get_inventory = get_inventory

--- Adjusts a player's inventory based on given options.
--- @param _src number: Player source identifier.
--- @param options table: Options for inventory adjustment.
local function adjust_inventory(_src, options)
    local player = get_player(_src)
    if not player then return false end

    local function proceed()
        
        -- ox_inventory
        if GetResourceState('ox_inventory') == 'started' then
            for _, item in ipairs(options.items) do
                if item.action == 'add' then
                    exports.ox_inventory:AddItem(_src, item.item_id, item.amount, item.data)
                elseif item.action == 'remove' then
                    exports.ox_inventory:RemoveItem(_src, item.item_id, item.amount, item.data)
                end
            end
        else
            for _, item in ipairs(options.items) do
                if item.action == 'add' then
                    player.Functions.AddItem(item.item_id, item.amount, nil, item.data)
                    TriggerClientEvent('qb-inventory:client:ItemBox', _src, core.Shared.Items[item.item_id], 'add', item.amount)
                elseif item.action == 'remove' then
                    player.Functions.RemoveItem(item.item_id, item.amount)
                    TriggerClientEvent('qb-inventory:client:ItemBox', _src, core.Shared.Items[item.item_id], 'remove', item.amount)
                end
            end
        end
    end

    if options.validation_data then
        callbacks_module.validate_distance(_src, {location = options.validation_data.location, distance = options.validation_data.distance}, function(is_valid)
            if not is_valid then
                if options.validation_data.drop_player then
                    DropPlayer(_src, 'Suspected range exploits.')
                end
                return
            end
            proceed()
        end)
    else
        proceed()
    end
end

exports('adjust_inventory', adjust_inventory)
fw.adjust_inventory = adjust_inventory

--- Updates the item data for a player.
--- @param _src number: The players source identifier.
--- @param item_id string: The ID of the item to update.
--- @param updates table: Table containing updates like ammo count, attachments etc.
local function update_item_data(_src, item_id, updates)
    local player = get_player(_src)
    if not player then print('Player not found') return end
    local item = get_item(_src, item_id)
    if not item then  print('Item not found:', item_id) return  end

    --- ox_inventory
    if GetResourceState('ox_inventory') == 'started' then
        local items = exports.ox_inventory:Search(_src, 1, item_id)
        for _, v in pairs(items) do
            for key, value in pairs(updates) do
                v.metadata[key] = value
            end
            exports.ox_inventory:SetMetadata(_src, v.slot, v.metadata)
            break
        end
    else
        if item.info then
            for key, value in pairs(updates) do
                exports['qb-inventory']:SetItemData(_src, item_id, key, value)
            end
        end
    end
end

exports('update_item_data', update_item_data)
fw.update_item_data = update_item_data

--- Retrieves the balances of a player.
--- @param _src number: Player source identifier.
--- @return A table of balances by type.
local function get_balances(_src)
    local player = get_player(_src)
    if not player then return false end

    local balances = player.PlayerData.money
    return balances
end

exports('get_balances', get_balances)
fw.get_balances = get_balances

--- Retrieves a specific balance of a player by type.
--- @param _src number: Player source identifier.
--- @param balance_type string: The type of balance to retrieve.
--- @return The balance amount for the specified type.
local function get_balance_by_type(_src, balance_type)
    local balances = get_balances(_src)
    if not balances then print('no balances') return false end

    local balance = balances[balance_type] or 0
    return balance
end

exports('get_balance_by_type', get_balance_by_type)
fw.get_balance_by_type = get_balance_by_type

--- Function to adjust a player's balance.
--- @param _src number: Player source identifier.
--- @param options table: Table containing balance operations, validation data, reason for the adjustment, and whether to save the update.
--- @usage
--[[
local operations = {
    {balance_type = 'bank', action = 'remove', amount = 1000},
    {balance_type = 'savings', action = 'add', amount = 1000}
}
local validation_data = { location = vector3(100.0, 100.0, 20.0), distance = 10.0, drop_player = true }
fw.adjust_balance(_src, {
    operations = operations, 
    validation_data = validation_data, 
    reason = 'Transfer from bank to savings', 
    should_save = true
})
]]
local function adjust_balance(_src, options)
    local player = get_player(_src)
    if not player then print('player not found') return end

    local function proceed()
        for _, op in ipairs(options.operations) do
            if op.action == 'add' then
                player.Functions.AddMoney(op.balance_type, op.amount, options.reason)
            elseif op.action == 'remove' then
                player.Functions.RemoveMoney(op.balance_type, op.amount, options.reason)
            end
        end
    end

    if options.validation_data then
        callbacks_module.validate_distance(_src, {location = options.validation_data.location, distance = options.validation_data.distance}, function(is_valid)
            if not is_valid then
                if options.validation_data.drop_player then
                    DropPlayer(_src, 'Suspected range exploits.')
                end
                return
            end
            proceed()
        end)
    else
        proceed()
    end
end

exports('adjust_balance', adjust_balance)
fw.adjust_balance = adjust_balance

--- Retrieves the job(s) of a player by their source identifier.
--- @param _src number: The players source identifier.
--- @return A table containing the players jobs and their on-duty status.
local function get_player_jobs(_src)
    local player = get_player(_src)

    local player_jobs = player.PlayerData.job
    return player_jobs
end

exports('get_player_jobs', get_player_jobs)
fw.get_player_jobs = get_player_jobs

--- Checks if a player has one of the specified jobs and optionally checks their on-duty status.
--- @param _src number: The players source identifier.
--- @param job_names table: An array of job names to check against the players jobs.
--- @param check_on_duty boolean: Optional boolean to also check if the player is on-duty for the job.
--- @return Boolean indicating if the player has any of the specified jobs and meets the on-duty condition.
local function player_has_job(_src, job_names)
    local player_jobs = get_player_jobs(_src)
    local job_found = false
    local on_duty_status = false
    if tables_module.contains(job_names, player_jobs.name) then
        job_found = true
        on_duty_status = player_jobs.onduty
    end
    return job_found and (not check_on_duty or on_duty_status)
end

exports('player_has_job', player_has_job)
fw.player_has_job = player_has_job

--- Retrieves a player's job grade for a specified job.
--- @param _src number: The players source identifier.
--- @param job_id string: The job ID to retrieve the grade for.
--- @return The grade of the player for the specified job, or nil if not found.
local function get_player_job_grade(_src, job_id)
    local player_jobs = get_player_jobs(_src)
    if not player_jobs then print('No job data found for player. ' .. _src) return nil end
    if player_jobs.name == job_id then
        return player_jobs.grade.level
    end
    return nil
end

exports('get_player_job_grade', get_player_job_grade)
fw.get_player_job_grade = get_player_job_grade

--- Counts players with a specific job and optionally filters by on-duty status.
--- @param job_names table: Table of job names to check against the players jobs.
--- @param check_on_duty boolean: Optional boolean to also check if the player is on-duty for the job.
--- @return Two numbers: total players with the job, and total players with the job who are on-duty.
local function count_players_by_job(job_names, check_on_duty)
    local players = get_players()
    local total_with_job = 0
    local total_on_duty = 0
    for _, player_src in ipairs(players) do
        if player_has_job(player_src, job_names, false) then
            total_with_job = total_with_job + 1
            if player_has_job(player_src, job_names, true) then
                total_on_duty = total_on_duty + 1
            end
        end
    end
    return total_with_job, total_on_duty
end

exports('count_players_by_job', count_players_by_job)
fw.count_players_by_job = count_players_by_job

--- Returns a players job name.
--- @param _src number: The players source identifier.
local function get_player_job_name(_src)
    local player_jobs = get_player_jobs(_src)
    local job_name
    if player_jobs then
        job_name = player_jobs.name
    end
    return job_name
end

exports('get_player_job_name', get_player_job_name)
fw.get_player_job_name = get_player_job_name

--- Modifies a players server-side statuses.
--- @param _src The players source identifier.
--- @param statuses The statuses to modify.
local function adjust_statuses(_src, statuses)
    local player = get_player(_src)
    if not player then utils.debug_log('error', 'Player is missing.') return end
    -- boii_statuses integration
    if GetResourceState('boii_statuses') == 'started' then
        local player_statuses = exports.boii_statuses:get_player(_src)
        if player_statuses then 
            player_statuses.modify_statuses(statuses)
        end
        return
    end
    local status_map = { armour = 'armor', armor = 'armour' }
    local hud_updates = { hunger = nil, thirst = nil, stress = nil }
    for key, mod in pairs(statuses) do
        local status_key = status_map[key] or key
        if not player.PlayerData.metadata[status_key] then utils.debug_log('warn', ('Bypassing %s does not exist in metadata.'):format(status_key)) return end
        local add_value = (mod.add and mod.add.min and mod.add.max) and math.random(mod.add.min, mod.add.max) or 0
        local remove_value = (mod.remove and mod.remove.min and mod.remove.max) and math.random(mod.remove.min, mod.remove.max) or 0
        local change_value = add_value - remove_value
        if status_key == 'stress' then
            if change_value > 0 then
                TriggerEvent('hud:server:GainStress', change_value, _src)
            elseif change_value < 0 then
                TriggerEvent('hud:server:RelieveStress', math.abs(change_value), _src)
            end
            hud_updates.stress = true
        elseif status_key == 'hunger' or status_key == 'thirst' then
            TriggerClientEvent('hud:client:UpdateNeeds', _src, player.PlayerData.metadata.hunger, player.PlayerData.metadata.thirst)
        end
        local current = player.PlayerData.metadata[status_key] or 0
        local new_value = math.min(100, math.max(0, current + change_value))
        player.Functions.SetMetaData(status_key, new_value)
    end
end

exports('adjust_statuses', adjust_statuses)
fw.adjust_statuses = adjust_statuses

--- Register an item as usable for different frameworks.
--- @param item string: The item identifier.
--- @param cb function: The callback function to execute when the item is used.
local function register_item(item, cb)
    if not item then utils.debug_log('warn', 'Function: register_item | Note: Item identifier is missing') return end
    core.Functions.CreateUseableItem(item, function(source)
        cb(source)
    end)
end

exports('fw_register_item', register_item)
fw.register_item = register_item

--- @section Callbacks

--- Callback for checking if player has item by quantity.
callbacks_module.register('fivem_utils:sv:has_item', function(_src, data, cb)
    local item_name = data.item_name
    local item_amount = data.item_amount or 1
    local player_has_item = false
    if has_item(_src, item_name, item_amount) then
        player_has_item = true
    else
        player_has_item = false
    end
    cb(player_has_item)
end)

--- Callback for checking if player has the required job
callbacks_module.register('fivem_utils:sv:player_has_job', function(_src, data, cb)
    local jobs = data.jobs
    local on_duty = data.on_duty
    local has_job = player_has_job(_src, jobs, on_duty)
    cb(has_job)
end)

--- Callback for checking if player has the required job grade
callbacks_module.register('fivem_utils:sv:get_player_job_grade', function(_src, data, cb)
    local job = data.job
    local job_grade = get_player_job_grade(_src, job)
    cb(job_grade)
end)

callbacks_module.register('fivem_utils:sv:get_inventory', function(_src, data, cb)
    local inventory = get_inventory(_src)
    cb(inventory)
end)

--- @section QBCore Metadata Conversions

local utils_data = utils.get_all_shared_data()

--- Calculates the required XP for the next level based on the current level, first level XP, and growth factor.
--- @param current_level The current level of the player.
--- @param first_level_xp The amount of XP required for the first level.
--- @param growth_factor The factor by which the required XP increases per level.
--- @return The required XP for the next level.
local function calculate_required_xp(current_level, first_level_xp, growth_factor)
    return math.floor(first_level_xp * (growth_factor ^ (current_level - 1)))
end

--- Updates or inserts data into the specified database table.
--- @param _src The players server ID.
--- @param data_type The type of data being handled (e.g., 'skills', 'licences', 'reputation').
--- @param table_name The name of the database table to update or insert data into.
--- @param data The data to update or insert.
--- @return True if the update was successful, false otherwise.
local function update_or_insert_data(_src, data_type, table_name, data)
    local query_part, params = fw.get_id_params(_src)
    local check_query = string.format('SELECT * FROM %s WHERE %s', table_name, query_part)
    local check_result = MySQL.query.await(check_query, params)
    if check_result and #check_result > 0 then
        local update_query = string.format('UPDATE %s SET %s = ? WHERE %s', table_name, data_type, query_part)
        local update_params = { json.encode(data) }
        for _, param in ipairs(params) do
            update_params[#update_params + 1] = param
        end
        local affected = MySQL.Sync.execute(update_query, update_params)
        if affected > 0 then
            utils.debug_log("info", "Successfully ran qb-core metadata conversions and applied updated data.")
            return true
        else
            utils.debug_log("err", "Failed update qb-core metadata conversions.")
            return false
        end
    else
        local columns, values, insert_params = fw.get_insert_params(_src, data_type, data_type, data)
        local insert_query = string.format('INSERT INTO %s (%s) VALUES (%s)', 'player_'..data_type, table.concat(columns, ', '), values)
        MySQL.insert.await(insert_query, insert_params)
    end
end

--- Converts qb-core metadata for skills, licences, and job reputation into the data format used by the utils systems.
--- @lfunction convert_qb_metadata
--- @param _src The players server ID.
local function convert_qb_metadata(_src)
    local player = fw.get_player(_src)
    local query_part, params = fw.get_id_params(_src)
    local qb_metadata_query = string.format('SELECT metadata FROM players WHERE %s', query_part)
    local qb_metadata_result = MySQL.query.await(qb_metadata_query, params)
    if not qb_metadata_result or #qb_metadata_result == 0 then
        return
    end
    local qb_metadata = json.decode(qb_metadata_result[1].metadata)
    local player_skill_data = {}
    local player_licence_data = {}
    local player_reputation_data = {}
    for skill_id, skill_config in pairs(utils_data.skills) do
        if qb_metadata[skill_id] ~= nil then
            local current_xp = qb_metadata[skill_id]
            local level = 1
            local required_xp = calculate_required_xp(level, skill_config.first_level_xp, skill_config.growth_factor)
            while current_xp >= required_xp and level < skill_config.max_level do
                current_xp = math.floor(current_xp - required_xp)
                level = level + 1
                required_xp = calculate_required_xp(level, skill_config.first_level_xp, skill_config.growth_factor)
            end
            player_skill_data[skill_id] = {
                level = level,
                xp = current_xp,
                required_xp = required_xp,
                first_level_xp = skill_config.first_level_xp,
                growth_factor = skill_config.growth_factor,
                max_level = skill_config.max_level
            }
        else
            player_skill_data[skill_id] = {
                level = skill_config.level,
                xp = skill_config.start_xp,
                required_xp = calculate_required_xp(skill_config.level, skill_config.first_level_xp, skill_config.growth_factor),
                first_level_xp = skill_config.first_level_xp,
                growth_factor = skill_config.growth_factor,
                max_level = skill_config.max_level
            }
        end
    end
    if qb_metadata['licences'] then
        for licence_id, _ in pairs(utils_data.licences) do
            if licence_id == 'car' and qb_metadata['licences']['driver'] ~= nil then
                local passed = qb_metadata['licences']['driver'] or false
                if passed then
                    current_date = os.date('%Y-%m-%d %H:%M:%S')
                end
                player_licence_data[licence_id] = {
                    theory = passed,
                    practical = passed,
                    theory_date = passed and os.date('%Y-%m-%d %H:%M:%S') or nil,
                    practical_date = passed and os.date('%Y-%m-%d %H:%M:%S') or nil,
                    data = {}
                }
            elseif licence_id == 'firearms' and qb_metadata['licences']['weapon'] ~= nil then
                player_licence_data[licence_id] = {
                    theory = qb_metadata['licences']['weapon'],
                    practical = qb_metadata['licences']['weapon'],
                    theory_date = passed and os.date('%Y-%m-%d %H:%M:%S') or nil,
                    practical_date = passed and os.date('%Y-%m-%d %H:%M:%S') or nil,
                    data = {}
                }
            else
                player_licence_data[licence_id] = {
                    theory = qb_metadata['licences'][licence_id] or false,
                    practical = qb_metadata['licences'][licence_id] or false,
                    theory_date = passed and os.date('%Y-%m-%d %H:%M:%S') or nil,
                    practical_date = passed and os.date('%Y-%m-%d %H:%M:%S') or nil,
                    data = {}
                }
            end
        end
    end
    if qb_metadata['jobrep'] then
        for rep_id, rep_config in pairs(utils_data.reputation) do
            if qb_metadata['jobrep'][rep_id] ~= nil then
                local current_rep = qb_metadata['jobrep'][rep_id]
                local level = 1
                local required_rep = calculate_required_xp(level, rep_config.first_level_rep, rep_config.growth_factor)
                while current_rep >= required_rep and level < rep_config.max_level do
                    current_rep = math.floor(current_rep - required_rep)
                    level = level + 1
                    required_rep = calculate_required_xp(level, rep_config.first_level_rep, rep_config.growth_factor)
                end
                player_reputation_data[rep_id] = {
                    level = level,
                    current_rep = current_rep,
                    required_rep = required_rep,
                    first_level_rep = rep_config.first_level_rep,
                    growth_factor = rep_config.growth_factor,
                    max_level = rep_config.max_level
                }
            else
                player_reputation_data[rep_id] = {
                    level = rep_config.level,
                    current_rep = rep_config.start_rep,
                    required_rep = calculate_required_xp(rep_config.level, rep_config.first_level_rep, rep_config.growth_factor),
                    first_level_rep = rep_config.first_level_rep,
                    growth_factor = rep_config.growth_factor,
                    max_level = rep_config.max_level
                }
            end
        end
    end
    update_or_insert_data(_src, 'skills', 'player_skills', player_skill_data)
    update_or_insert_data(_src, 'licences', 'player_licences', player_licence_data)
    update_or_insert_data(_src, 'reputation', 'player_reputation', player_reputation_data)
end

--- Server event to trigger the conversion of qb-core metadata.
RegisterServerEvent('fivem_utils:sv:run_qb_meta_convert', function()
    local _src = source
    convert_qb_metadata(_src)
end)

return fw