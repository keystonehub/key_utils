local styles = utils.get_module('styles')

local character_creation = {}

--- @section Tables

--- Facial feature identifiers and corresponding data keys.
--- @field FACIAL_FEATURES table: Stores facial features data.
--- @see set_ped_appearance
local FACIAL_FEATURES = {
    { id = 0, value = 'nose_width' }, { id = 1, value = 'nose_peak_height' }, { id = 2, value = 'nose_peak_length' },
    { id = 3, value = 'nose_bone_height' }, { id = 4, value = 'nose_peak_lower' }, { id = 5, value = 'nose_twist' },
    { id = 6, value = 'eyebrow_height' }, { id = 7, value = 'eyebrow_depth' }, { id = 8, value = 'cheek_bone' },
    { id = 9, value = 'cheek_sideways_bone' }, { id = 10, value = 'cheek_bone_width' },
    { id = 11, value = 'eye_opening' }, { id = 12, value = 'lip_thickness' }, { id = 13, value = 'jaw_bone_width' },
    { id = 14, value = 'jaw_bone_shape' }, { id = 15, value = 'chin_bone' }, { id = 16, value = 'chin_bone_length' },
    { id = 17, value = 'chin_bone_shape' }, { id = 18, value = 'chin_hole' }, { id = 19, value = 'neck_thickness' }
}

--- Overlay identifiers and corresponding data keys for style, opacity, and colour.
--- @field OVERLAYS table: Stores overlay data.
--- @see set_ped_appearance
local OVERLAYS = {
    {index = 2, style = 'eyebrow', opacity = 'eyebrow_opacity', colour = 'eyebrow_colour' },
    {index = 1, style = 'facial_hair', opacity = 'facial_hair_opacity', colour = 'facial_hair_colour' },
    {index = 10, style = 'chest_hair', opacity = 'chest_hair_opacity', colour = 'chest_hair_colour' },
    {index = 4, style = 'make_up', opacity = 'make_up_opacity', colour = 'make_up_colour' },
    {index = 5, style = 'blush', opacity = 'blush_opacity', colour = 'blush_colour' },
    {index = 8, style = 'lipstick', opacity = 'lipstick_opacity', colour = 'lipstick_colour' },
    {index = 0, style = 'blemish', opacity = 'blemish_opacity' },
    {index = 11, style = 'moles', opacity = 'moles_opacity' },
    {index = 3, style = 'ageing', opacity = 'ageing_opacity' },
    {index = 6, style = 'complexion', opacity = 'complexion_opacity' },
    {index = 7, style = 'sun_damage', opacity = 'sun_damage_opacity' },
    {index = 9, style = 'body_blemish', opacity = 'body_blemish_opacity' }
}

--- Clothing item identifiers and corresponding data keys for style, texture, and prop status.
--- @field CLOTHING_ITEMS table: Stores clothing items data.
--- @see set_ped_appearance
local CLOTHING_ITEMS = {
    {index = 1, style = 'mask_style', texture = 'mask_texture' },
    {index = 11, style = 'jacket_style', texture = 'jacket_texture' },
    {index = 8, style = 'shirt_style', texture = 'shirt_texture' },
    {index = 9, style = 'vest_style', texture = 'vest_texture' },
    {index = 4, style = 'legs_style', texture = 'legs_texture' },
    {index = 6, style = 'shoes_style', texture = 'shoes_texture' },
    {index = 3, style = 'hands_style', texture = 'hands_texture' },
    {index = 5, style = 'bag_style', texture = 'bag_texture' },
    {index = 10, style = 'decals_style', texture = 'decals_texture' },
    {index = 7, style = 'neck_style', texture = 'neck_texture' },
    {index = 0, style = 'hats_style', texture = 'hats_texture', is_prop = true},
    {index = 1, style = 'glasses_style', texture = 'glasses_texture', is_prop = true},
    {index = 2, style = 'earwear_style', texture = 'earwear_texture', is_prop = true},
    {index = 6, style = 'watches_style', texture = 'watches_texture', is_prop = true},
    {index = 7, style = 'bracelets_style', texture = 'bracelets_texture', is_prop = true}
}

--- @section Variables

--- Current sex of the player. Used to determine specific appearance settings.
--- This can be 'm' or 'f' and affects how certain appearance data is applied.
local current_sex = 'm'

--- Model identifier for the preview ped.
local preview_ped = (current_sex == 'm') and 'mp_m_freemode_01' or 'mp_f_freemode_01'

--- Camera object for viewing the ped.
local cam = nil

--- @section Internal Helper Functions

