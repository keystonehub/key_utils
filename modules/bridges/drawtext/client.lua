local drawtext = {}

--- @section Handlers

local handlers = {
    default = {
        show = function(options)
            TriggerEvent('boii_utils:show_drawtext', options)
        end,
        hide = function()
            TriggerEvent('boii_utils:hide_drawtext')
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
    local convar_priority = GetConvar('utils:drawtext_priority', '["boii_ui", "ox_lib", "qb-core", "es_extended", "okokTextUI"]')
    local resource_priority = json.decode(convar_priority) or {}
    local convar_handler = GetConvar('utils:drawtext', ''):lower()
    if handlers[convar_handler] then
        return convar_handler
    end
    for _, resource in ipairs(resource_priority) do
        if GetResourceState(resource) == 'started' then
            print(('[Drawtext] Auto-detected handler: %s'):format(resource))
            return resource
        end
    end
    return 'default'
end

local DRAWTEXT
DRAWTEXT = detect_handler()
print(('[Drawtext] DRAWTEXT handler set to: %s'):format(DRAWTEXT))

--- Show drawtext.
--- @param options table: The drawtext UI options (header, message, icon).
local function show_drawtext(options)
    if not options or not options.message then
        debug_log('error', '[Drawtext] Invalid drawtext options provided.')
        return
    end
    local handler = handlers[DRAWTEXT] or handlers.default
    handler.show(options)
end

exports('drawtext_show', show_drawtext)
drawtext.show = show_drawtext

--- Hide drawtext.
local function hide_drawtext()
    local handler = handlers[DRAWTEXT] or handlers.default
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

--- @section Testing

--- Testing show drawtext command
RegisterCommand('ui:test_drawtext_bridge_show', function()
    show_drawtext({
        header = 'Test Header',
        message = 'This is a test message.',
        icon = 'fa-solid fa-circle-info'
    })
end, false)

--- Testing hide drawtext command
RegisterCommand('ui:test_drawtext_bridge_hide', function()
    hide_drawtext()
end, false)

return drawtext