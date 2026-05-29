# Training Script Manager

Central hub that manages all training scripts. It provides a floating top bar for quick mode switching and handles shared configuration (colors, button mapping, shortcuts).

## Prerequisites

- **REFramework** must be installed (see the Getting Started guide — Guide 00)
- You must be in **Training Mode** for the manager to activate

## First-Time Setup

1. Launch SF6 and enter Training Mode
2. Press **Insert** to open the REFramework menu
3. Find **Training Script Manager** in the script list — it should already be active
4. Close the menu (Insert again) and look for the floating top bar at the top of the screen

## Modes

The manager controls 4 training modes. Only one can be active at a time:

| Mode | Description |
|------|-------------|
| Disabled | All training scripts off (normal Training Mode) |
| Hit Confirm | Practice confirming hits vs blocks (see Guide 04) |
| Reaction Drills | React to random dummy actions (see Guide 06) |
| Post Guard | Practice punishing after blocking (see Guide 05) |
| Custom Combo Trials | Record and practice your own combos (see Guide 03) |

## Controls

### Gamepad
- **FUNCTION BUTTON + SQUARE/X**: Cycle through modes
- The function button defaults to SELECT/BACK — you can change it in the menu (see below)

### Keyboard
- **[0]** (zero key, top row): Cycle through modes (customizable — see below)

## Top Bar (Floating Overlay)

A floating bar at the top of the screen shows:
- **SWITCH** button — click to cycle modes
- One button per mode — **green** = active, **grey** = inactive
- Click any mode button to jump straight to it

## Changing Your Button Bindings

In the REFramework menu under **Training Script Manager**:

- **CHANGE FUNCTION BUTTON**: Press any gamepad button to set it as your new function key
- **CHANGE SWITCH KEY**: Press any keyboard key (with optional modifiers like Shift/Ctrl) to set it as your new mode-cycling key
- **Color Slots**: Customize the 4 color slots used across all training scripts. Each slot has separate color (RGB) and opacity (Alpha) values — for example, set slot 1 to red with 80% opacity for hit feedback

## Notes

- When switching modes, a ticker notification appears on screen showing the active mode name.
- When you leave Training Mode, all modes automatically reset to Disabled
- During replays, training scripts are temporarily paused with a short reactivation delay
