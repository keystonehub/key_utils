--- @section Local Functions

--- Show progress circle with options
--- @param options table: Contains message and duration for the progress circle.
local function show_circle(options)
    SetNuiFocus(true, false)
    SendNUIMessage({
        action = 'show_circle',
        message = options.message or 'Loading...',
        duration = options.duration or 10
    })
end

exports('show_circle', show_circle)
utils.show_circle = show_circle

--- @section NUI Callbacks

RegisterNUICallback('circle_end', function()
    SetNuiFocus(false, false)
end)

--- @section Testing

RegisterCommand('ui:test_circle', function()
    show_circle({
        message = 'Testing circle..',
        duration = 10
    })
end)