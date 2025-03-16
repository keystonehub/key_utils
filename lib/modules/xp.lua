--- @section Modules

local CALLBACKS <const> = require("modules.callbacks")
local CORE <const> = require("modules.core")

--- @module XP

local xp = {}

if ENV.IS_SERVER then

    --- @section Caching
    local player_xp = {}

    --- @section Helper Functions

    --- Calculates required experience points for the next level.
    --- @param current_level number: The current level of the skill.
    --- @param first_level_xp number: The experience points required for the first level.
    --- @param growth_factor number: The growth factor for experience points.
    --- @return number: The required XP for the next level.
    local function calculate_required_xp(current_level, first_level_xp, growth_factor)
        return math.floor(first_level_xp * (growth_factor ^ (current_level - 1)))
    end

--- Inserts a new skill entry for a player if it doesn't already exist.
--- @param source number: The player source ID.
--- @param xp_id string: The XP ID.
local function insert_new_xp(source, xp_id)
    print(("[DEBUG] Attempting to insert XP: %s for source: %d"):format(xp_id, source))

    local identifier = CORE.get_player_id(source) or get_identifiers(source).license
    if not identifier then 
        print("^1[ERROR] Failed to retrieve player identifier.^7") 
        return false 
    end
    print(("[DEBUG] Retrieved identifier: %s"):format(identifier))

    local xp_static = ENV.DATA.xp or load_data("xp")
    if not xp_static then
        print("^1[ERROR] Failed to load XP static data.^7")
        return false
    end

    local xp_data = xp_static[xp_id]
    if not xp_data then 
        print(("^1[ERROR] XP ID '%s' not found in ENV.DATA.xp^7"):format(xp_id)) 
        return false 
    end
    print(("[DEBUG] Retrieved XP Data: %s"):format(json.encode(xp_data)))

    local required_xp = calculate_required_xp(xp_data.level, xp_data.first_level_xp, xp_data.growth_factor)
    print(("[DEBUG] Calculated required XP: %d for level %d"):format(required_xp, xp_data.level))

    local query = 'INSERT IGNORE INTO utils_xp (identifier, xp_id, type, category, level, xp, xp_required, growth_factor, max_level, decay_rate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
    local result = MySQL.insert.await(query, {
        identifier, 
        xp_id, 
        xp_data.type, 
        xp_data.category, 
        xp_data.level,
        xp_data.xp,
        required_xp,
        xp_data.growth_factor, 
        xp_data.max_level or nil, 
        xp_data.decay_rate or nil
    })

    if result then
        print(("[DEBUG] Successfully inserted XP data for %s"):format(xp_id))
    else
        print(("^1[ERROR] Failed to insert XP data for %s^7"):format(xp_id))
    end

    return result
