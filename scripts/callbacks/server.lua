local callback_id = 0

--- Generates a new unique callback ID.
--- @return number: A new unique callback ID.
local function generate_callback_id()
    callback_id = callback_id + 1
    return callback_id
end

--- @section Events

--- Event handler for server-side callbacks.
--- @param name string: The name of the callback event.
--- @param data table: The data passed from the client.
--- @param client_cb_id number: The callback ID generated on the client side.
RegisterServerEvent('fivem_utils:sv:trigger_callback')
AddEventHandler('fivem_utils:sv:trigger_callback', function(name, data, client_cb_id)
    local _src = source
    local callback = stored_callbacks[name]
    local callback_names = {}
    for key in pairs(stored_callbacks) do
        callback_names[#callback_names  + 1] = key
    end
    utils.debug_log('info', ('[Trigger Callback] Available callbacks: [%s]'):format(table.concat(callback_names, ', ')))
    if callback then
        local server_cb_id = generate_callback_id()
        callback(_src, data, function(...)
            TriggerClientEvent('fivem_utils:cl:client_callback', _src, client_cb_id, server_cb_id, ...)
        end)
    else
        utils.debug_log('error', ('Callback not found: "%s". Available callbacks: [%s]'):format(name, table.concat(callback_names, ', ')))
    end
end)
