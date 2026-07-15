-- =========================================================
-- HitConfirm_Hotkeys.lua - Action registration for hit confirm training.
-- Registers a scope into the shared Training_Hotkeys framework.
-- Disabled and unbound by default. Mirrors SF6_TOOLS_CC.
-- =========================================================

local M = {}
local RuntimeSafety = require("func/RuntimeSafety")

local function can_use_hit_confirm()
    if RuntimeSafety and RuntimeSafety.is_training_allowed and not RuntimeSafety.is_training_allowed() then return false end
    return _G.CurrentTrainerMode == 2
end

function M.init(commands, Hotkeys)
    if not Hotkeys or not Hotkeys.register_scope then return false end
    commands = commands or {}

    Hotkeys.register_scope("hit_confirm", {
        title = "Hit Confirm",
        order = 10,
        enabled_default = false,
        actions = {
            { id = "decrease_amount", label = "Decrease Session Amount", enabled = can_use_hit_confirm, run = commands.decrease_amount },
            { id = "increase_amount", label = "Increase Session Amount", enabled = can_use_hit_confirm, run = commands.increase_amount },
            { id = "reset_or_stop", label = "Reset / Stop Session", enabled = can_use_hit_confirm, run = commands.reset_or_stop },
            { id = "start_or_pause", label = "Start / Pause Session", enabled = can_use_hit_confirm, run = commands.start_or_pause },
        },
    })
    return true
end

return M
