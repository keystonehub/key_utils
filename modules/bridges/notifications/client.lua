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
    local handler = config.notifications
    if handlers[handler] and type(handlers[handler]) == 'function' then 
        return handler 
    end
    local priority_list = config.notifications_priority
    if not priority_list or #priority_list == 0 then return 'default' end
    for _, resource in ipairs(priority_list) do
        if GetResourceState(resource) == 'started' then 
            return resource 
        end
    end
    return 'default'
end

local NOTIFICATIONS
NOTIFICATIONS = detect_handler()
utils.debug_log('info', ('Notification handler set to: %s'):format(NOTIFICATIONS))

--- @section Local Functions

--- Notification bridge function.
--- @param options table: The notification options (type, message, header, duration).
local function notify(options)
    if not options or not options.type or not options.message then utils.debug_log('error', 'Invalid notification data provided.') return end
    local handler = handlers[NOTIFICATIONS] or handlers.default
    handler(options)
end

exports('send_notification', notify)
notifications.send = notify

return notifications
