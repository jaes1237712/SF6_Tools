local Validator = {
    name = "ComboTrials.Validator"
}

function Validator.calculate_frame_diff(actual_delay, expected_delay)
    return actual_delay - (expected_delay or 0)
end

function Validator.is_pressure_tail_step(step)
    if not step then return false end
    return step.validation_role == "pressure_tail"
end

function Validator.check_combo(params)
    local combo_ok = true
    local expected = params.expected
    local prev_step = params.prev_step
    local current_combo = params.current_combo or 0

    if Validator.is_pressure_tail_step(expected) then
        return true
    end

    if prev_step and prev_step.expected_combo ~= nil then
        local skip_strict_check = (prev_step.is_projectile_hit == true)
        if not skip_strict_check and current_combo ~= prev_step.expected_combo then
            local current_hit_already_counted =
                (expected.expected_combo or 0) > prev_step.expected_combo
                and current_combo > prev_step.expected_combo
                and current_combo <= expected.expected_combo
            if current_hit_already_counted then
                -- The current move can update combo_cnt on the same frame as its action.
                combo_ok = true
            elseif params.opponent_knocked_down and current_combo == 0 and prev_step.expected_combo == 0 then
                combo_ok = true
            elseif prev_step.expected_combo == 0 and current_combo > 0 then
                combo_ok = true
            elseif current_combo == 0 and prev_step.expected_combo > 0 then
                -- Oki / cross-up setup: combo dropped naturally (opponent got up)
                combo_ok = true
            elseif expected and expected.expected_combo == 0 then
                -- RESET TOLERANCE 2.0 (Standing Reset / Oki):
                -- The sequence intends for the combo to drop to 0 after this move.
                -- So it doesn't matter if the combo counter is still running (early input)
                -- or has just naturally dropped to 0. Both states are valid.
                combo_ok = true
            else
                combo_ok = false
            end
        end
    end

    return combo_ok
end

function Validator.check_hp(expected_hp, current_hp, is_oki, expected)
    local hp_ok = true
    if Validator.is_pressure_tail_step(expected) then
        return true
    end
    if expected_hp ~= nil and current_hp ~= nil then
        -- HP Validation is strict only for post-hit setup/oki phases.
        if is_oki then
            if current_hp ~= expected_hp then
                hp_ok = false
            end
        end
    end
    return hp_ok
end

return Validator
