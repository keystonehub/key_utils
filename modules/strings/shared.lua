local strings = {}

--- Capitalizes the first letter of each word in a string.
--- @param str The string to capitalize.
--- @return The capitalized string.
local function capitalize(str)
    return string.gsub(str, "(%a)([%w_']*)", function(first, rest) return first:upper()..rest:lower() end)
end

exports('capitalize', capitalize)
strings.capitalize = capitalize

--- Generates a random string of a specified length.
--- @param length The length of the random string.
--- @return The random string.
local function random_string(length)
    local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local result = {}
    for _ = 1, length do
        local randomChar = chars:sub(math.random(1, #chars), math.random(1, #chars))
        table.insert(result, randomChar)
    end
    return table.concat(result)
end

exports('random_string', random_string)
strings.random_string = random_string

--- Splits a string into a table based on a given delimiter.
--- @param str The string to split.
--- @param delimiter The delimiter to split by.
--- @return A table of split segments.
local function split(str, delimiter)
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        result[result + 1] = match
    end
    return result
end

exports('split', split)
strings.split = split

--- Trims whitespace from the beginning and end of a string.
--- @param str The string to trim.
--- @return The trimmed string.
local function trim(str)
    return str:match("^%s*(.-)%s*$")
end

exports('trim', trim)
strings.trim = trim

return strings