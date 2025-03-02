local tables = utils.get_module('tables')

--- @section Variables

local registered_functions = {}

--- @section Local Functions

--- Registers a function under a unique key for callbacks.
--- @param label string: The unique key to associate with the function.
--- @param func function: The function to register.
local function register_function(label, func)
    registered_functions[label] = func
end

--- Calls a registered function by its label.
--- @param label string: The key associated with the function.
--- @return The result of the function, or false if not found.
local function call_registered_function(label)
    if registered_functions[label] then
        return registered_functions[label]()
    else
        print('Function with label ' .. label .. ' not found.')
        return false
    end
end

--- Processes and filters menu options, replacing functions with callable references.
--- @param options table: The menu options to process.
--- @return A filtered table of menu options.
local function filter_menu(options)
    local processed_options = {}
    for _, option in ipairs(options) do
        local processed_option = tables.deep_copy(option)
        if type(processed_option.can_interact) == 'function' then
            local label = 'can_interact_' .. tostring(option.label):gsub(' ', '_'):gsub('%W', '')
            register_function(label, processed_option.can_interact)
            local success, result = pcall(call_registered_function, label)
            processed_option.interactable = success and result or false
            processed_option.can_interact = nil
        else
            processed_option.interactable = processed_option.disabled ~= true
        end
        if processed_option.submenu then
            processed_option.submenu = filter_menu(processed_option.submenu)
        end
        processed_options[#processed_options + 1] = processed_option
    end
    return processed_options
end

--- Opens the action menu with given data.
-- @param menu_data table: The menu data to open.
local function create_action_menu(menu_data)
    local filtered_menu = filter_menu(menu_data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'create_action_menu',
        menu = filtered_menu
    })
end

--- Exports and Utility Bindings
exports('action_menu', create_action_menu)
utils.action_menu = create_action_menu

--- @section NUI Callbacks

--- Event to close the action menu if required.
RegisterNUICallback('close_action_menu', function()
    SetNuiFocus(false, false)
    active = false
    SendNUIMessage({ action = 'close_action_menu' })
end)

--- Callback to trigger events from the menu
RegisterNUICallback('action_menu_trigger_event', function(data)
    local action_handlers = {
        ['function'] = function(action) action(data.action) end,
        ['client'] = function(action) TriggerEvent(action, data.params) end,
        ['server'] = function(action) TriggerServerEvent(action, data.params) end
    }
    local handler = action_handlers[data.action_type]
    if not handler then
        print('Error: Incorrect action type for key')
        return
    end
    handler(data.action)
    if data.should_close then
        SetNuiFocus(false, false)
        SendNUIMessage({ action = 'close_action_menu' })
    end
end)

--- @section Testing

--- Example test menu with submenus and actions
local test_menu = {
    {
        label = 'Main Menu',
        icon = 'fa-solid fa-bars',
        colour = '#4dcbc2',
        submenu = {
            {
                label = 'Submenu 1',
                icon = 'fa-solid fa-arrow-right',
                colour = '#4dcbc2',
                submenu = {
                    {
                        label = 'Action 1',
                        icon = 'fa-solid fa-cog',
                        colour = '#4dcbc2',
                        action_type = 'client',
                        action = 'some_event',
                        params = {}
                    },
                    {
                        label = 'Action 2',
                        icon = 'fa-solid fa-cog',
                        colour = '#4dcbc2',
                        action_type = 'client',
                        action = 'another_event',
                        params = {}
                    }
                }
            }
        }
    },
    {
        label = 'Quick Action',
        icon = 'fa-solid fa-bolt',
        action_type = 'client',
        action = 'utils:action_menu_test_event',
        params = {}
    }
}

--- Register test event for Quick Action
RegisterNetEvent('utils:action_menu_test_event', function()
    TriggerEvent('fivem_utils:cl:notify', { header = 'Action Menu', message = 'Test event triggered successfully!', type = 'success', duration = 3500 })
end)

--- Register command to open the action menu
RegisterCommand('ui:test_action', function()
    create_action_menu(test_menu)
end, false)
