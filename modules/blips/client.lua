local blips = {}

--- @section Tables

local created_blips = {}
local category_state = {}

--- @section Internal Functions

---  Check if a blip exists
local function is_valid_blip(blip)
    return DoesBlipExist(blip) and created_blips[blip]
end

--- Add a blip to the created_blips table
local function save_blip(blip, data)
    created_blips[blip] = data
end

--- Remove a blip from the created_blips table
local function delete_blip(blip)
    created_blips[blip] = nil
end

--- @section Local Functions

--- Create a new blip
--- @param blip_data table: Data for the blip (coords, sprite, color, scale, label, category).
local function create_blip(blip_data)
    local blip = AddBlipForCoord(blip_data.coords.x, blip_data.coords.y, blip_data.coords.z)
    SetBlipSprite(blip, blip_data.sprite)
    SetBlipColour(blip, blip_data.color)
    SetBlipScale(blip, blip_data.scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blip_data.label)
    EndTextCommandSetBlipName(blip)
    save_blip(blip, {
        coords = blip_data.coords,
        sprite = blip_data.sprite,
        color = blip_data.color,
        scale = blip_data.scale,
        label = blip_data.label,
        category = blip_data.category
    })
end

exports('create_blip', create_blip)
blips.create_blip = create_blip

--- Create multiple blips
--- @param blip_list table: A list of blip data tables.
local function create_blips(blip_list)
    for _, blip_data in ipairs(blip_list) do
        create_blip(blip_data)
    end
end

exports('create_blips', create_blips)
blips.create_blips = create_blips

--- Remove a single blip
--- @param blip number: The blip to remove.
local function remove_blip(blip)
    if is_valid_blip(blip) then
        RemoveBlip(blip)
        delete_blip(blip)
    end
end

exports('remove_blip', remove_blip)
blips.remove_blip = remove_blip

--- Remove all blips
local function remove_all_blips()
    for blip in pairs(created_blips) do
        RemoveBlip(blip)
    end
    created_blips = {}
end

exports('remove_all_blips', remove_all_blips)
blips.remove_all_blips = remove_all_blips

--- Remove blips by category
--- @param category string: The category of blips to remove.
local function remove_blips_by_category(category)
    for blip, data in pairs(created_blips) do
        if data.category == category then
            RemoveBlip(blip)
            delete_blip(blip)
        end
    end
end

exports('remove_blips_by_category', remove_blips_by_category)
blips.remove_blips_by_category = remove_blips_by_category

--- Toggle blip visibility by category
--- @param category string: The category of blips to toggle.
--- @param state boolean: True to show, false to hide.
local function toggle_blips_by_category(category, state)
    local display = state and 2 or 0
    for blip, data in pairs(created_blips) do
        if data.category == category then
            SetBlipDisplay(blip, display)
        end
    end
    category_state[category] = state
end

exports('toggle_blips_by_category', toggle_blips_by_category)
blips.toggle_blips_by_category = toggle_blips_by_category

--- Update a blip property
--- @param blip number: The blip to update.
--- @param property string: The property to update (label, sprite, color, scale).
--- @param value any: The new value for the property.
local function update_blip_property(blip, property, value)
    if not is_valid_blip(blip) then return end
    if property == 'label' then
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(value)
        EndTextCommandSetBlipName(blip)
    elseif property == 'sprite' then
        SetBlipSprite(blip, value)
    elseif property == 'color' then
        SetBlipColour(blip, value)
    elseif property == 'scale' then
        SetBlipScale(blip, value)
    end
    created_blips[blip][property] = value
end

exports('update_blip_property', update_blip_property)
blips.update_blip_property = update_blip_property

--- Get all blips
--- @return table: A table of all created blips.
local function get_all_blips()
    return created_blips
end

exports('get_all_blips', get_all_blips)
blips.get_all_blips = get_all_blips

--- Get blips by category
--- @param category string: The category of blips to retrieve.
--- @return table: A table of blips in the specified category.
local function get_blips_by_category(category)
    local result = {}
    for blip, data in pairs(created_blips) do
        if data.category == category then
            table.insert(result, blip)
        end
    end
    return result
end

exports('get_blips_by_category', get_blips_by_category)
blips.get_blips_by_category = get_blips_by_category

return blips