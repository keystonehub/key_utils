local drawtext = {}

--- @section Handlers

local handlers = {
    default = {
        show = function(options)
            TriggerEvent('fivem_utils:show_drawtext', options)
        end,
        hide = function()
            TriggerEvent('fivem_utils:hide_drawtext')
        end
    },
    boii_ui = {
        show = function(options)
            exports.boii_ui:show_drawtext(options.header, options.message, options.icon)
        end,
        hide = function()
            exports.boii_ui:hide_drawtext()
        end
    },
    ox_lib = {
        show = function(options)
            lib.showTextUI(options.message, { icon = options.icon })
        end,
        hide = function()
            lib.hideTextUI()
        end
    },
    ['qb-core'] = {
        show = function(options)
            exports['qb-core']:DrawText(options.message)
        end,
        hide = function()
            exports['qb-core']:HideText()
        end
    },
    es_extended = {
        show = function(options)
            exports.es_extended:TextUI(options.message)
        end,
        hide = function()
            exports.es_extended:HideUI()
        end
    },
    okokTextUI = {
        show = function(options)
            exports['okokTextUI']:Open(options.message, 'lightgrey', 'left', true)
        end,
        hide = function()
            exports['okokTextUI']:Close()
        end
    }
}

--- @section Local Functions

--- Detect available handler.
local function detect_handler()
    local convar_handler = config.drawtext
    if handlers[convar_handler] and next(handlers[convar_handler]) then return convar_handler end
    local priority_list = config.drawtext_priority
    if not priority_list or #priority_list == 0 then return 'default' end
    for _, resource in ipairs(priority_list) do
        if GetResourceState(resource) == 'started' then return resource end
    end
    return 'default'
end

local DRAWTEXT
DRAWTEXT = detect_handler()
utils.debug_log('info', ('DRAWTEXT handler set to: %s'):format(DRAWTEXT))

--- Show drawtext.
--- @param options table: The drawtext UI options (header, message, icon).
local function show_drawtext(options)
    if not options or not options.message then debug_log('error', 'Invalid drawtext options provided.') return end
    local handler = handlersor handlers.default
    handler.show(options)
end

exports('drawtext_show', show_drawtext)
drawtext.show = show_drawtext

--- Hide drawtext.
local function hide_drawtext()
    local handler = handlers or handlers.default
    handler.hide()
end

exports('drawtext_hide', hide_drawtext)
drawtext.hide = hide_drawtext

--- @section Events

--- Show drawtext.
RegisterNetEvent('fivem_utils:cl:drawtext_show', function(options)
    show_drawtext(options)
end)

--- Hide drawtext.
RegisterNetEvent('fivem_utils:cl:drawtext_hide', function()
    hide_drawtext()
end)

return drawtext
