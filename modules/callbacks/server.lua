--- Get shared loader to construct.
local callbacks = {}

--- Stores callbacks.
local stored_callbacks = {}

--- @section Variables

--- Local variable to keep track of callback IDs.
--- @field callback_id number: Stores the current callback ID.
local callback_id = 0

--- @section Local functions

--- Registers a server-side callback.
--- @param name string: The name of the callback event.
--- @param cb function: The callback function to be executed.
local function register_callback(name, cb)
    stored_callbacks[name] = cb
end

exports('register_callback', register_callback)
callbacks.register = register_callback

--- Generates a new unique callback ID.
--- @return number: A new unique callback ID.
local function generate_callback_id()
    callback_id = callback_id + 1
    return callback_id
end

--- @section Events

--- Event handler for server-side stored_callbacks.
--- @param name string: The name of the callback event.
--- @param data table: The data passed from the client.
--- @param client_cb_id number: The callback ID generated on the client side.
RegisterServerEvent('fivem_utils:sv:trigger_callback')
AddEventHandler('fivem_utils:sv:trigger_callback', function(name, data, client_cb_id)
    local _src = source
    local callback = stored_callbacks[name]
    if callback then
        local server_cb_id = generate_callback_id()
        callback(_src, data, function(...)
            TriggerClientEvent('fivem_utils:cl:client_callback', _src, client_cb_id, server_cb_id, ...)
        end)
    else
        utils.debug_log('error', 'Callback not found make sure you have registered on the server:', name)
    end
end)

return callbacks