-- =========================================================
-- ComboTrials_Files.lua - Combo JSON loading and list management.
-- Receives shared context via init(); mutates ctx.file_system in place.
-- Module boundary mirrors SF6_TOOLS_CC for project convergence.
-- =========================================================

local json = json
local fs = fs

local M = {}

-- Resolved in init()
local trial_state, file_system, players
local assign_groups, reset_trial_flags, reset_visual_state

function M.load_combo_from_file(path)
    if not path then return false end
    local loaded = json.load_file(path)
    if not loaded then return false end
    trial_state.sequence = loaded
    assign_groups(trial_state.sequence)
    trial_state.current_step = 1
    trial_state.is_playing = false
    if loaded[1] then
        trial_state.start_pos_p1 = loaded[1].start_pos_p1
        trial_state.start_pos_p2 = loaded[1].start_pos_p2
        trial_state.start_pos_p1_raw = loaded[1].start_pos_p1_raw
        trial_state.start_pos_p2_raw = loaded[1].start_pos_p2_raw
    end
    return true
end

function M.clear_combo_state()
    reset_trial_flags()
    trial_state.sequence = {}
    trial_state.start_pos_p1 = nil
    trial_state.start_pos_p2 = nil
    trial_state.start_pos_p1_raw = nil
    trial_state.start_pos_p2_raw = nil
    trial_state.live_start_pos_p1 = nil
    trial_state.live_start_pos_p2 = nil
    trial_state.live_start_pos_p1_raw = nil
    trial_state.live_start_pos_p2_raw = nil
    reset_visual_state()
    pcall(collectgarbage, "step", 16)
end

function M.refresh_combo_list(recent_saved_player)
    file_system.saved_combos_display_p1, file_system.saved_combos_paths_p1 = {}, {}
    file_system.saved_combos_display_p2, file_system.saved_combos_paths_p2 = {}, {}

    local function load_files(player_idx, display_list, path_list)
        if not players[player_idx] then return end
        local char_name = players[player_idx].profile_name
        if char_name == "Unknown" then return end

        if fs.create_dir then
            pcall(fs.create_dir, "TrainingComboTrials_data/CustomCombos"); pcall(fs.create_dir, "TrainingComboTrials_data/CustomCombos/" .. char_name)
        end

        local files = fs.glob("TrainingComboTrials_data\\\\CustomCombos\\\\" .. char_name .. "\\\\.*json")
        if files then
            -- Parse filename to extract sort keys: type (COMBO/OKI), damage, drive, SA
            local function parse_sort_keys(filepath)
                local fname = filepath:match("([^/\\]+)$") or ""
                local is_oki = fname:find("_OKI_") and 1 or 0
                local dmg = tonumber(fname:match("_(%d+)_D")) or 0
                local drive = tonumber(fname:match("_D([%d%.]+)_SA")) or 0
                local sa = tonumber(fname:match("_SA([%d%.]+)")) or 0
                return is_oki, dmg, drive, sa
            end
            -- Sort: COMBO first, then by damage desc, drive desc, SA desc
            table.sort(files, function(a, b)
                local a_oki, a_dmg, a_dr, a_sa = parse_sort_keys(a)
                local b_oki, b_dmg, b_dr, b_sa = parse_sort_keys(b)
                if a_oki ~= b_oki then return a_oki < b_oki end
                if a_dmg ~= b_dmg then return a_dmg > b_dmg end
                if a_dr ~= b_dr then return a_dr > b_dr end
                if a_sa ~= b_sa then return a_sa > b_sa end
                return a < b
            end)
            for _, filepath in ipairs(files) do
                table.insert(path_list, filepath)
                table.insert(display_list, filepath:match("([^/\\]+)$") or filepath)
            end
        end
    end

    load_files(0, file_system.saved_combos_display_p1, file_system.saved_combos_paths_p1)
    load_files(1, file_system.saved_combos_display_p2, file_system.saved_combos_paths_p2)

    local target_player = recent_saved_player or 0
    if target_player == 1 and #file_system.saved_combos_paths_p2 == 0 then target_player = 0 end
    if target_player == 0 and #file_system.saved_combos_paths_p1 == 0 then target_player = 1 end

    if not file_system._pending_select_path then
        local path_to_load = nil
        if target_player == 0 and #file_system.saved_combos_paths_p1 > 0 then
            file_system.selected_file_idx_p1 = 1
            path_to_load = file_system.saved_combos_paths_p1[1]
        elseif target_player == 1 and #file_system.saved_combos_paths_p2 > 0 then
            file_system.selected_file_idx_p2 = 1
            path_to_load = file_system.saved_combos_paths_p2[1]
        end
        if not M.load_combo_from_file(path_to_load) then
            M.clear_combo_state()
        end
    end
end

function M.init(context)
    trial_state = context.trial_state
    file_system = context.file_system
    players = context.players
    assign_groups = context.assign_groups
    reset_trial_flags = context.reset_trial_flags
    reset_visual_state = context.reset_visual_state
end

return M
