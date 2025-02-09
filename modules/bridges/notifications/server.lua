local notifications = {}

--- All handers for the bridge are stored in the client.lua.
--- To add other handlers head over there.

--- Send notification to a specific client.
--- @param source number: The ID of the target player.
--- @param options table: The notification options (type, message, header, duration).
local function notify(source, options)
    if not source or not options or not options.type or not options.message then
        utils.debug_log('error', '[Notifications] Invalid parameters for notify function.')
        return
    end
    TriggerClientEvent('fivem_utils:cl:send_notification', source, options)
end

exports('send_notification', notify)
notifications.send = notify


return notifications