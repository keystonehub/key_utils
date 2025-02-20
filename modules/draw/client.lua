local geometry = utils.get_module('geometry')
local requests = utils.get_module('requests')

local draw = {}

--- @section Local Functions

--- Draws text with advanced customization.
--- @param params table: A table containing text drawing parameters.
local function text(params)
    local coords = params.coords or vector3(0.5, 0.5, 0.0)
    local content = params.content or ''
    local scale = params.scale or 1.0
    local colour = params.colour or {255, 255, 255, 255}
    local font = params.font or 0
    local alignment = params.alignment or 'left'
    local mode = params.mode or '2d'
    SetTextFont(font)
    SetTextProportional(1)
    SetTextColour(table.unpack(colour))
    SetTextEntry('STRING')
    AddTextComponentString(content)
    if alignment == 'center' then
        SetTextCentre(true)
    elseif alignment == 'right' then
        SetTextRightJustify(true)
        SetTextWrap(0.0, coords.x)
    end
    if mode == '2d' then
        SetTextScale(scale, scale)
        DrawText(coords.x, coords.y)
    elseif mode == '3d' then
        local cam_coords = GetGameplayCamCoords()
        local dist = #(cam_coords - coords)
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale_multiplier = scale * fov * (1 / dist) * 2
        SetTextScale(0.0 * scale_multiplier, 0.55 * scale_multiplier)
        SetDrawOrigin(coords.x, coords.y, coords.z, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
end

exports('draw_text', text)
draw.text = text

--- Draws a rotated 3D box using lines between corners after rotation.
--- Simplifies complex geometry visualizations.
--- @param corners table: A table of corner points of the box.
--- @param colour table: RGBA color for the box lines.
local function draw_rotated_box(corners, colour)
    if not corners or #corners < 1 then return utils.debug.warn('Invalid corners table provided to draw.draw_rotated_box.') end
    for i = 1, #corners do
        local next_index = (i % #corners) + 1
        DrawLine(corners[i].x, corners[i].y, corners[i].z, corners[next_index].x, corners[next_index].y, corners[next_index].z, table.unpack(colour))
    end
end

exports('draw_rotated_box', draw_rotated_box)
draw.draw_rotated_box = draw_rotated_box

--- Draws a 3D cuboid with edges.
--- Simplifies creating 3D box visualizations around a point.
--- @function draw_3d_cuboid
--- @param center vector3: The center of the cuboid.
--- @param dimensions table: The dimensions of the cuboid.
--- @param heading number: Rotation heading for the cuboid.
--- @param colour table: RGBA color for the edges.
local function draw_3d_cuboid(center, dimensions, heading, colour)
    if not center or not dimensions or not colour then return utils.debug.warn('Invalid parameters provided to draw.draw_3d_cuboid.') end
    local bottom_center = vector3(center.x, center.y, center.z - dimensions.height / 2)
    local bottom_corners = geometry.rotate_box(bottom_center, dimensions.width, dimensions.length, heading)
    local top_corners = {}
    for i, corner in ipairs(bottom_corners) do
        top_corners[i] = vector3(corner.x, corner.y, corner.z + dimensions.height)
    end
    draw_rotated_box(bottom_corners, colour)
    draw_rotated_box(top_corners, colour)
    for i = 1, #bottom_corners do
        DrawLine(bottom_corners[i].x, bottom_corners[i].y, bottom_corners[i].z, top_corners[i].x, top_corners[i].y, top_corners[i].z, table.unpack(colour))
    end
end

exports('draw_3d_cuboid', draw_3d_cuboid)
draw.draw_3d_cuboid = draw_3d_cuboid

--- Plays and draws a BINK movie on the screen until completion.
--- @param params table: A table containing movie drawing parameters.
local function movie(params)
    local bink = params.bink
    local coords = params.coords or {x = 0.5, y = 0.5}
    local scale = params.scale or {x = 1.0, y = 1.0}
    local rotation = params.rotation or 0.0
    local colour = params.colour or {255, 255, 255, 255}
    CreateThread(function()
        SetBinkMovieTime(bink, 0.0)
        while (GetBinkMovieTime(bink) < 100.0) do
            PlayBinkMovie(bink)
            DrawBinkMovie(bink, coords.x, coords.y, scale.x, scale.y, rotation, table.unpack(colour))
            Wait(0)
        end
    end)
end

exports('draw_movie', movie)
draw.movie = movie

--- Draws a Scaleform movie.
--- @param params table: A table containing Scaleform movie drawing parameters.
local function scaleform_movie(params)
    local mode = params.mode or 'fullscreen'
    local scaleform = params.scaleform
    local colour = params.colour or {255, 255, 255, 255}
    if mode == '3d' or mode == '3d_solid' then
        local coords = params.coords or vector3(0.0, 0.0, 0.0)
        local rotation = params.rotation or vector3(0.0, 0.0, 0.0)
        local scale = params.scale or vector3(1.0, 1.0, 1.0)
        local sharpness = params.sharpness or 15.0
        if mode == '3d' then
            DrawScaleformMovie_3d(scaleform, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, 2.0, sharpness, 2.0, scale.x, scale.y, scale.z, 2)
        else
            DrawScaleformMovie_3dSolid(scaleform, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, 2.0, sharpness, 2.0, scale.x, scale.y, scale.z, 2)
        end
    elseif mode == 'fullscreen' then
        local width = params.width or 1.0
        local height = params.height or 1.0
        DrawScaleformMovie(scaleform, 0.5, 0.5, width, height, colour[1], colour[2], colour[3], colour[4], 0)
    elseif mode == 'fullscreen_masked' then
        local scale_form_mask = params.scale_form_mask
        DrawScaleformMovieFullscreenMasked(scaleform, scale_form_mask, colour[1], colour[2], colour[3], colour[4])
    end
end

exports('draw_scaleform_movie', scaleform_movie)
draw.scaleform_movie = scaleform_movie

--- Draws an interactive sprite on the screen.
--- @param params table: A table containing interactive sprite drawing parameters.
local function interactive_sprite(params)
    local texture_dict = params.texture_dict
    local texture_name = params.texture_name
    local coords = params.coords or vector3(0.5, 0.5, 0.0)
    local size = params.size or {width = 1.0, height = 1.0}
    local rotation = params.rotation or 0.0
    local colour = params.colour or {255, 255, 255, 255}
    if not texture_dict or not texture_name then
        return utils.debug.warn('Invalid texture dictionary or name provided to draw.interactive_sprite function.')
    end
    requests.texture(texture_dict, true)
    DrawInteractiveSprite(texture_dict, texture_name, coords.x, coords.y, size.width, size.height, rotation, table.unpack(colour))
end

exports('draw_interactive_sprite', interactive_sprite)
draw.interactive_sprite = interactive_sprite

--- Draws a sprite polygon in the world, optionally with per-vertex colors.
--- @param params table: A table containing sprite polygon drawing parameters.
local function sprite_poly(params)
    local vertices = params.vertices or { vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0) }
    local texture_dict = params.texture_dict or 'deadline'
    local texture_name = params.texture_name or 'deadline_trail'
    local UVW = params.UVW or { {0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, {0.0, 0.0, 0.0} }
    local mode = params.mode or 'single'
    if mode == 'single' then
        local colour = params.colour or { 255, 0, 0, 255 }
        DrawSpritePoly(vertices[1].x, vertices[1].y, vertices[1].z, vertices[2].x, vertices[2].y, vertices[2].z, vertices[3].x, vertices[3].y, vertices[3].z, colour[1], colour[2], colour[3], colour[4], texture_dict, texture_name, UVW[1][1], UVW[1][2], UVW[1][3], UVW[2][1], UVW[2][2], UVW[2][3], UVW[3][1], UVW[3][2], UVW[3][3])
    elseif mode == 'multi' then
        local colours = params.colours or { {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255} }
        DrawSpritePoly_2(vertices[1].x, vertices[1].y, vertices[1].z, vertices[2].x, vertices[2].y, vertices[2].z, vertices[3].x, vertices[3].y, vertices[3].z, colours[1][1], colours[1][2], colours[1][3], colours[1][4], colours[2][1], colours[2][2], colours[2][3], colours[2][4], colours[3][1], colours[3][2], colours[3][3], colours[3][4], texture_dict, texture_name, UVW[1][1], UVW[1][2], UVW[1][3], UVW[2][1], UVW[2][2], UVW[2][3], UVW[3][1], UVW[3][2], UVW[3][3])
    end
end

exports('draw_sprite_poly', sprite_poly)
draw.sprite_poly = sprite_poly

--- Draws a light with a specified range, with an optional shadow.
--- @param params table: A table containing light drawing parameters.
local function light(params)
    local coords = params.coords or vector3(0.0, 0.0, 0.0)
    local colour = params.colour or {255, 255, 255}
    local range = params.range or 10.0
    local intensity = params.intensity or 1.0    
    if params.shadow then
        local shadow = params.shadow or 2.5
        DrawLightWithRangeAndShadow(coords.x, coords.y, coords.z, colour[1], colour[2], colour[3], range, intensity, shadow)
    else
        DrawLightWithRange(coords.x, coords.y, coords.z, colour[1], colour[2], colour[3], range, intensity)
    end
end

exports('draw_light', light)
draw.light = light

return draw