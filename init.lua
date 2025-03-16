--- @script Utils Initialization
--- Initializes framework bridge, loads and caches relevant modules.

--- @section Environment

ENV = setmetatable({
    --- @section Cache

    DATA = {},
    MODULES = {},

    --- @section Natives

    RESOURCE_NAME = GetCurrentResourceName(),
    IS_SERVER = IsDuplicityVersion(),

    --- @section User Registry

    DEFFERAL_UPDATE_MESSAGES = GetConvar("utils:deferals_updates", "true") == "true", -- Defferal connection messages, disable with convars.
    UNIQUE_ID_PREFIX = GetConvar("utils:unique_id_prefix", "USER_"), -- Prefix is combined with digits below to create a unique id e.g, "USER_12345"
    UNIQUE_ID_CHARS = GetConvar("utils:unique_id_chars", "5"), -- Amount of random characters to use after prefix e.g, "ABC12"

    --- @section Framework Bridge

    --- Supported Frameworks: If you have changed the name of your core resource folder update it here.
    FRAMEWORKS = {
        -- If you use multiple cores you can adjust the priority loading order by changed the arrangement here.
        { key = "esx", resource = "es_extended" },
        { key = "keystone", resource = "keystone" },
        { key = "nd", resource = "ND_Core" },
        { key = "ox", resource = "ox_core" },
        { key = "qb", resource = "qb-core" },
        { key = "qbx", resource = "qbx_core" },
    },
    AUTO_DETECT_FRAMEWORK = true, -- If true FRAMEWORK convar setting will be overwritten with auto detection.
    FRAMEWORK = GetConvar("utils:framework", "standalone"), -- This should not be changed, set up convars correctly and change there if needed.

    --- @section UI Bridges

    --- Supported DrawText UIs: If you have changed the name of a resource folder update it here.
    DRAWTEXTS = {
        -- If you use multiple drawtext resource you can adjust the priority loading order by changed the arrangement here.
        { key = "boii", resource = "boii_ui" },
        { key = "esx", resource = "es_extended" },
        { key = "okok", resource = "okokTextUi" },
        { key = "ox", resource = "ox_lib" },
        { key = "qb", resource = "qb-core" }
    },
    AUTO_DETECT_DRAWTEXT = true, -- If true DRAWTEXT convar setting will be overwritten with auto detection.
    DRAWTEXT = GetConvar("utils:drawtext_ui", "default"), -- This should not be changed, set up convars correctly and change there if needed.

    --- Supported Notifys: If you have changed the name of a resource folder update it here.
    NOTIFICATIONS = {
        -- If you use multiple notify resources you can adjust the priority loading order by changed the arrangement here.
        { key = "boii", resource = "boii_ui" },
        { key = "esx", resource = "es_extended" },
        { key = "okok", resource = "okokNotify" },
        { key = "ox", resource = "ox_lib" },
        { key = "qb", resource = "qb-core" }
    },
    AUTO_DETECT_NOTIFY = true, -- If true NOTIFY convar setting will be overwritten with auto detection.
    NOTIFY = GetConvar("utils:notify", "default"), -- This should not be changed, set up convars correctly and change there if needed.

    --- @section Timers

    CLEAR_EXPIRED_COOLDOWNS = GetConvar("utils:clear_expired_cooldowns", "5"), -- Timer to clear expired cooldowns from cache in mins; default 5mins.

}, { __index = _G })

--- @section Resource Detection

--- Framework auto detection if `AUTO_DETECT_FRAMEWORK = true` or if convar is not explicity set.
if ENV.AUTO_DETECT_FRAMEWORK and ENV.FRAMEWORK == "standalone" then

    --- Detects current running framework if not started falls back to standalone.
    local function detect_framework()
        for _, res in ipairs(ENV.FRAMEWORKS) do
            if GetResourceState(res.resource) == "started" then
                print(res.resource..' is started')
                return res.key
            end
        end
        return "standalone"
    end

    ENV.FRAMEWORK = detect_framework()
end

--- Auto-detects the currently running DrawText UI resource if `AUTO_DETECT_DRAWTEXT = true` or if convar is not explicitly set.
if ENV.AUTO_DETECT_DRAWTEXT and ENV.DRAWTEXT == "default" then

    --- Detects the active DrawText UI resource if not found, falls back to default.
    local function detect_drawtext()
        for _, res in ipairs(ENV.DRAWTEXTS) do
            if GetResourceState(res.resource) == "started" then
                return res.key
            end
        end
        return "default"
    end

    ENV.DRAWTEXT = detect_drawtext()
end

--- Auto-detects the currently running Notify resource if `AUTO_DETECT_NOTIFY = true` or if convar is not explicitly set.
if ENV.AUTO_DETECT_NOTIFY and ENV.NOTIFY == "default" then

    --- Detects the active Notify resource if not found, falls back to default.
    local function detect_notify()
        for _, res in ipairs(ENV.NOTIFICATIONS) do
            if GetResourceState(res.resource) == "started" then
                return res.key
            end
        end
        return "default"
    end

    ENV.NOTIFY = detect_notify()
end

--- @section Preload Static Data

--- Load a specific data module.
--- @param name string: The name of the data file (without extension).
--- @return table|nil: The loaded data module or nil if loading fails.
function load_data(name)
    if ENV.DATA[name] then return ENV.DATA[name] end

    local path = ('lib/data/%s.lua'):format(name)
    local content = LoadResourceFile(GetCurrentResourceName(), path)
    if not content then print(('^1[ERROR] Data file not found: %s^7'):format(path)) return nil end

    local fn, err = load(content, ('@@%s/%s'):format(GetCurrentResourceName(), path), 't', _G)
    if not fn then print(('^1[ERROR] Error loading data file %s: %s^7'):format(path, err)) return nil end

    local success, result = pcall(fn)
    if not success then print(('^1[ERROR] Error executing data file %s: %s^7'):format(path, result)) return nil end

    ENV.DATA[name] = result
    return result
end

for _, name in ipairs({ "licences", "xp" }) do
    load_data(name)
end

--- CFX safe require function replaces _G.require.
--- @param name string: Name of module to require.
function cfx_require(name)
    local colours = { info = "^5", success = "^2", error = "^8", reset = "^7" }
    if ENV.MODULES[name] then return ENV.MODULES[name] end

    -- If you add any new locations you need to load modules from adjust pathing here.
    local clean_name = name:gsub("^modules%.", "")
    local paths = {
        ("lib/modules/%s.lua"):format(clean_name),
        ("lib/bridges/ui/%s.lua"):format(clean_name),
    }

    if clean_name == "core" and ENV.FRAMEWORK ~= "standalone" then
        paths[#paths + 1] = ("lib/bridges/frameworks/%s.lua"):format(ENV.FRAMEWORK)
    end

    local content, path
    for _, p in ipairs(paths) do
        content = LoadResourceFile(GetCurrentResourceName(), p)
        if content then path = p break end
    end

    if not content then print(("%s[ERROR]: Module not found: %s%s"):format(colours.error, clean_name, colours.reset)) return nil end

    local fn, err = load(content, ("@@%s/%s.lua"):format(GetCurrentResourceName(), path), "t", _G)
    if not fn then print(("%s[ERROR]: Load error in %s: %s%s"):format(colours.error, clean_name, err, colours.reset)) return nil end

    local result = fn()
    if type(result) ~= "table" then print(("%s[ERROR]: Module (%s) did not return a table.%s"):format(colours.error, clean_name, colours.reset)) return nil end

    ENV.MODULES[name] = result
    return result
end

--- Override global require for CFX.
_G.require = cfx_require

return {
    require = cfx_require
}