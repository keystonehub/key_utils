local cooldowns = {}

--- Checks if a specific cooldown is still active.
--- @param cooldown_type string: The cooldown_type of action to check for cooldown.
--- @param is_global boolean: Indicates whether the cooldown check is for a global cooldown (`true`) or a player-specific cooldown (`false`).
--- @param cb function: Callback function.
local function check_cooldown(cooldown_type, is_global, cb)
    utils.callbacks.trigger('fivem_utils:sv:check_cooldown', { cooldown_type = cooldown_type, is_global = is_global }, function(active_cooldown)
        if active_cooldown then
            cb(true)
        else
            cb(false)
        end
    end)
end

exports('check_cooldown', check_cooldown)
cooldowns.check = check_cooldown

--- @section Assignments

return cooldowns