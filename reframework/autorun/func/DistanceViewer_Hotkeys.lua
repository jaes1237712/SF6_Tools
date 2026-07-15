-- =========================================================
-- DistanceViewer_Hotkeys.lua - Action registration for distance viewer.
-- Registers a scope into the shared Training_Hotkeys framework.
-- Disabled and unbound by default. Mirrors SF6_TOOLS_CC.
-- =========================================================

local M = {}
local RuntimeSafety = require("func/RuntimeSafety")

local function can_use_distance_viewer()
    if RuntimeSafety and RuntimeSafety.is_training_allowed and not RuntimeSafety.is_training_allowed() then return false end
    return _G.CurrentTrainerMode ~= nil and _G.CurrentTrainerMode ~= 0
end

function M.init(commands, Hotkeys)
    if not Hotkeys or not Hotkeys.register_scope then return false end
    commands = commands or {}

    Hotkeys.register_scope("distance_viewer", {
        title = "Distance Viewer",
        order = 30,
        enabled_default = false,
        actions = {
            { id = "cycle_p1", label = "Cycle P1 Display", enabled = can_use_distance_viewer, run = commands.cycle_p1 },
            { id = "cycle_p2", label = "Cycle P2 Display", enabled = can_use_distance_viewer, run = commands.cycle_p2 },
            { id = "toggle_window", label = "Toggle Overlay", enabled = can_use_distance_viewer, run = commands.toggle_window },
        },
    })
    return true
end

return M
