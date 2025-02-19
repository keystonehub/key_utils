--- Utility loader for module management
--- This script initializes and manages the loading of modules.

--- @section Debugging

local debug_enabled = config.debug

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
    'keystone', 
    'es_extended', 
    'ox_core', 
    'qb-core',
    'ND_Core'
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

exports('get_current_time', get_current_time)
utils.get_current_time = get_current_time

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

exports('debug_log', debug_log)
utils.debug_log = debug_log

--- @section Module Loading

--- Load a module and cache it.
--- @param module_name string: The name of the module to load.
--- @return table|nil: The loaded module or nil if loading failed.
local function load_module(module_name)
    if utils.loaded[module_name] and next(utils.loaded[module_name]) then
        debug_log('info', ('Module already cached and valid: %s'):format(module_name))
        return utils.loaded[module_name]
    end
    local paths = {
        ('modules/bridges/frameworks/%s'):format(module_name),
        ('modules/bridges/%s'):format(module_name),
        ('modules/%s'):format(module_name)
    }
    local module_content
    for _, path in ipairs(paths) do
        local shared_path = ('%s/shared.lua'):format(path)
        local context_path = ('%s/%s.lua'):format(path, utils.context)
        module_content = LoadResourceFile(utils.name, shared_path) or LoadResourceFile(utils.name, context_path)
        if module_content then break end
    end
    if not module_content then debug_log('error', ('Module not found: %s'):format(module_name)) return nil end
    local fn, err = load(module_content, ('@@%s/%s.lua'):format(utils.name, module_name), 't', _G)
    if not fn then return debug_log('error', ('Error loading module (%s): %s'):format(module_name, err)) end
    local result = fn()
    if type(result) ~= 'table' then return debug_log('error', ('Module (%s) did not return a table.'):format(module_name)) end
    utils.loaded[module_name] = result
    debug_log('success', ('Loaded module: %s'):format(module_name))
    return result
end

--- Load all modules with priority for specific modules (callbacks and commands first).
--- Handles loading and setting the correct framework bridge to utils.fw.
local function load_framework_bridge()
    -- Load priority modules first
    for _, module_name in ipairs({ 'callbacks', 'commands' --[[if for some reason you need more priority modules add here]] }) do
        if not load_module(module_name) then debug_log('error', ('Failed to load priority module: %s'):format(module_name)) return end
    end

    -- Load framework bridge
    for _, framework in ipairs(FRAMEWORKS) do
        local state = GetResourceState(framework)
        if state == 'started' then
            debug_log('info', ('Supported framework detected: %s'):format(framework))
            local framework_result = load_module(framework)
            if not framework_result then debug_log('error', ('Failed to load bridge functions for: %s'):format(framework)) return end
            utils.loaded.fw = framework_result
        end
    end
    if not utils.loaded.fw then debug_log('info', 'No compatible framework found. Running in standalone mode.') end
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

--- Preloads modules and shared data.
local function preload_modules()
    load_framework_bridge()
    for _, data_file in ipairs({ 'reputation', 'skills', 'licences' }) do
        load_data(data_file)
    end
end

--- Load modules & data on resource start primarily for dev restarts playerJoining should suffice in all accounts.
AddEventHandler('onResourceStart', preload_modules)

--- Load modules & data on player joining.
AddEventHandler('playerJoining', preload_modules)

--- @section Get Exports

--- Retrieve all loaded modules.
--- @return table: The utils table containing loaded modules.
local function get_modules()
    return utils.loaded
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
