local environment = {}

--- @section Local functions

--- Retrieves the current game time and its formatted version.
--- @return table: Contains raw time data and formatted time string.
local function get_game_time()
    local hour = GetClockHours()
    local minute = GetClockMinutes()
    return {
        time = {hour = hour, minute = minute},
        formatted = string.format('%02d:%02d', hour, minute)
    }
end

exports('get_game_time', get_game_time)
environment.get_game_time = get_game_time

--- Retrieves the game's current date and its formatted version.
--- @return table: Contains raw date data and formatted date string.
local function get_game_date()
    local day = GetClockDayOfMonth()
    local month = GetClockMonth()
    local year = GetClockYear()
    return {
        date = {day = day, month = month, year = year},
        formatted = string.format('%02d/%02d/%04d', day, month, year)
    }
end

exports('get_game_date', get_game_date)
environment.get_game_date = get_game_date

--- Retrieves sunrise and sunset times based on weather.
--- @param weather string: The current weather type.
--- @return table: Sunrise and sunset times.
local function get_sunrise_sunset_times(weather)
    local times = {
        CLEAR = { sunrise = '06:00', sunset = '18:00' },
        CLOUDS = { sunrise = '06:15', sunset = '17:45' },
        OVERCAST = { sunrise = '06:30', sunset = '17:30' },
        RAIN = { sunrise = '07:00', sunset = '17:00' },
        THUNDER = { sunrise = '07:00', sunset = '17:00' },
        SNOW = { sunrise = '08:00', sunset = '16:00' },
        BLIZZARD = { sunrise = '09:00', sunset = '15:00' },
    }
    return times[weather] or {sunrise = '06:00', sunset = '18:00'}
end

exports('get_sunrise_sunset_times', get_sunrise_sunset_times)
environment.get_sunrise_sunset_times = get_sunrise_sunset_times

--- Checks if the current time is daytime.
--- @return boolean: True if daytime, false otherwise.
local function is_daytime()
    local hour = GetClockHours()
    return hour >= 6 and hour < 18
end

exports('is_daytime', is_daytime)
environment.is_daytime = is_daytime

--- Retrieves the current season.
--- This is entirely artificial GTAV/FiveM does not have "seasons" however this has potential for other uses.
--- For example: farming scripts.
--- @return string: The current season.
local function get_current_season()
    local month = GetClockMonth()
    local seasons = {
        [0] = 'Winter', [1] = 'Winter', [2] = 'Winter',
        [3] = 'Spring', [4] = 'Spring', [5] = 'Spring',
        [6] = 'Summer', [7] = 'Summer', [8] = 'Summer',
        [9] = 'Autumn', [10] = 'Autumn', [11] = 'Autumn'
    }
    return seasons[month] or 'Unknown'
end


exports('get_current_season', get_current_season)
environment.get_current_season = get_current_season

--- Get the distance from the player to the nearest water body.
--- @return number: The distance to the nearest water body.
local function get_distance_to_water()
    local player_coords = GetEntityCoords(PlayerPedId())
    local water_test_result, water_height = TestVerticalProbeAgainstAllWater(player_coords.x, player_coords.y, player_coords.z, 0)
    if water_test_result then
        return #(player_coords - vector3(player_coords.x, player_coords.y, water_height))
    else
        return -1
    end
end

exports('get_distance_to_water', get_distance_to_water)
environment.get_distance_to_water = get_distance_to_water

--- Retrieves comprehensive environment details.
--- @return table: Detailed environment information.
local function get_environment_details()
    return {
        weather = get_weather_name(GetPrevWeatherTypeHashName()),
        time = get_game_time(),
        date = get_game_date(),
        season = get_current_season(),
        wind_speed = wind.get_speed(),
        wind_direction = wind.get_direction(),
        sunrise_sunset = get_sunrise_sunset_times(get_weather_name(GetPrevWeatherTypeHashName())),
        is_daytime = is_daytime(),
        distance_to_water = get_distance_to_water()
    }
end

exports('get_environment_details', get_environment_details)
environment.get_environment_details = get_environment_details

return environment