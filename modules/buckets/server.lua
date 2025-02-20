local buckets = {}

--- @section Tables

--- Local table to store settings for each bucket.
local bucket_settings = {}

--- @section Local functions

--- Sets a player into a specific bucket and applies the provided settings.
--- @param player_id number: The server ID of the player.
--- @param params table: A table containing bucket settings such as bucket_id, enable_population, lockdown_mode, max_players, and spawn_coords.
local function set_player_bucket(player_id, params)
    SetPlayerRoutingBucket(player_id, params.bucket_id)
    if params.enable_population ~= nil then
        SetRoutingBucketPopulationEnabled(params.bucket_id, params.enable_population)
    end
    if params.lockdown_mode then
        SetRoutingBucketEntityLockdownMode(params.bucket_id, params.lockdown_mode)
    end
    bucket_settings[params.bucket_id] = { max_players = params.max_players, spawn_coords = params.spawn_coords }
end

exports('set_player_bucket', set_player_bucket)
buckets.set_player_bucket = set_player_bucket

--- Retrieves settings for a specific bucket.
--- @param bucket_id number: The ID of the bucket.
local function get_bucket_settings(bucket_id)
    return bucket_settings[bucket_id] or {}
end

exports('get_bucket_settings', get_bucket_settings)
buckets.get_bucket_settings = get_bucket_settings

--- Retrieves all players in a specific routing bucket.
--- @param bucket_id number: The ID of the bucket.
local function get_players_in_bucket(bucket_id)
    local players = GetPlayers()
    local players_in_bucket = {}
    for _, player_id in ipairs(players) do
        if get_player_bucket(player_id) == bucket_id then
            players_in_bucket[#players_in_bucket + 1] = player_id
        end
    end
    return players_in_bucket
end

exports('get_players_in_bucket', get_players_in_bucket)
buckets.get_players_in_bucket = get_players_in_bucket

--- Temporarily moves a player to a specified bucket for a duration, then returns them to their original bucket.
--- @param player_id number: The server ID of the player.
--- @param temporary_bucket_id number: The temporary bucket ID to move the player to.
--- @param duration number: Duration in seconds to keep the player in the temporary bucket.
local function temp_bucket(player_id, temporary_bucket_id, duration)
    local original_bucket = get_player_bucket(player_id)
    set_player_bucket(player_id, temporary_bucket_id)
    SetTimeout(duration * 1000, function()
        if get_player_bucket(player_id) == temporary_bucket_id then
            set_player_bucket(player_id, original_bucket)
        end
    end)
end

exports('temp_bucket', temp_bucket)
buckets.temp_bucket = temp_bucket

return buckets