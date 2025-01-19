local environment_functions = utils.get_module('environment')
local player_functions = utils.get_module('player')
local draw_functions = utils.get_module('draw')

local developer = {}

--- @section Local Variables
local show_coords, vehicle_developer_mode, show_player_info, show_environment_info = false, false, false, false

--- @section Helper Functions

--- Starts a toggled display thread.
--- @param toggle boolean: The toggle variable controlling the display.
--- @param callback function: The function to execute inside the thread.
local function start_thread(toggle, callback)
    CreateThread(function()
        while toggle do
            callback()
            Wait(0)
        end
    end)
end

--- Renders text data on the screen.
--- @param x number: The x-coordinate of the text.
--- @param base_y number: The starting y-coordinate of the text.
--- @param increment_y number: The vertical spacing between lines.
--- @param text_data table: A table of {label, value} pairs to display.
local function render_text_data(x, base_y, increment_y, text_data)
    for _, entry in ipairs(text_data) do
        draw_functions.text({
            coords = vector3(x, base_y, 0.0),
            content = string.format('%s ~b~%s~s~', entry.label, entry.value),
            scale = 0.4,
            font = 4
        })
        base_y = base_y + increment_y
    end
end

--- @section Developer Functions

--- Toggles the display of the player's current coordinates.
local function toggle_coords()
    show_coords = not show_coords
    start_thread(show_coords, function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        local rounded_coords = {
            x = utils.maths.round_number(coords.x, 2),
            y = utils.maths.round_number(coords.y, 2),
            z = utils.maths.round_number(coords.z, 2),
            heading = utils.maths.round_number(heading, 2)
        }
        render_text_data(0.5, 0.025, 0.025, {
            { label = 'Coords (vector2):', value = string.format('vector2(%s, %s)', rounded_coords.x, rounded_coords.y) },
            { label = 'Coords (vector3):', value = string.format('vector3(%s, %s, %s)', rounded_coords.x, rounded_coords.y, rounded_coords.z) },
            { label = 'Coords (vector4):', value = string.format('vector4(%s, %s, %s, %s)', rounded_coords.x, rounded_coords.y, rounded_coords.z, rounded_coords.heading) }
        })
    end)
end

exports('toggle_coords', toggle_coords)
developer.toggle_coords = toggle_coords

--- Toggles the display of vehicle information.
local function toggle_vehicle_info()
    vehicle_developer_mode = not vehicle_developer_mode
    start_thread(vehicle_developer_mode, function()
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            local vehicle_data = {
                { label = 'Entity ID:', value = vehicle },
                { label = 'Net ID:', value = VehToNet(vehicle) },
                { label = 'Model:', value = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) },
                { label = 'Hash:', value = GetEntityModel(vehicle) },
                { label = 'Engine Health:', value = utils.maths.round_number(GetVehicleEngineHealth(vehicle), 2) },
                { label = 'Body Health:', value = utils.maths.round_number(GetVehicleBodyHealth(vehicle), 2) },
                { label = 'Speed (km/h):', value = utils.maths.round_number(GetEntitySpeed(vehicle) * 3.6, 1) },
                { label = 'Speed (mph):', value = utils.maths.round_number(GetEntitySpeed(vehicle) * 3.6 * 0.621371, 1) }
            }
            render_text_data(0.25, 0.588, 0.025, vehicle_data)
        end
    end)
end

exports('toggle_vehicle_info', toggle_vehicle_info)
developer.toggle_vehicle_info = toggle_vehicle_info

--- Toggles the display of player information.
local function toggle_player_info()
    show_player_info = not show_player_info
    start_thread(show_player_info, function()
        local player = PlayerId()
        local data = player_functions.get_player_details(player)
        local player_data = {
            { label = 'Server ID:', value = data.server_id },
            { label = 'Name:', value = data.name },
            { label = 'Max Stamina:', value = data.max_stamina },
            { label = 'Stamina:', value = data.stamina },
            { label = 'Health:', value = data.health },
            { label = 'Armor:', value = data.armor },
            { label = 'Coords:', value = string.format('vector4(%s, %s, %s, %s)', data.coords.x, data.coords.y, data.coords.z, data.coords.w) },
            { label = 'Model Hash:', value = data.model_hash },
            { label = 'Model Name:', value = data.model_name }
        }
        render_text_data(0.1, 0.2, 0.025, player_data)
    end)
end

exports('toggle_player_info', toggle_player_info)
developer.toggle_player_info = toggle_player_info

--- Toggles the display of environment information.
local function toggle_environment_info()
    show_environment_info = not show_environment_info
    start_thread(show_environment_info, function()
        local current_time = environment_functions.get_game_time().formatted
        local weather_next_name = environment_functions.get_weather_name(weather_next)
        local weather_prev_name = environment_functions.get_weather_name(weather_prev)
        local direction = player_functions.get_cardinal_direction(PlayerPedId())
        local street = player_functions.get_street_name(PlayerPedId())
        render_text_data(0.8, 0.2, 0.025, {
            { label = 'Time:', value = current_time },
            { label = 'Next Weather:', value = weather_next_name },
            { label = 'Previous Weather:', value = weather_prev_name },
            { label = 'Direction:', value = direction },
            { label = 'Street:', value = street }
        })
    end)
end

exports('toggle_environment_info', toggle_environment_info)
developer.toggle_environment_info = toggle_environment_info

return developer