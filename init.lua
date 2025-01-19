--- Utility loader for module management
--- This script initializes and manages the loading of modules.

--- @section Debugging

local debug_enabled = GetConvar('utils:debug', 'false') == 'true' -- Default is false in convars

--- @section Constants

--- The name of the current resource.
--- @type string
local RESOURCE_NAME <const> = GetCurrentResourceName()

--- Whether the current execution context is server-side.
--- @type boolean
local IS_SERVER <const> = IsDuplicityVersion()

--- Frameworks available for detection and loading framework bridges.
--- @type table<number, string>: An array of framework resource names.
local FRAMEWORKS <const> = { 
    'boii_core', 
    'es_extended', 
    'ox_core', 
    'qb-core' 
}

--- Modules to be loaded with priority before others.
--- @type table<number, string>: An array of priority module names.
local PRIORITY_MODULES <const> = { 
    'callbacks',
    'commands'
}

--- Debug note levels and colour.
--- You can add aditional levels if you like here then just access as normal.
--- Uses standard ^1 - ^9 colour codes.
--- @type table<number, string>: A table of kvp debug levels and colour.
local DEBUG_COLOURS = {
    reset = '^7', -- White: Used to reset colours back to white after initial details. 
    debug = '^6', -- Violet
    info = '^5', -- Cyan
    success = '^2', -- Green
    warn = '^3', -- Yellow
    error = '^8' -- Red 
}

--- @section Utils Object

--- Handles all utils modules for export.
--- @type table
utils = {
    name = RESOURCE_NAME,
    context = IS_SERVER and 'server' or 'client',
    loaded = { 
        fw = {} -- Preload for framework bridge
    },
    data = {}
}

--- @section Utility Functions

--- Get the current time for logging.
--- @return string: The formatted current time in 'YYYY-MM-DD HH:MM:SS' format.
local function get_current_time()
    return IS_SERVER and os.date('%Y-%m-%d %H:%M:%S') or (GetLocalTime and string.format('%04d-%02d-%02d %02d:%02d:%02d', GetLocalTime()) or "0000-00-00 00:00:00")
end

--- Logs debug messages with levels and optional data.
--- @param level string: The log level ('debug', 'info', 'success', 'warn', 'error').
--- @param message string: The message to log.
--- @param data table|nil: Optional data to include in the log.
local function debug_log(level, message, data)
    if not debug_enabled then return end
    local resource_name = GetInvokingResource() or 'UTILS'
    -- For some reason mapmanager invokes internal logs on load? 
    -- Not looked into why, dont really care why, but now it doesnt.
    if resource_name == 'mapmanager' then return end 

    print(('%s[%s] [%s] [%s]: %s%s'):format(DEBUG_COLOURS[level] or '^7', get_current_time(), resource_name:upper(), level:upper(), DEBUG_COLOURS.reset or '^7', message), data and json.encode(data) or '')
end

-- Export the debug log function
exports('debug_log', debug_log)
utils.debug_log = debug_log

RegisterCommand('utils:toggle_debug', function(source, args, rawCommand)
    if source ~= 0 then print('Command restricted to console.') return end
    debug_enabled = not debug_enabled
    SetConvar('debug_enabled', debug_enabled and 'true' or 'false')
    print('External debugging is now', debug_enabled and 'enabled' or 'disabled')
end)

--- @section Module Loading

--- Load a module and cache it.
--- @param module_name string: The name of the module to load.
--- @return table|nil: The loaded module or nil if loading failed.
local function load_module(module_name)
    if utils.loaded[module_name] then return utils.loaded[module_name] end
    local paths = {
        ('modules/bridges/frameworks/%s'):format(module_name),
        ('modules/bridges/%s'):format(module_name),
        ('modules/%s'):format(module_name)
    }
    local module_content
    for _, path in ipairs(paths) do
        module_content = LoadResourceFile(utils.name, path .. '/shared.lua') or LoadResourceFile(utils.name, path .. ('/%s.lua'):format(utils.context))
        if module_content then break end
    end
    if not module_content then
        debug_log('error', ('[Load Module] Module not found: %s'):format(module_name))
        return nil
    end
    local fn, err = load(module_content, ('@@%s/%s.lua'):format(utils.name, module_name), 't', _G)
    if not fn then
        debug_log('error', ('[Load Module] Error loading module (%s): %s'):format(module_name, err))
        return nil
    end
    local result = fn() or {}
    if type(result) ~= 'table' then
        debug_log('error', ('[Load Module] Module (%s) did not return a table.'):format(module_name))
        return nil
    end
    utils.loaded[module_name] = result
    debug_log('success', ('[Load Module] Loaded module: %s'):format(module_name))
    return result
end

--- Load all modules.
--- This function handles loading and setting the correct framework bridge to utils.fw.
local function load_framework_bridge()
    local active_framework
    for i = 1, #FRAMEWORKS do
        local framework = FRAMEWORKS[i]
        if GetResourceState(framework) == 'started' then
            debug_log('info', ('[Framework Bridge] Supported framework detected: %s'):format(framework))
            local framework_result = load_module(framework, true)
            if framework_result then
                utils.fw = framework_result
                debug_log('success', ('[Framework Bridge] Loaded bridge functions for: %s'):format(framework))
                break
            else
                debug_log('error', ('[Framework Bridge] Failed to load bridge functions for: %s'):format(framework))
            end
        end
    end
    if not utils.fw then debug_log('info', '[Framework Bridge] No compatible framework found. Running in standalone mode.') end
end

--- Load a specific data module.
--- @param name string: The name of the data file (without extension).
--- @return table|nil: The loaded data module or nil if loading fails.
local function load_data(name)
    if utils.data[name] then return utils.data[name] end
    local path = ('data/%s.lua'):format(name)

    local content = LoadResourceFile(GetCurrentResourceName(), path)
    if not content then debug_log('error', ('Data file not found: %s'):format(path)) return nil end

    local fn, err = load(content, ('@@%s/%s'):format(GetCurrentResourceName(), path), 't', _G)
    if not fn then debug_log('error', ('Error loading data file %s: %s'):format(path, err)) return nil end

    utils.data[name] = fn()
    return utils.data[name]
end

--- Load modules on resource start primarily for dev restarts playerJoining should suffice in all accounts.
AddEventHandler('onResourceStart', function()
    load_framework_bridge()
    load_data('reputation')
    load_data('skills')
    load_data('licences')
end)

--- Load modules on player joining.
AddEventHandler('playerJoining', function()
    load_framework_bridge()
    load_data('reputation')
    load_data('skills')
    load_data('licences')
end)

--- @section Get Exports

--- Retrieve all loaded modules.
--- @return table: The utils table containing loaded modules.
local function get_modules()
    return utils
end

exports('get_modules', get_modules)
utils.get_modules = get_modules

--- Retrieve a specific module.
--- @param module_name string: The name of the module to retrieve.
--- @return table|nil: The requested module or nil if not loaded.
local function get_module(module_name)
    return utils.loaded[module_name] or load_module(module_name)
end

exports('get_module', get_module)
utils.get_module = get_module

--- Retrieve all data.
--- @return table: A table containing all loaded data modules.
local function get_all_shared_data()
    return utils.data
end

exports('get_all_shared_data', get_all_shared_data)
utils.get_all_shared_data = get_all_shared_data

--- Retrieve specific data module.
--- @param name string: The name of the data module.
--- @return table|nil: The requested data module or nil if not found.
local function get_shared_data(name)
    return utils.data[name] or load_data(name)
end

exports('get_shared_data', get_shared_data)
utils.get_shared_data = get_shared_data