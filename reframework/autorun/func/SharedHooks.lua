-- 0_SharedHooks.lua
-- Consolidated hooks for performance: one hook per method, dispatch via _G
-- Named with 0_ prefix to load before other scripts

local sdk = sdk

local _td_gBattle = sdk.find_type_definition("gBattle")
local _td_mediator = sdk.find_type_definition("app.FBattleMediator")
local _f_playerType = _td_mediator and _td_mediator:get_field("PlayerType")

-- =========================================================
-- SHARED HOOK: UpdateGameInfo (was in CT, DL, SB separately)
-- Publishes player character IDs to _G._shared_player_info
-- =========================================================
_G._shared_player_info = { [0] = { id = -1, key = "ESF_000", name = "Unknown" }, [1] = { id = -1, key = "ESF_000", name = "Unknown" } }

if _td_mediator then
    local m = _td_mediator:get_method("UpdateGameInfo")
    if m then
        sdk.hook(m, function(args)
            _G._profiler_hook_ugi_start = os.clock()
            pcall(function()
                local mgr = sdk.to_managed_object(args[2])
                if not mgr then return end
                local pt = _f_playerType:get_data(mgr)
                if not pt or pt:call("get_Length") < 2 then return end
                for i = 0, 1 do
                    local p = pt:call("GetValue", i)
                    if p then
                        local pid = p:get_type_definition():get_field("value__"):get_data(p)
                        if pid then
                            local k = string.format("ESF_%03d", pid)
                            local name_str = p:call("ToString")
                            _G._shared_player_info[i].id = pid
                            _G._shared_player_info[i].key = k
                            _G._shared_player_info[i].name = name_str
                        end
                    end
                end
            end)
            _G._profiler_hook_ugi_end = os.clock()
        end, function(retval) return retval end)
    end
end

-- =========================================================
-- SHARED HOOK: pl_input_sub (was in CT and DV separately)
-- Dispatches to registered callbacks via _G._shared_input_pre/post
-- =========================================================
_G._shared_input_pre = {}
_G._shared_input_post = {}

local p_id_stack = {}
local cplayer_type = sdk.find_type_definition("nBattle.cPlayer")
if cplayer_type then
    local method = cplayer_type:get_method("pl_input_sub")
    if method then
        sdk.hook(method,
            function(args)
                _G._profiler_hook_input_start = os.clock()
                local hook_addr = sdk.to_int64(args[2])
                local p_id = -1
                pcall(function()
                    if _td_gBattle then
                        local sP = _td_gBattle:get_field("Player"):get_data(nil)
                        if sP and sP.mcPlayer then
                            if sP.mcPlayer[0] and sP.mcPlayer[0]:get_address() == hook_addr then p_id = 0 end
                            if sP.mcPlayer[1] and sP.mcPlayer[1]:get_address() == hook_addr then p_id = 1 end
                        end
                    end
                end)
                table.insert(p_id_stack, p_id)
                for _, cb in ipairs(_G._shared_input_pre) do
                    pcall(cb, p_id, args)
                end
            end,
            function(retval)
                local p_id = table.remove(p_id_stack) or -1
                for _, cb in ipairs(_G._shared_input_post) do
                    pcall(cb, p_id, retval)
                end
                _G._profiler_hook_input_end = os.clock()
                return retval
            end
        )
    end
end

-- =========================================================
-- CENTRALIZED GC: one step per frame, smooths out GC pauses
-- =========================================================
re.on_application_entry("UpdateBehavior", function()
    collectgarbage("step", 1)
end)
