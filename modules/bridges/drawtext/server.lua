local drawtext = {}

--- All handers for the bridge are stored in the client.lua.
--- To add other handlers head over there.

--- @section Local Functions

--- Show drawtext for a specific client.
--- @param source number: The ID of the target player.
--- @param options table: The drawtext UI options (header, message, icon).
local function show_drawtext(source, options)
    if not source or not options or not options.message then
        print('[Drawtext] Invalid parameters for show_drawtext.')
        return
    end
    TriggerClientEvent('fivem_utils:cl:drawtext_show', source, options)
end

exports('drawtext_show', show_drawtext)
drawtext.show = show_drawtext

--- Hide drawtext for a specific client.
--- @param source number: The ID of the target player.
local function hide_drawtext(source)
    if not source then
        print('[Drawtext] Invalid parameters for hide_drawtext.')
        return
    end
    TriggerClientEvent('fivem_utils:cl:drawtext_hide', source)
end

exports('drawtext_hide', hide_drawtext)
drawtext.hide = hide_drawtext

return drawtext