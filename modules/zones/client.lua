local geometry = utils.get_module('geometry')

local zones = {}

--- @section Tables

local stored_zones = {}

--- @section Local functions

--- Gets all zones.
--- @function get_zones
local function get_zones()
    return stored_zones
end

exports('get_zones', get_zones)
zones.get_zones = get_zones

--- Draws debug shapes for the zones.
--- @param zone_type string: Type of zone to create debug for.
--- @param options table: Table of options for the zone.
local function draw_debug(zone_type, options)
    local render_distance = 50.0
    CreateThread(function()
        while options.debug do
            local player_coords = GetEntityCoords(PlayerPedId())
            local distance = #(player_coords - options.coords)
            if distance < render_distance then
                if zone_type == 'circle' then
                    utils.draw.marker({
                        type = 1,
                        coords = vector3(options.coords.x, options.coords.y, options.coords.z - 1.0),
                        dir = vector3(0.0, 0.0, 1.0),
                        rot = vector3(90.0, 0.0, 0.0),
                        scale = vector3(options.radius * 2, options.radius * 2, 1.0),
                        colour = {77, 203, 194, 100},
                        bob = false,
                        face_cam = false,
                        p19 = 2,
                        rotate = false,
                        texture_dict = nil,
                        texture_name = nil,
                        draw_on_ents = false
                    })
                elseif zone_type == 'box' then
                    local dimensions = {
                        width = options.width,
                        length = options.depth,
                        height = options.height
                    }
                    utils.draw.draw_3d_cuboid(options.coords, dimensions, options.heading, {77, 203, 194, 100})
                end
            end
            Wait(0)
        end
    end)
end

--- Adds a circle zone.
--- @param options table: Table of options for the zone.
local function add_circle_zone(options)
    stored_zones = stored_zones or {}
    stored_zones[options.id] = options
    TriggerServerEvent('fivem_utils:sv:add_zone', options)
    if options.debug then
        draw_debug('circle', options)
    end
end

exports('add_circle_zone', add_circle_zone)
zones.add_circle = add_circle_zone

--- Adds a box zone.
--- @param options table: Table of options for the zone.
local function add_box_zone(options)
    stored_zones = stored_zones or {}
    stored_zones[options.id] = options
    TriggerServerEvent('fivem_utils:sv:add_zone', options)
    if options.debug then
        draw_debug('box', options)
    end
end

exports('add_box_zone', add_box_zone)
zones.add_box = add_box_zone

--- Removes a zone.
--- @param id string: The unique identifier for the zone to remove.
local function remove_zone(id)
    zones[id] = nil
end

exports('remove_zone', remove_zone)
zones.remove_zone = remove_zone

--- Check if a point is inside a zone.
--- @param point vector3: The point to check.
--- @return boolean: True if the point is inside any zone, false otherwise.
local function is_in_zone(point)
    for id, zone in pairs(stored_zones) do
        if zone.type == 'circle' then
            if #(point - zone.center) <= zone.radius then
                return true
            end
        elseif zone.type == 'box' then
            if geometry.is_point_in_oriented_box(point, zone) then
                return true
            end
        end
    end
    return false
end

exports('is_in_zone', is_in_zone)
zones.is_in_zone = is_in_zone

--- @section Events

--- Syncs zones.
--- @param updated_zones table: Zones table received from server.
RegisterNetEvent('fivem_utils:cl:update_zones', function(updated_zones)
    stored_zones = updated_zones
end)

return zones