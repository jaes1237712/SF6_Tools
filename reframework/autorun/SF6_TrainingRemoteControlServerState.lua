-- SF6_TrainingRemoteControlServerState.lua — Shows Remote Control server status in REF UI
local re = re

local HEARTBEAT_FILE = "SF6_TrainingRemoteControl_data/SF6_TrainingRemoteControl_heartbeat.txt"

local function is_alive()
    local f = io.open(HEARTBEAT_FILE, "r")
    if not f then return false end
    local ts = f:read("*a")
    f:close()
    ts = tonumber(ts)
    if not ts then return false end
    return (os.time() - ts) < 5
end

re.on_draw_ui(function()
    if imgui.tree_node("SF6 TRAINING REMOTE CONTROL") then
        if is_alive() then
            imgui.text_colored("Remote Control :4850 RUNNING", 0xFF00FF00)
        else
            imgui.text_colored("Remote Control :4850 STOPPED", 0xFF0000FF)
            imgui.text_colored("Launch tray.py from SF6_TrainingRemoteControlServer/", 0xFF888888)
        end
        imgui.tree_pop()
    end
end)
