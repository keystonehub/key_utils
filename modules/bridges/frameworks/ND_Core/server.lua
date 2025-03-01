if config.framework ~= 'ND_Core' or GetResourceState('es_extended') ~= 'started' then return end

local callbacks = utils.get_module('callbacks')
local tables_module = utils.get_module('tables')

local fw = {}

--- @section Local Functions

--- Retrieves all players
--- @return players table
local function get_players()
    local players = exports.ND_Core:getPlayers()
    return players
end

exports('get_players', get_players)
fw.get_players = get_players

--- Retrieves player data from the server based on the framework.
--- @param source number: Player source identifier.
--- @return Player data object.
local function get_player(source)
    local player = exports.ND_Core:getPlayer(source)
    return player
end

exports('get_player', get_player)
fw.get_player = get_player

--- Retrieves player character unique id.
--- @param source number: Player source identifier.
--- @return Players main identifier.
local function get_player_id(source)
    local player = get_player(source)
    if not player then print('No player found for source: '..source) return false end

    local player_id = player.identifier
    return player_id
end

exports('get_player_id', get_player_id)
fw.get_player_id = get_player_id

--- Prepares query parameters for database operations.
--- @param source number: Player source identifier.
--- @return Query part and parameters.
local function get_id_params(source)
    local player = get_player(source)
    local query, params = 'identifier = ?', { player.identifier }
    return query, params
end

exports('get_id_params', get_id_params)
fw.get_id_params = get_id_params

--- Prepares data for SQL INSERT operations.
--- @param source number: Player source identifier.
--- @param data_type string: The type of data being inserted.
--- @param data_name string: The name of the data field.
--- @param data table: The data to insert.
--- @return Columns, values, and parameters.
local function get_insert_params(source, data_type, data_name, data)
    local player = get_player(source)
    local columns, values, params = { 'identifier', data_type }, '?, ?', { player.identifier, json.encode(data) }
    return columns, values, params
end

exports('get_insert_params', get_insert_params)
fw.get_insert_params = get_insert_params

