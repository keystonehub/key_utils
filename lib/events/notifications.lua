--- @section Modules

local NOTIFICATIONS = require("modules.notifications")

--- @section Events

if not IS_SERVER then

    --- Send notifications.
    --- @param options table: Options for notification.
    RegisterNetEvent("key_utils:cl:send_notification", function(options)
        NOTIFICATIONS.send(options)
    end)
    
end