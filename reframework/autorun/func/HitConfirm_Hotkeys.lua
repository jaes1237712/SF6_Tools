-- =========================================================
-- HitConfirm_Hotkeys.lua - Action registration for hit confirm training.
-- Disabled and unbound by default. Labels toggle EN/中文 via i18n.
-- =========================================================

local M = {}
local RuntimeSafety = require("func/RuntimeSafety")
local i18n = require("func/i18n")

i18n.register("hk_hit_confirm", {
    en = {
        title = "Hit Confirm",
        decrease_amount = "Decrease Session Amount", increase_amount = "Increase Session Amount",
        reset_or_stop = "Reset / Stop Session", start_or_pause = "Start / Pause Session",
    },
    zh = {
        title = "确认训练",
        decrease_amount = "减少本次训练量", increase_amount = "增加本次训练量",
        reset_or_stop = "重置 / 停止训练", start_or_pause = "开始 / 暂停训练",
    },
})
local function T(k) return i18n.t("hk_hit_confirm", k) end

local function can_use_hit_confirm()
    if RuntimeSafety and RuntimeSafety.is_training_allowed and not RuntimeSafety.is_training_allowed() then return false end
    return _G.CurrentTrainerMode == 2
end

function M.init(commands, Hotkeys)
    if not Hotkeys or not Hotkeys.register_scope then return false end
    commands = commands or {}
    local function lbl(k) return function() return T(k) end end

    Hotkeys.register_scope("hit_confirm", {
        title = function() return T("title") end,
        order = 10,
        enabled_default = false,
        actions = {
            { id = "decrease_amount", label = lbl("decrease_amount"), enabled = can_use_hit_confirm, run = commands.decrease_amount },
            { id = "increase_amount", label = lbl("increase_amount"), enabled = can_use_hit_confirm, run = commands.increase_amount },
            { id = "reset_or_stop", label = lbl("reset_or_stop"), enabled = can_use_hit_confirm, run = commands.reset_or_stop },
            { id = "start_or_pause", label = lbl("start_or_pause"), enabled = can_use_hit_confirm, run = commands.start_or_pause },
        },
    })
    return true
end

return M