--- Retrieves a player's identity information.
--- @param source number: Player source identifier.
--- @return Table of players identity information.
local function get_identity(source)
    local player = get_player(source)
    if not player then return false end

    local player_data = {
        first_name = player.getData('firstname'),
        last_name = player.getData('lastname'),
        dob = player.getData('dob'),
        sex = player.getData('gender'),
        nationality = 'LS, Los Santos' 
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
--- @param source number: Player source identifier.
--- @param item_name string: Name of the item to check.
--- @param item_amount number: (Optional) Amount of the item to check for.
--- @return True if the player has the item (and amount), False otherwise.
local function has_item(source, item_name, item_amount)
    local player = get_player(source)
    if not player then 
        print("Player not found:", source)
        return false 
    end
    local required_amount = item_amount or 1

    local count = exports.ox_inventory:Search(source, 'count', item_name)
    return count ~= nil and count >= required_amount
end

exports('has_item', has_item)
fw.has_item = has_item

--- Retrieves an item from the players inventory.
--- @param source number: Player source identifier.
--- @param item_name string: Name of the item to retrieve.
--- @return Item object if found, nil otherwise.
local function get_item(source, item_name)
    local player = get_player(source)
    if not player then return nil end

    local items = exports.ox_inventory:Search(source, 'items', item_name)
    if items and #items > 0 then
        local item = items[1]
        return item
    end
end

exports('get_item', get_item)
fw.get_item = get_item

--- Gets a player's inventory data
--- @param source Player source identifier.
--- @return The players inventory.
local function get_inventory(source)
    local player = get_player(source)
    if not player then return false end

    local inventory = exports.ox_inventory:GetInventory(source, false)
    return inventory
end

exports('get_inventory', get_inventory)
fw.get_inventory = get_inventory

--- Adjusts a player's inventory based on given options.
--- @param source number: Player source identifier.
--- @param options table: Options for inventory adjustment.
local function adjust_inventory(source, options)
    local player = get_player(source)
    if not player then return false end

    local function proceed()
        for _, item in ipairs(options.items) do
            if item.action == 'add' then
                exports.ox_inventory:AddItem(source, item.item_id, item.amount, item.data)exports.ox_inventory:AddItem(source, item.item_id, item.amount, item.data)
            elseif item.action == 'remove' then
                exports.ox_inventory:RemoveItem(source, item.item_id, item.amount, item.data)
            end
        end
    end

    if options.validation_data then
        callbacks.validate_distance(source, {location = options.validation_data.location, distance = options.validation_data.distance}, function(is_valid)
            if not is_valid then
                if options.validation_data.drop_player then
                    DropPlayer(source, 'Suspected range exploits.')
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
--- @param source number: The players source identifier.
--- @param item_id string: The ID of the item to update.
--- @param updates table: Table containing updates like ammo count, attachments etc.
local function update_item_data(source, item_id, updates)
    local player = get_player(source)
    if not player then print('Player not found') return end
    local item = get_item(source, item_id)
    if not item then print('Item not found:', item_id) return  end

    local items = exports.ox_inventory:Search(source, 1, item_id)
    for _, v in pairs(items) do
        for key, value in pairs(updates) do
            v.metadata[key] = value
        end
        exports.ox_inventory:SetMetadata(source, v.slot, v.metadata)
        break
    end
end

exports('update_item_data', update_item_data)
fw.update_item_data = update_item_data

--- Retrieves the balances of a player.
--- @param source number: Player source identifier.
--- @return A table of balances by type.
local function get_balances(source)
    local player = get_player(source)
    if not player then return false end

    local balances = { cash = player.getData('cash'), bank = player.getData('bank') } -- no function to get all balances directly
    return balances
end

exports('get_balances', get_balances)
fw.get_balances = get_balances

--- Retrieves a specific balance of a player by type.
--- @param source number: Player source identifier.
--- @param balance_type string: The type of balance to retrieve.
--- @return The balance amount for the specified type.
local function get_balance_by_type(source, balance_type)
    local balances = get_balances(source)
    if not balances then print('no balances') return false end

    local balance
    if balance_type == 'cash' then
        local cash_item = get_item(source, 'money')
        local cash_balance = cash_item and cash_item.count or 0
        balance = cash_balance
    else
        balance = balances[balance_type]
    end
    return balance
end

exports('get_balance_by_type', get_balance_by_type)
fw.get_balance_by_type = get_balance_by_type

--- Function to adjust a player's balance.
--- @param source number: Player source identifier.
--- @param options table: Table containing balance operations, validation data, reason for the adjustment, and whether to save the update.
local function adjust_balance(source, options)
    local player = get_player(source)
    if not player then print('player not found') return end

    local function proceed()
        for _, op in ipairs(options.operations) do
            if op.action == 'add' then
                if op.balance_type == 'cash' or op.balance_type == 'money' then
                    exports.ox_inventory:AddItem(source, 'money', op.amount)
                else
                    player.addMoney(op.balance_type, op.amount)
                end
            elseif op.action == 'remove' then
                if op.balance_type == 'cash' or op.balance_type == 'money' then
                    exports.ox_inventory:RemoveItem(source, 'money', op.amount)
                else
                    player.deductMoney(op.balance_type, op.amount)
                end
            end
        end
    end

    if options.validation_data then
        callbacks.validate_distance(source, {location = options.validation_data.location, distance = options.validation_data.distance}, function(is_valid)
            if not is_valid then
                if options.validation_data.drop_player then
                    DropPlayer(source, 'Suspected range exploits.')
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
--- @param source number: The players source identifier.
--- @return A table containing the players jobs and their on-duty status.
local function get_player_jobs(source)
    local player = get_player(source)

    local player_jobs = player.getJob()
    return player_jobs
end

exports('get_player_jobs', get_player_jobs)
fw.get_player_jobs = get_player_jobs

--- Checks if a player has one of the specified jobs and optionally checks their on-duty status.
--- @param source number: The players source identifier.
--- @param job_names table: An array of job names to check against the players jobs.
--- @param check_on_duty boolean: Optional boolean to also check if the player is on-duty for the job.
--- @return Boolean indicating if the player has any of the specified jobs and meets the on-duty condition.
local function player_has_job(source, job_names)
    local player_jobs = get_player_jobs(source)
    local job_found = false
    local on_duty_status = false
    if tables_module.contains(job_names, player_jobs.name) then
        job_found = true
        on_duty_status = true --- update if has method
    end
    return job_found and (not check_on_duty or on_duty_status)
end

exports('player_has_job', player_has_job)
fw.player_has_job = player_has_job

--- Retrieves a player's job grade for a specified job.
--- @param source number: The players source identifier.
--- @param job_id string: The job ID to retrieve the grade for.
--- @return The grade of the player for the specified job, or nil if not found.
local function get_player_job_grade(source, job_id)
    local player_jobs = get_player_jobs(source)
    if not player_jobs then print('No job data found for player. ' .. source) return nil end
    if player_jobs.id == job_id then
        return player_jobs.rank
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
--- @param source number: The players source identifier.
local function get_player_job_name(source)
    local player_jobs = get_player_jobs(source)
    local job_name
    if player_jobs then
        job_name = player_jobs.name
    end
    return job_name
end

exports('get_player_job_name', get_player_job_name)
fw.get_player_job_name = get_player_job_name

--- Modifies a player's server-side statuses.
--- @param source The players source identifier.
--- @param statuses The statuses to modify.
local function adjust_statuses(source, statuses)
    local player = get_player(source)
    if not player then print('Player not found') return end

    --- boii_statuses
    if GetResourceState('boii_statuses') == 'started' then
        local player_statuses = exports.boii_statuses:get_player(source)
        player_statuses.modify_statuses(statuses)
        return
    end

    --- @todo Add nd core status logic
end

exports('adjust_statuses', adjust_statuses)
fw.adjust_statuses = adjust_statuses

--- Register an item as usable for different frameworks.
--- @param item string: The item identifier.
--- @param cb function: The callback function to execute when the item is used.
local function register_item(item, cb)
    if not item then utils.debug_log('warn', 'Function: register_item | Note: Item identifier is missing') return end
    
    --- @todo Add nd method for register items?
end

exports('fw_register_item', register_item)
fw.register_item = register_item

--- @section Callbacks

--- Callback for checking if player has item by quantity.
callbacks.register('fivem_utils:sv:has_item', function(source, data, cb)
    local item_name = data.item_name
    local item_amount = data.item_amount or 1
    local player_has_item = false
    if has_item(source, item_name, item_amount) then
        player_has_item = true
    else
        player_has_item = false
    end
    cb(player_has_item)
end)

--- Callback for checking if player has the required job
callbacks.register('fivem_utils:sv:player_has_job', function(source, data, cb)
    local jobs = data.jobs
    local on_duty = data.on_duty
    local has_job = player_has_job(source, jobs, on_duty)
    cb(has_job)
end)

--- Callback for checking if player has the required job grade
callbacks.register('fivem_utils:sv:get_player_job_grade', function(source, data, cb)
    local job = data.job
    local job_grade = get_player_job_grade(source, job)
    cb(job_grade)
end)

--- Callback to get players inventory
callbacks.register('fivem_utils:sv:get_inventory', function(source, data, cb)
    local inventory = get_inventory(source)
    cb(inventory)
end)

return fw