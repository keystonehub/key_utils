--- Shared loader for timestamps.
local timestamps = {}

--- Get the current time for logging.
--- @return string: The formatted current time in 'YYYY-MM-DD HH:MM:SS' format.
local function get_current_time()
    local is_server = IsDuplicityVersion() and 'server' or 'client'
    return is_server and os.date('%Y-%m-%d %H:%M:%S') or (string.format('%04d-%02d-%02d %02d:%02d:%02d', GetLocalTime()) or "0000-00-00 00:00:00")
end

exports('get_current_time', get_current_time)
timestamps.get_current_time = get_current_time

return timestamps