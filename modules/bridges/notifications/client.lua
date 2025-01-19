local notifications = {}

--- @section Handlers

local handlers = {
    default = function(options)
        TriggerEvent('fivem_utils:notify', { type = options.type, header = options.header, message = options.message, duration = options.duration })
    end,
    boii_ui = function(options)
        TriggerEvent('boii_ui:notify', { type = options.type, header = options.header, message = options.message, duration = options.duration })
    end,
    ox_lib = function(options)
        TriggerEvent('ox_lib:notify', { type = options.type, title = options.header, description = options.message })
    end,
    es_extended = function(options)
        TriggerEvent('ESX:Notify', options.type, options.duration, options.message)
    end,
    ['qb-core'] = function(options)
        local type_mapping = { information = 'primary', info = 'primary' } --- Additional type mapping as qb does not cover "info" by default others may require also.
        options.type = type_mapping[options.type] or options.type
        TriggerEvent('QBCore:Notify', options.message, options.type, options.duration)
    end,
    okokNotify = function(options)
        TriggerEvent('okokNotify:Alert', options.header, options.message, options.type, options.duration)
    end,
    keystone = function(options)
        TriggerEvent('keystone:notify', { type = options.type, header = options.header, message = options.message, duration = options.duration })
    end,
}

--- Detect available notification handler.
local function detect_handler()
    local convar_priority = GetConvar('utils:notifications_priority', '["keystone", "boii_ui", "ox_lib", "qb-core", "es_extended", "okokNotify"]')
    local resource_priority = json.decode(convar_priority) or {}
    local convar_handler = GetConvar('utils:notifications', ''):lower()
    if handlers[convar_handler] then return convar_handler end
    for _, resource in ipairs(resource_priority) do
        if GetResourceState(resource) == 'started' then
            utils.debug_log('success', ('[Notifications] Auto-detected handler: %s'):format(resource))
            return resource
        end
    end
    return 'default'
end

local NOTIFICATIONS
NOTIFICATIONS = detect_handler()
utils.debug_log('info', ('[Notifications] NOTIFICATIONS handler set to: %s'):format(NOTIFICATIONS))

--- @section Local Functions

--- Notification bridge function.
--- @param options table: The notification options (type, message, header, duration).
local function notify(options)
    if not options or not options.type or not options.message then utils.debug_log('error', '[Notifications] Invalid notification data provided.') return end
    local handler = handlers[NOTIFICATIONS] or handlers.default
    handler(options)
end

exports('send_notification', notify)
notifications.send = notify

--- @section Events

--- Event to trigger notification from the server.
RegisterNetEvent('fivem_utils:cl:send_notification', function(options)
    notify(options)
end)

--- @section Testing

RegisterCommand('ui:test_notify_bridge', function()
    local notifications = {
        { type = 'success', header = 'Success', message = 'This is a success notification.' },
        { type = 'error', header = 'Error', message = 'This is an error notification.' },
        { type = 'info', header = 'Info', message = 'This is an info notification.' },
        { type = 'warning', header = 'Warning', message = 'This is a warning notification.' }
    }
    for i, notif in ipairs(notifications) do
        SetTimeout(i * 2000, function()
            notify(notif)
        end)
    end
end, false)

return notifications