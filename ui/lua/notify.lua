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
utils.notify = notify

--- @section Events

--- Event to send notifys
--- @param options table: The options for the notify.
RegisterNetEvent('fivem_utils:cl:notify', function(options)
    notify(options)
end)

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
