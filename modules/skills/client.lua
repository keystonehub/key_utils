local skills = {}

local callbacks = utils.get_module('callbacks')

--- @section Local functions

--- Retrieves the current skill data for the client side.
local function get_skills()
    callbacks.trigger('fivem_utils:sv:get_skills', {}, function(skills_data)
        if skills_data then
            return skills_data
        else
            return nil
        end
    end)
end

exports('get_skills', get_skills)
skills.get_skills = get_skills

--- Retrieves specific data for a given skill from the skill data.
--- @param skill_name string: The identifier of the skill to retrieve data for.
local function get_skill(skill_name, cb)
    callbacks.trigger('fivem_utils:sv:get_skill', { skill_name = skill_name }, function(skill_data)
        if skill_data then
            cb(skill_data)
        else
            debug_log("err", "Failed to fetch data for skill " .. skill_name .. ".")
            cb(nil)
        end
    end)
end

exports('get_skill', get_skill)
skills.get_skill = get_skill

return skills
