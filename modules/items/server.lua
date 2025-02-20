--- Get shared loader to construct.
local items = {}

--- @section Tables

--- Table to store item use handlers.
local usable_items = {}

--- @section Local functions

--- Function to register an item as usable.
--- @param item_id The identifier of the item.
--- @param use_function The function to be executed when the item is used.
local function register(item_id, use_function)
    usable_items[item_id] = use_function
end

exports('register_item', register)
items.register = register

--- Function to use a registered item
--- @param item_id The identifier of the item.
local function use_item(source, item_id)
    if usable_items[item_id] then
        usable_items[item_id](source, item_id)
    else
        print('Item with ID ' .. item_id .. ' is not registered as usable.')
    end
end

exports('use_item', use_item)
items.use = use_item

--- @section Events

--- Event to handle item use.
-- Triggered when a player uses an item.
--- @param item_id The identifier of the item being used.
RegisterServerEvent('fivem_utils:sv:use_item', function(item_id)
    local _src = source
    use_item(_src, item_id)
end)

--- @section Assignments

return items