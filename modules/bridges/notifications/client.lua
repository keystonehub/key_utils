local notifications = {}

--- @section Handlers

local handlers = {
    default = function(options)
        TriggerEvent('fivem_utils:cl:notify', { type = options.type, header = options.header, message = options.message, duration = options.duration })
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
        local type_mapping = { information = 'primary', info = 'primary' }
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

local NOTIFICATIONS = detect_handler()
print(('[Notifications] Handler set to: %s'):format(NOTIFICATIONS))

--- @section Local Functions

--- Notification bridge function.
--- @param options table: The notification options (type, message, header, duration).
local function notify(options)
    if not options or not options.type or not options.message then
        utils.debug_log('error', '[Notifications] Invalid notification data provided.')
        return
    end
    local handler = handlers[NOTIFICATIONS] or handlers.default
    handler(options)
end

exports('send_notification', notify)
notifications.send = notify

return notifications
