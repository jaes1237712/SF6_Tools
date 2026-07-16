-- =========================================================
-- i18n.lua - Runtime language registry for the per-language UI split.
-- One core, two UI languages (English / Chinese) selectable at runtime.
-- Modules register their string tables; UI code calls T(key) / T(key, ...).
--
-- Usage:
--   local i18n = require("func/i18n")
--   i18n.register("combo_trials", { en = {...}, zh = {...} })
--   local T = i18n.scope("combo_trials")
--   imgui.text(T("start_trial"))
--   i18n.set_lang("zh")  -- toggles everything at once
-- =========================================================

local json = json
local fs = fs

local M = {}

local CONFIG_FILE = "Training_ScriptManager_data/UILang_Config.json"
local LANGS = { "en", "zh" }
local LANG_LABEL = { en = "EN", zh = "中文" }

local state = { lang = "en", loaded = false }
local tables = {}   -- scope -> { en = {..}, zh = {..} }

local function load_lang()
    if state.loaded then return end
    state.loaded = true
    local ok, data = pcall(json.load_file, CONFIG_FILE)
    if ok and type(data) == "table" and type(data.lang) == "string" then
        if data.lang == "en" or data.lang == "zh" then state.lang = data.lang end
    end
    _G.SF6_UI_LANG = state.lang
end

local function save_lang()
    if fs and fs.create_dir then pcall(fs.create_dir, "Training_ScriptManager_data") end
    pcall(json.dump_file, CONFIG_FILE, { lang = state.lang })
end

function M.get_lang()
    load_lang()
    return state.lang
end

function M.langs() return LANGS end
function M.lang_label(l) return LANG_LABEL[l] or l end

function M.set_lang(lang)
    load_lang()
    if lang ~= "en" and lang ~= "zh" then return end
    if state.lang == lang then return end
    state.lang = lang
    _G.SF6_UI_LANG = lang
    save_lang()
end

function M.toggle()
    load_lang()
    M.set_lang(state.lang == "en" and "zh" or "en")
end

-- Register (or extend) a scope's strings. Later registrations merge in.
function M.register(scope, langtable)
    if type(scope) ~= "string" or type(langtable) ~= "table" then return end
    tables[scope] = tables[scope] or { en = {}, zh = {} }
    for _, l in ipairs(LANGS) do
        if type(langtable[l]) == "table" then
            for k, v in pairs(langtable[l]) do tables[scope][l][k] = v end
        end
    end
end

-- Resolve a key in the active language (falls back to en, then the key itself).
function M.t(scope, key, ...)
    load_lang()
    local sc = tables[scope]
    local s = nil
    if sc then
        s = (sc[state.lang] and sc[state.lang][key]) or (sc.en and sc.en[key])
    end
    if s == nil then return key end
    if select("#", ...) > 0 then
        local ok, out = pcall(string.format, s, ...)
        if ok then return out end
    end
    return s
end

-- Bound getter for a scope: local T = i18n.scope("combo_trials"); T("key")
function M.scope(scope)
    return function(key, ...)
        return M.t(scope, key, ...)
    end
end

return M
