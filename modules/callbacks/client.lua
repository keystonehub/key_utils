local callbacks = {}

--- Stores callbacks.
stored_callbacks = stored_callbacks or {}

--- @section Local Functions

--- Trigger a server callback.
--- @param name string: The event name of the callback.
--- @param data table: The data to send to the server.
--- @param cb function: The callback function to handle the response.
local function callback(name, data, cb)
    local cb_id = math.random(1, 1000000)
    stored_callbacks[cb_id] = cb
    TriggerServerEvent('fivem_utils:sv:trigger_callback', name, data, cb_id)
end

callbacks.trigger = callback
exports('trigger_callback', callback)

return callbacks