--- Apply an overlay to the ped.
--- @param player PlayerPedId(): The players ped instance.
--- @param overlay table: Overlay configuration containing index, style, opacity, and color keys.
--- @param barber_data table: Barber data containing overlay values.
local function apply_overlay(player, overlay, barber_data)
    local style = tonumber(barber_data[overlay.style]) or 0
    local opacity = (tonumber(barber_data[overlay.opacity]) or 0) / 100
    SetPedHeadOverlay(player, overlay.index, style, opacity)
    if overlay.colour then
        local colour = tonumber(barber_data[overlay.colour])
        if colour then
            SetPedHeadOverlayColor(player, overlay.index, 1, colour, colour)
        else
            utils.debug_log('err', 'Invalid overlay colour for ' .. overlay.style)
        end
    end
end

--- Apply a clothing item to the ped.
--- @param player PlayerPedId(): The players ped instance.
--- @param item table: Clothing item configuration containing index, style, and texture keys.
--- @param clothing_data table: Clothing data containing item values.
local function apply_clothing(player, item, clothing_data)
    local style = tonumber(clothing_data[item.style]) or -1
    local texture = tonumber(clothing_data[item.texture]) or 0
    if style >= 0 then
        if item.is_prop then
            SetPedPropIndex(player, item.index, style, texture, true)
        else
            SetPedComponentVariation(player, item.index, style, texture, 0)
        end
    end
end

--- Apply tattoos to the ped.
--- @param player PlayerPedId(): The player's ped instance.
--- @param tattoos table: Table of tattoo data containing zones and tattoo info.
--- @param sex string: The sex of the ped ('m' or 'f').
local function apply_tattoos(player, tattoos, sex)
    if not tattoos then utils.debug_log('err', 'No tattoo data found in character data.') return end
    for zone, tattoo_info in pairs(tattoos) do
        if tattoo_info and tattoo_info.name and tattoo_info.name ~= 'none' then
            local tattoo_hash = sex == 'm' and GetHashKey(tattoo_info.hash_m) or GetHashKey(tattoo_info.hash_f)
            if tattoo_hash and tattoo_info.collection then
                SetPedDecoration(player, GetHashKey(tattoo_info.collection), tattoo_hash)
            else
                utils.debug_log('err', 'Invalid tattoo hash or collection in zone: ' .. zone)
            end
        end
    end
end

--- @section Local functions

--- Gets clothing and prop values for UI inputs.
--- @param sex string: The sex of the current ped model ('m' or 'f').
--- @return table: A table with the maximum values for each clothing and prop item.
local function get_clothing_and_prop_values(sex)
    if not sex == 'm' or not sex == 'f' then utils.debug_log('err', "Function: get_clothing_and_prop_values failed | Reason: Invalid parameters for sex. - Use 'm' or 'f' only.") return end
    local data = styles.style[sex]
    local values = {
        hair = GetNumberOfPedDrawableVariations(PlayerPedId(), 2) - 1,
        fade = GetNumberOfPedTextureVariations(PlayerPedId(), 2, tonumber(data.barber.hair)) - 1,
        eyebrow = GetPedHeadOverlayNum(2) - 1,
        mask = GetNumberOfPedDrawableVariations(PlayerPedId(), 1) - 1,
        mask_texture = GetNumberOfPedTextureVariations(PlayerPedId(), 1, tonumber(data.clothing.mask_style) - 1)
    }
    return values
end

exports('get_clothing_and_prop_values', get_clothing_and_prop_values)
character_creation.get_clothing_and_prop_values = get_clothing_and_prop_values

--- Set ped hair, makeup, genetics, and clothing etc.
--- @param player PlayerPedId(): The players ped instance.
--- @param data table: The data object containing appearance settings for genetics, hair, makeup, tattoos, and clothing.
local function set_ped_appearance(player, data)
    if not player or not data then utils.debug_log('err', 'Function: set_ped_appearance failed | Reason: Missing required parameters (player or data).') return end
    local genetics = data.genetics
    SetPedHeadBlendData(player, genetics.mother, genetics.father, nil, genetics.mother, genetics.father, nil, genetics.resemblence, genetics.skin, nil, true)
    SetPedEyeColor(player, genetics.eye_colour)
    local barber = data.barber
    SetPedComponentVariation(player, 2, barber.hair, 0, 0)
    SetPedHairColor(barber.hair_colour, barber.highlight_colour)
    for _, feature in ipairs(FACIAL_FEATURES) do
        SetPedFaceFeature(player, feature.id, tonumber(genetics[feature.value]) or 0)
    end
    for _, overlay in ipairs(OVERLAYS) do
        apply_overlay(player, overlay, barber)
    end
    for _, item in ipairs(CLOTHING_ITEMS) do
        apply_clothing(player, item, data.clothing)
    end
    ClearPedDecorations(player)
    apply_tattoos(player, data.tattoos, data.sex)
    utils.debug_log('info', 'Ped appearance successfully updated.')
