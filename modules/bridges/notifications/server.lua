local notifications = {}

--- Send notification to a specific client.
--- @param source number: The ID of the target player.
--- @param options table: The notification options (type, message, header, duration).
local function notify(source, options)
    if not source or not options or not (options.type and options.message) then
        utils.debug_log('error', 'Invalid parameters for notify function.')
        return
    end
    local cache_id = source .. "_" .. options.message
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
