--- @section Modules

local DRAWTEXT = require("modules.drawtext")

--- @section Events

if not IS_SERVER then

    --- Show drawtext.
    --- @param options table: Options for drawtext ui.
    RegisterNetEvent("key_utils:cl:drawtext_show", function(options)
        DRAWTEXT.show(options)
    end)

    --- Hide drawtext.
    RegisterNetEvent("key_utils:cl:drawtext_hide", function()
        DRAWTEXT.hide()
    end)

end