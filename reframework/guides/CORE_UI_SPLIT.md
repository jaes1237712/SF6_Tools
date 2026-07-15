# Core / UI Split — Architecture Guideline

> The long-term convergence goal for WTT (SF6_Tools) and SF6_TOOLS_CC:
> **one shared engine core, separate per-language UI shells.** Chinese and
> Western training UIs have diverged for good UX reasons; the validation,
> data and input layers should not.

## The principle

Every module separates into two layers:

```
CORE  (language-neutral, shared verbatim between projects)
  - game reads/writes, validation, data schemas, input polling
  - no hard-coded display strings, no locale assumptions
        │  exposes state + a strings table (L)
UI SHELL  (per-language, per-project)
  - imgui/D2D drawing, wording, layout, UX flow
```

The rule: **a string a user reads never lives in the core.** It lives in a
localizable `L` table (or the UI shell). Notations (`236+HP`, `2MK`) are
language-neutral by design and stay in the core.

## Reference implementation: `Training_Hotkeys.lua`

The shared hotkey framework is the canonical example. Its core (config,
device polling, scope registry, conflict detection, fire logic — ~350 lines)
is identical between projects. The only language-specific part is a table at
the top of the file:

```lua
local L = {
    unbound = "Unbound", bind = "Bind", clear = "Clear",
    bound = "Bound: ", conflict = "Conflict: ", ...
}
```

SF6_TOOLS_CC ships the same core with a Chinese `L`; SF6_Tools ships English.
Swapping languages is swapping one table — the engine is untouched.

## Already-split layers

| Layer | Core (shared) | UI / language |
|---|---|---|
| Validation | `func/ComboTrials/{Validator,ActionMatcher,CharacterRules,PendingAbsorb,DebugTrace}` | — (pure logic) |
| Combo files | `func/ComboTrials_Files` + `xt.combo_trial` schema | dropdown / labels in `ComboTrials_UI` |
| Hotkeys | `func/Training_Hotkeys` core | `L` table + `*_Hotkeys` scope labels |
| Unique resources | `unique_resources` in main | — |
| Data | `exceptions/*.json`, `modern_display/*.json`, scene_state schema | — |

## Still coupled (future work)

- `ComboTrials_UI.lua`, `Training_ScriptManager` menu, D2D overlays still mix
  logic and English strings inline. Extraction target: route every visible
  string through an `L` table so the file becomes a pure UI shell that either
  project can replace wholesale.
- The end state: `ComboTrials_UI_EN.lua` / `ComboTrials_UI_ZH.lua` selectable
  by config, both driving the same core `ctx`.

## Guideline for new code

1. New logic goes in a core module with no user-facing strings.
2. Any string shown to the user goes through an `L` table at the top of the
   file (or the UI shell), never inline.
3. Data files (`*.json`) are language-neutral; localization is display-only.
4. When porting a module from SF6_TOOLS_CC, translate only its `L`/labels —
   never fork the core logic.
