local ITEMS <const> = require("modules.items")

if ENV.IS_SERVER then

    --- Event to handle item use.
    --- @param item_id The identifier of the item being used.
    RegisterServerEvent("key_utils:sv:use_item", function(item_id)
        local source = source
        ITEMS.use_item(source, item_id)
    end)

end