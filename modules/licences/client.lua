local licences = {}

--- @section Local Functions

--- Fetches all license data for the player client-side and logs the response.
local function get_licences()
    utils.callbacks.trigger('fivem_utils:sv:get_licences', {}, function(licences_data)
        if licences_data then
            utils.debug_log('info', 'Licenses data fetched: '.. json.encode(licences_data))
        else
            utils.debug_log('err', 'Failed to fetch licences data.')
        end
    end)
end

exports('get_licences', get_licences)
licences.get_licences = get_licences

--- Updates a specific license status client-side and logs the outcome.
--- @param licence_id string: The identifier of the licence.
--- @param test_type string: The type of test within the licence ('theory', 'practical').
--- @param passed boolean: The status to set for the specified test within the licence.
local function update_licence(licence_id, test_type, passed)
    utils.callbacks.trigger('fivem_utils:sv:update_licence', { licence_id = licence_id, test_type = test_type, passed = passed }, function(response)
        if response.success then
            utils.debug_log('info', 'License status updated successfully.')
        else
            utils.debug_log('err', 'Failed to update licence status.')
        end
    end)
end

exports('update_licence', update_licence)
licences.update = update_licence

--- Checks if a player has passed a specific part of the licence test and returns the result via a callback.
--- @param licence_id string: The identifier of the licence.
--- @param test_type string: The type of test within the licence ('theory', 'practical').
--- @param cb function: A callback function that handles the response.
local function check_licence(licence_id, test_type, cb)
    utils.callbacks.trigger('fivem_utils:sv:check_licence_passed', {licence_id = licence_id, test_type = test_type}, function(response)
        if response.passed then
            cb(true)
        else
            cb(false)
        end
    end)
end

exports('check_licence', check_licence)
licences.check_licence = check_licence

return licences