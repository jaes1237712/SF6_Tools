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
            local ok, mgr = pcall(sdk.to_managed_object, args[2])
            if not ok or not mgr then _G._profiler_hook_ugi_end = os.clock(); return end
            local ok2, pt = pcall(_f_playerType.get_data, _f_playerType, mgr)
            if not ok2 or not pt then _G._profiler_hook_ugi_end = os.clock(); return end
            local ok3, plen = pcall(pt.call, pt, "get_Length")
            if not ok3 or not plen or plen < 2 then _G._profiler_hook_ugi_end = os.clock(); return end
            for i = 0, 1 do
                local ok4, p = pcall(pt.call, pt, "GetValue", i)
                if ok4 and p then
                    local ok5, pid = pcall(function()
                        return p:get_type_definition():get_field("value__"):get_data(p)
                    end)
                    if ok5 and pid then
                        _G._shared_player_info[i].id = pid
                        _G._shared_player_info[i].key = string.format("ESF_%03d", pid)
                        local ok6, ns = pcall(p.call, p, "ToString")
                        _G._shared_player_info[i].name = (ok6 and ns) or "Unknown"
                    end
                end
            end
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
local _cached_sP = nil
local _cached_addr = { [0] = nil, [1] = nil }
local _addr_refresh = 0

local cplayer_type = sdk.find_type_definition("nBattle.cPlayer")
if cplayer_type then
    local method = cplayer_type:get_method("pl_input_sub")
    if method then
        sdk.hook(method,
            function(args)
                _G._profiler_hook_input_start = os.clock()
                local hook_addr = sdk.to_int64(args[2])
                local p_id = -1

                _addr_refresh = _addr_refresh + 1
                if _addr_refresh >= 120 or not _cached_addr[0] then
                    _addr_refresh = 0
                    local ok, sP = pcall(function()
                        if not _td_gBattle then return nil end
                        return _td_gBattle:get_field("Player"):get_data(nil)
                    end)
                    if ok and sP and sP.mcPlayer then
                        _cached_sP = sP
                        for i = 0, 1 do
                            if sP.mcPlayer[i] then
                                local aok, addr = pcall(sP.mcPlayer[i].get_address, sP.mcPlayer[i])
                                _cached_addr[i] = aok and addr or nil
                            end
                        end
                    end
                end

                if hook_addr == _cached_addr[0] then p_id = 0
                elseif hook_addr == _cached_addr[1] then p_id = 1 end

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
