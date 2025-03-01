--- @section Events

--- Handle server callbacks.
--- @param client_cb_id number: The client callback ID.
--- @param server_cb_id number: The server callback ID (not directly used but can be logged or used for validation).
--- @param ... multiple: The data returned by the server callback.
RegisterNetEvent('fivem_utils:cl:client_callback')
AddEventHandler('fivem_utils:cl:client_callback', function(client_cb_id, server_cb_id, ...)
    local callback = stored_callbacks[client_cb_id]
    if callback then
        callback(...)
        stored_callbacks[client_cb_id] = nil
    end
end)
