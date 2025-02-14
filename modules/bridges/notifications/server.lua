local notifications = {}

--- Send notification to a specific client.
--- @param source number: The ID of the target player.
--- @param options table: The notification options (type, message, header, duration).
local function notify(source, options)
    if not source or not options or not options.type or not options.message then
        utils.debug_log('error', '[Notifications] Invalid parameters for notify function.')
        return
    end
    local cache_id = ('%s_%s'):format(source, options.message)
    if notifications[cache_id] then return end
    notifications[cache_id] = true
    TriggerClientEvent('fivem_utils:cl:send_notification', source, options)
    SetTimeout(100, function()
        notifications[cache_id] = nil
    end)
end

exports('send_notification', notify)
notifications.send = notify

return notifications
