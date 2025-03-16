--- @section Local functions

--- Sends a notify.
--- @param options table: The options for the notify.
local function notify(options)
    SendNUIMessage({
        action = 'notify',
        type = options.type or 'info',
        header = options.header or nil,
        message = options.message or 'No message provided',
        duration = options.duration or 3500,
        style = options.style or nil
    })
end

exports('notify', notify)

--- @section Events

--- Event to send notifys
--- @param options table: The options for the notify.
RegisterNetEvent('key_utils:cl:notify', function(options)
    notify(options)
end)

--- @section Events

--- Bridge event was moved here to prevent doubling when getting notify bridge module.
RegisterNetEvent('key_utils:cl:send_notification', function(options)
    exports.key_utils:send_notification(options)
end)

--- @section Testing

RegisterCommand('ui:test_notify_bridge', function()
    local test_notifications = {
        { type = 'success', header = 'Success', message = 'This is a success notification.' },
        { type = 'error', header = 'Error', message = 'This is an error notification.' },
        { type = 'info', header = 'Info', message = 'This is an info notification.' },
        { type = 'warning', header = 'Warning', message = 'This is a warning notification.' },
    }
    for i, notif in ipairs(test_notifications) do
        SetTimeout(i * 2000, function()
            exports.key_utils:send_notification(notif)
        end)
    end
end, false)


--- @section Testing
RegisterCommand('ui:test_notify', function()
    local types = { 'success', 'error', 'info', 'warning', 'primary', 'secondary', 'light', 'dark', 'critical', 'neutral' }
    for i, notif_type in ipairs(types) do
        SetTimeout(i * 2000, function()
            notify({
                type = notif_type,
                header = string.upper(notif_type),
                message = 'This is a '.. notif_type .. ' notification example.',
                duration = 5000
            })
        end)
    end
end, false)
