-- =========================================================
-- ComboTrials_Hotkeys.lua - Action registration for combo trials.
-- Registers a scope into the shared Training_Hotkeys framework.
-- Disabled and unbound by default. Labels toggle EN/中文 via i18n.
-- =========================================================

local M = {}
local RuntimeSafety = require("func/RuntimeSafety")
local i18n = require("func/i18n")

i18n.register("hk_combo_trials", {
    en = {
        title = "Combo Trials",
        record_p1 = "Record P1", record_p2 = "Record P2",
        save_recording = "Stop & Save Recording", cancel_recording = "Cancel Recording",
        start_trial = "Start Trial", reset_trial = "Reset Trial", stop_trial = "Stop Trial",
        start_demo = "Auto Demo", restart_demo = "Restart Demo", quit_demo = "Quit Demo",
        switch_position = "Cycle Position Mode", open_combo_dropdown = "Open Combo File List",
    },
    zh = {
        title = "连段训练",
        record_p1 = "录制 P1", record_p2 = "录制 P2",
        save_recording = "停止并保存录制", cancel_recording = "取消录制",
        start_trial = "开始连段训练", reset_trial = "重置连段", stop_trial = "停止连段训练",
        start_demo = "自动演示连段", restart_demo = "重播演示", quit_demo = "退出演示",
        switch_position = "切换位置模式", open_combo_dropdown = "打开连段文件列表",
    },
})
local function T(k) return i18n.t("hk_combo_trials", k) end

local function can_use_combo_trials()
    if RuntimeSafety and RuntimeSafety.is_training_allowed and not RuntimeSafety.is_training_allowed() then return false end
    if _G.CurrentTrainerMode ~= 4 then return false end
    if _G._ct_bar_collapsed then return false end
    return true
end

function M.init(ctx, Hotkeys)
    if not Hotkeys or not Hotkeys.register_scope then return false end
    local commands = ctx.commands or {}
    local function lbl(k) return function() return T(k) end end

    Hotkeys.register_scope("combo_trials", {
        title = function() return T("title") end,
        order = 20,
        enabled_default = false,
        actions = {
            { id = "record_p1", label = lbl("record_p1"), enabled = can_use_combo_trials, run = commands.record_p1 },
            { id = "record_p2", label = lbl("record_p2"), enabled = can_use_combo_trials, run = commands.record_p2 },
            { id = "save_recording", label = lbl("save_recording"), enabled = can_use_combo_trials, run = commands.save_recording },
            { id = "cancel_recording", label = lbl("cancel_recording"), enabled = can_use_combo_trials, run = commands.cancel_recording },
            { id = "start_trial", label = lbl("start_trial"), enabled = can_use_combo_trials, run = commands.start_trial },
            { id = "reset_trial", label = lbl("reset_trial"), enabled = can_use_combo_trials, run = commands.reset_trial },
            { id = "stop_trial", label = lbl("stop_trial"), enabled = can_use_combo_trials, run = commands.stop_trial },
            { id = "start_demo", label = lbl("start_demo"), enabled = can_use_combo_trials, run = commands.start_demo },
            { id = "restart_demo", label = lbl("restart_demo"), enabled = can_use_combo_trials, run = commands.restart_demo },
            { id = "quit_demo", label = lbl("quit_demo"), enabled = can_use_combo_trials, run = commands.quit_demo },
            { id = "switch_position", label = lbl("switch_position"), enabled = can_use_combo_trials, run = commands.switch_position },
            { id = "open_combo_dropdown", label = lbl("open_combo_dropdown"), enabled = can_use_combo_trials, run = commands.open_combo_dropdown },
        },
    })
    return true
end

return M