end

exports('set_ped_appearance', set_ped_appearance)
character_creation.set_ped_appearance = set_ped_appearance

--- Updates styles.style with new values to be displayed on the player.
--- @param sex string: The sex to select from creation style.
--- @param data_type string: The type of data being updated (e.g., 'genetics', 'barber').
--- @param index string: The specific index within the data type being updated.
--- @param data table: The new values to be set.
local function update_ped_data(sex, category, id, value)
    if not sex or not category or not id or not value then  utils.debug_log('err', 'Function: update_ped_data failed | Reason: Missing one or more required parameters. - sex, category, id, or value.')  return end
    if id == 'resemblance' or id == 'skin' then
        value = value / 100
    end
    if type(styles.style[sex][category][id]) == 'table' then -- 198
        for k, _ in pairs(styles.style[sex][category][id]) do
            styles.style[sex][category][id][k] = value[k]
        end
    else
        styles.style[sex][category][id] = value
    end
    current_sex = sex
    preview_ped = (sex == 'm') and 'mp_m_freemode_01' or 'mp_f_freemode_01'
    set_ped_appearance(PlayerPedId(), styles.style[sex])
end

exports('update_ped_data', update_ped_data)
character_creation.update_ped_data = update_ped_data

--- Change the players ped model based on the selected sex.
--- @param sex string: The sex of the ped model to switch to ('m' or 'f').
local function change_player_ped(sex)
    if not sex then
        utils.debug_log('err', 'Function: change_player_ped failed. | Reason: Player sex was not provided.')
        return
    end
    current_sex = sex
    preview_ped = (sex == 'm') and 'mp_m_freemode_01' or 'mp_f_freemode_01'
    local model = GetHashKey(preview_ped)
    utils.requests.model(model)
    SetPlayerModel(PlayerId(), model)
    set_ped_appearance(PlayerPedId(), styles.style[sex])
end

exports('change_player_ped', change_player_ped)
character_creation.change_player_ped = change_player_ped

--- Rotate the player's ped in a specific direction.
--- @param direction string: The direction to rotate the ped ('right', 'left', 'flip', 'reset').
local function rotate_ped(direction)
    if not direction then
        return utils.debug_log('err', 'Function: rotate_ped failed. | Reason: Direction parameter is missing.')
    end
    local player_ped = PlayerPedId()
    local current_heading = GetEntityHeading(player_ped)
    original_heading = original_heading or current_heading
    local rotations = {
        right = current_heading + 45,
        left = current_heading - 45,
        flip = current_heading + 180,
        reset = original_heading
    }
    local new_heading = rotations[direction]
    if not new_heading then
        return utils.debug_log('err', 'Function: rotate_ped failed. | Reason: Invalid direction parameter - Use "right", "left", "flip", "reset".')
    end
    if direction == 'rotate_ped_reset' then
        original_heading = nil
    end
    SetEntityHeading(player_ped, new_heading)
end

exports('rotate_ped', rotate_ped)
character_creation.rotate_ped = rotate_ped

--- Load and apply a character model.
--- @function load_character_model
--- @param data table: All the data for the players character to be set on the ped.
local function load_character_model(data)
    if not data.identity or not data.style.genetics or not data.style.barber or not data.style.clothing or not data.style.tattoos then utils.debug_log('err', 'Function: load_character_model failed. | Reason: One or more required parameters are missing.') return end

    current_sex = data.identity.sex
    
    local model = GetHashKey(preview_ped)
    if not utils.requests.model(model) then utils.debug_log('err', 'Function: load_character_model failed. | Reason: Failed to request model: ' .. preview_ped) return end
    local player_id = PlayerId()
    local player_ped = PlayerPedId()
    SetPlayerModel(player_id, model)
    SetPedComponentVariation(player_ped, 0, 0, 0, 1)
    styles.style[current_sex].genetics = data.style.genetics
    styles.style[current_sex].barber = data.style.barber
    styles.style[current_sex].clothing = data.style.clothing
    styles.style[current_sex].tattoos = data.style.tattoos
    set_ped_appearance(player_ped, styles.style[current_sex])
end

exports('load_character_model', load_character_model)
character_creation.load_character_model = load_character_model

return character_creation