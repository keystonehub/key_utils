local callbacks = utils.get_module('callbacks')

local reputation = {}

--- @section Local functions

--- Retrieves all reputation data for the client side.
--- @return table: A table containing all reputation data.
local function get_reputations()
    callbacks.trigger('fivem_utils:sv:get_reputations', {}, function(reputation_data)
        if reputation_data then
            utils.debug_log('info', 'Reputation data fetched: '.. json.encode(reputation_data))
            return reputation_data
        else
            utils.debug_log('err', 'Failed to fetch reputation data.')
            return nil
        end
    end)
end

exports('get_reputations', get_reputations)
reputation.get_reputations = get_reputations

--- Retrieves specific data for a certain reputation.
--- @param reputation_name string: The name of the reputation to retrieve data for.
--- @return table: A table containing data for the specified reputation.
local function get_reputation(reputation_name)
    callbacks.trigger('fivem_utils:sv:get_reputations', {}, function(reputation_data)
        if reputation_data and reputation_data[reputation_name] then
            utils.debug_log('info', 'Data for reputation ' .. reputation_name .. ': ' .. json.encode(reputation_data[reputation_name]))
            return reputation_data[reputation_name]
        else
            utils.debug_log('err', 'Failed to fetch data for reputation ' .. reputation_name .. '.')
            return nil
        end
    end)
end

exports('get_reputation', get_reputation)
reputation.get_reputation = get_reputation

--- @section Assignments

return reputation
