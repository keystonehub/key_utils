--- @section Variables

local script_cam

--- @section Local functions

--- Creates a camera at the given position.
--- @param pos vector3: The position to create the camera at.
--- @param rot vector3: The rotation of the camera.
--- @param fov number: The field of view for the camera.
--- @return cam: The created camera.
local function create_cam(pos, rot, fov)
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, fov or GetGameplayCamFov(), false, 0)
    SetCamCoord(cam, pos.x, pos.y, pos.z)
    SetCamRot(cam, rot.x, rot.y, rot.z, 2)
    return cam
end

--- Resets the camera back to the player's perspective.
--- Destroys the scripted camera and reverts to the gameplay camera.
local function reset_cam()
    RenderScriptCams(false, false)
    DestroyCam(script_cam)
    script_cam = nil
end

--- Sets the player's view towards a specific point and orients them facing that direction.
--- @param npc Entity: The NPC entity to orient.
--- @param coords vector3: The coordinates to face towards.
local function set_view(npc, coords)
    if not coords then return end
    local npc_pos = GetEntityCoords(npc) + (GetEntityForwardVector(npc) * 1) + vector3(0, 0, 0.65)
    local npc_rot = GetEntityRotation(npc, 2)
    npc_rot = vector3(npc_rot.x, npc_rot.y, npc_rot.z + 180.0)
    local temp_cam = create_cam(GetGameplayCamCoord(), GetGameplayCamRot(2))
    script_cam = create_cam(npc_pos, npc_rot)
    SetCamActive(temp_cam, true)
    RenderScriptCams(true, false, 1, true, true)
    SetCamActiveWithInterp(script_cam, temp_cam, 1500, true, true)
    DestroyCam(temp_cam)
    local player_ped = PlayerPedId()
    local player_coords = GetEntityCoords(player_ped)
    local dx = coords.x - player_coords.x
    local dy = coords.y - player_coords.y
    local heading = GetHeadingFromVector_2d(dx, dy)
    TaskTurnPedToFaceCoord(player_ped, coords.x, coords.y, coords.z, -1)
    SetEntityHeading(player_ped, heading)
end

--- Opens a dialogue interface with the given parameters.
--- @param dialogue table: Dialogue content to display.
--- @param npc Entity: The NPC entity initiating the dialogue.
--- @param coords vector3: The coordinates for orienting the player's view.
local function open_dialogue(dialogue, npc, coords)
    SetNuiFocus(true, true)
    set_view(npc, coords)
    SendNUIMessage({
        action = 'create_dialogue',
        dialogue = dialogue
    })
end

--- @section NUI callbacks

--- Closes the dialogue menu from ui actions.
RegisterNUICallback('close_dialogue', function()
    SetNuiFocus(false, false)
    active = false
    reset_cam()
    ClearPedTasks(PlayerPedId())
end)

---- @section Exports 

--- Export to open dialogue system.
exports('dialogue', open_dialogue)
utils.dialogue = open_dialogue

--- @section Test stuff

--- Test dialogue conversation
local test_dialogue = {
    header = {
        message = 'Quarry Employee', -- Dialogue header text
        icon = 'fa-solid fa-hard-hat' -- Header icon
    },
    conversation = {
        {
            id = 1, -- This is the ID of the conversation option this is used to navigate through conversation options
            response = { -- This is the NPC response message displayed to players, use an array of messages for multiline.
                'Hello, welcome to the quarry.',
                'How can I assist you today?'
            },
            options = {
                {
                    icon = 'fa-solid fa-question-circle', -- Player response option icon
                    message = 'Can you tell me more about what you do here?', -- Player response option message
                    next_id = 2, -- Next conversation ID to move to when clicking option
                    should_end = false -- Toggles if clicking on the option should end the conversation
                },
                {
                    icon = 'fa-solid fa-briefcase',
                    message = 'Can I start work?',
                    next_id = 3,
                    should_end = false
                },
                {
                    icon = 'fa-solid fa-door-open',
                    message = 'Goodbye!',
                    next_id = nil, -- Next ID is nil since we are using should_end = true below
                    should_end = true, -- Since this is true clicking this option will end the conversation and run the action below if provided
                    action_type = 'client', -- Type of action to trigger: options; 'client', 'server'
                    action = 'testevent', -- Action to perform
                    params = {} -- Parameters for the action
                }
            }
        },
        {
            id = 2,
            response = {
                'We primarily focus on extracting minerals and processing them.',
                'It\'s challenging but fulfilling work.'
            },
            options = {
                {
                    icon = 'fa-solid fa-arrow-left',
                    message = 'Back to previous options',
                    next_id = 1,
                    should_end = false
                },
                {
                    icon = 'fa-solid fa-door-open',
                    message = 'Thank you, that\'s all for now.',
                    next_id = nil,
                    should_end = true,
                    action_type = 'client',
                    action = 'testevent',
                    params = {}
                }
            }
        },
        {
            id = 3,
            response = 'Please report it to our maintenance team immediately.',
            options = {
                {
                    icon = 'fa-solid fa-arrow-left',
                    message = 'Back to previous options',
                    next_id = 1,
                    should_end = false
                },
                {
                    icon = 'fa-solid fa-door-open',
                    message = 'I will do. Thanks!',
                    next_id = nil,
                    should_end = true,
                    action_type = 'client',
                    action = 'testevent',
                    params = {}
                }
            }
        }
    }
}

--- Function to get closest ped
-- This was copied from `fivem_utils`.
local function get_closest_ped(coords, max_distance)
    local peds = GetGamePool('CPed')
    local closest_ped, closest_coords
    max_distance = max_distance or 2.0
    for i = 1, #peds do
        local ped = peds[i]
        if not IsPedAPlayer(ped) then
            local ped_coords = GetEntityCoords(ped)
            local distance = #(coords - ped_coords)
            if distance < max_distance then
                max_distance = distance
                closest_ped = ped
                closest_coords = ped_coords
            end
        end
    end
    return closest_ped, closest_coords
end

--- Test command to open dialogue.
RegisterCommand('ui:test_dialogue', function()
    local ped, coords = get_closest_ped(vector3(224.13, -1393.95, 30.59), 5.0)
    open_dialogue(test_dialogue, ped, coords)
end)