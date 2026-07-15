-- =========================================================
-- ComboTrials_Hotkeys.lua - Action registration for combo trials.
-- Registers a scope into the shared Training_Hotkeys framework.
-- Hotkeys are disabled and unbound by default; Training_Hotkeys owns
-- the UI/bindings. Mirrors SF6_TOOLS_CC.
-- =========================================================

local M = {}
local RuntimeSafety = require("func/RuntimeSafety")

local function can_use_combo_trials()
    if RuntimeSafety and RuntimeSafety.is_training_allowed and not RuntimeSafety.is_training_allowed() then return false end
    if _G.CurrentTrainerMode ~= 4 then return false end
    if _G._ct_bar_collapsed then return false end
    return true
end

function M.init(ctx, Hotkeys)
    if not Hotkeys or not Hotkeys.register_scope then return false end
    local commands = ctx.commands or {}

    Hotkeys.register_scope("combo_trials", {
        title = "Combo Trials",
        order = 20,
        enabled_default = false,
        actions = {
            { id = "record_p1", label = "Record P1", enabled = can_use_combo_trials, run = commands.record_p1 },
            { id = "record_p2", label = "Record P2", enabled = can_use_combo_trials, run = commands.record_p2 },
            { id = "save_recording", label = "Stop & Save Recording", enabled = can_use_combo_trials, run = commands.save_recording },
            { id = "cancel_recording", label = "Cancel Recording", enabled = can_use_combo_trials, run = commands.cancel_recording },
            { id = "start_trial", label = "Start Trial", enabled = can_use_combo_trials, run = commands.start_trial },
            { id = "reset_trial", label = "Reset Trial", enabled = can_use_combo_trials, run = commands.reset_trial },
            { id = "stop_trial", label = "Stop Trial", enabled = can_use_combo_trials, run = commands.stop_trial },
            { id = "start_demo", label = "Auto Demo", enabled = can_use_combo_trials, run = commands.start_demo },
            { id = "restart_demo", label = "Restart Demo", enabled = can_use_combo_trials, run = commands.restart_demo },
            { id = "quit_demo", label = "Quit Demo", enabled = can_use_combo_trials, run = commands.quit_demo },
            { id = "switch_position", label = "Cycle Position Mode", enabled = can_use_combo_trials, run = commands.switch_position },
            { id = "open_combo_dropdown", label = "Open Combo File List", enabled = can_use_combo_trials, run = commands.open_combo_dropdown },
        },
    })
    return true
end

return M