end


    --- Initializes XP data for a player.
    --- @param source number: The player source ID.
    local function init_xp(source)
        local identifier = CORE.get_player_id(source) or get_identifiers(source).license
        if not identifier then return {} end

        local query = 'SELECT xp_id, type, category, level, xp, xp_required, growth_factor, max_level, decay_rate FROM utils_xp WHERE identifier = ?'
        local results = MySQL.query.await(query, { identifier })

        local xp_data = {}
        for _, row in ipairs(results or {}) do
            xp_data[row.xp_id] = { type = row.type, category = row.category, level = row.level, xp = row.xp, xp_required = row.xp_required, growth_factor = row.growth_factor, max_level = row.max_level, decay_rate = row.decay_rate }
        end

        player_xp[source] = xp_data
        return xp_data
    end

    --- @section Module Functions

    --- Retrieves all XP data for a player.
    --- @param source number: The player source ID.
    --- @return table: The XP data for the player.
    local function get_all_xp(source)
        if not player_xp[source] then return init_xp(source) end
        return player_xp[source]
    end

    --- Retrieves a specific XP entry for a player.
    --- @param source number: The player source ID.
    --- @param xp_id string: The XP ID.
    --- @return table: The XP data for the specific ID.
    local function get_xp(source, xp_id)
        local all_xp = get_all_xp(source)
        return all_xp[xp_id]
    end

    --- Sets XP for a player.
    --- @param source number: The player source ID.
    --- @param xp_id string: The XP ID.
    --- @param amount number: The XP amount to set.
    local function set_xp(source, xp_id, amount)
        local identifier = CORE.get_player_id(source) or get_identifiers(source).license
        if not identifier then return false end

        local xp_entry = get_xp(source, xp_id)
        if not xp_entry then insert_new_xp(source, xp_id) end

        xp_entry.xp = amount
        local query = 'UPDATE utils_xp SET xp = ? WHERE identifier = ? AND xp_id = ?'
        MySQL.update.await(query, { amount, identifier, xp_id })

        return true
    end

    --- Adds XP to a player's skill/reputation.
    --- @param source number: The player source ID.
    --- @param xp_id string: The XP ID.
    --- @param amount number: The XP amount to add.
    local function add_xp(source, xp_id, amount)
        local identifier = CORE.get_player_id(source) or get_identifiers(source).license
        if not identifier then return false end

        local xp_entry = get_xp(source, xp_id)
        if not xp_entry then insert_new_xp(source, xp_id) end

        local new_xp = xp_entry.xp + amount
        if xp_entry.max_level and new_xp > xp_entry.max_level then new_xp = xp_entry.max_level end

        while new_xp >= xp_entry.xp_required do
            xp_entry.level = xp_entry.level + 1
            new_xp = new_xp - xp_entry.xp_required
            xp_entry.xp_required = calculate_required_xp(xp_entry.level, ENV.DATA.xp[xp_id].first_level_xp, xp_entry.growth_factor)
        end

        xp_entry.xp = new_xp
        local query = 'UPDATE utils_xp SET level = ?, xp = ?, xp_required = ? WHERE identifier = ? AND xp_id = ?'
        MySQL.update.await(query, { xp_entry.level, xp_entry.xp, xp_entry.xp_required, identifier, xp_id })

        return true
    end

    --- Removes XP from a player's skill/reputation.
    --- @param source number: The player source ID.
    --- @param xp_id string: The XP ID.
    --- @param amount number: The XP amount to remove.
    local function remove_xp(source, xp_id, amount)
        local identifier = CORE.get_player_id(source) or get_identifiers(source).license
        if not identifier then return false end

        local xp_entry = get_xp(source, xp_id)
        if not xp_entry then insert_new_xp(source, xp_id) end

        local new_xp = xp_entry.xp - amount
        if new_xp < 0 then new_xp = 0 end

        while new_xp < 0 and xp_entry.level > 1 do
            xp_entry.level = xp_entry.level - 1
            xp_entry.xp_required = calculate_required_xp(xp_entry.level, ENV.DATA.xp[xp_id].first_level_xp, xp_entry.growth_factor)
            new_xp = xp_entry.xp_required + new_xp
        end

        xp_entry.xp = new_xp
        local query = 'UPDATE utils_xp SET level = ?, xp = ?, xp_required = ? WHERE identifier = ? AND xp_id = ?'
        MySQL.update.await(query, { xp_entry.level, xp_entry.xp, xp_entry.xp_required, identifier, xp_id })

        return true
    end

    --- @section Function Assignments

    xp.get_all = get_all_xp
    xp.get = get_xp
    xp.set = set_xp
    xp.add = add_xp
    xp.remove = remove_xp

    --- @section Exports

    exports('get_all_xp', get_all_xp)
    exports('get_xp', get_xp)
    exports('set_xp', set_xp)
    exports('add_xp', add_xp)
    exports('remove_xp', remove_xp)

    --- @section Callbacks

    CALLBACKS.register('key_utils:sv:get_all_xp', function(source, data, cb)
        local player_xp = get_all_xp(source)
        if player_xp then
            cb({ success = true, xp = player_xp })
        else
            cb({ success = false, })
        end
    end)

else

    --- Gets all xp for the player.
    local function get_all_xp()
        CALLBACKS.trigger('key_utils:sv:get_all_xp', nil, function(response)
            if response.success and response.xp then
                return response.xp
            end
        end)
    end

    --- @section Function Assignments

    xp.get_all = get_all_xp

    --- @section Exports

    exports('get_all_xp', get_all_xp)

end

return xp
