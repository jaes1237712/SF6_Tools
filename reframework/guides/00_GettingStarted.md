# Getting Started

Welcome! This guide will get you up and running with the SF6 Training Tools mod suite. No prior modding experience is needed.

## What Are These Tools?

These are a collection of training add-ons for Street Fighter 6 that run inside REFramework. They add features like custom combo trials, hit confirm drills, distance visualization, hitbox display, and more — all designed to help you level up your game.

## Step 1: Install REFramework

REFramework is the mod loader that makes everything work. If you're reading this, it's probably already installed (the mods are inside the `reframework/` folder). If not:

1. Download REFramework from [GitHub](https://github.com/Wael3rd/SF6_Tools)
2. Download the Street Fighter 6 zip file.
3. Extract the contents of the zip file to your SF6 game folder (next to `StreetFighter6.exe`)
4. Launch the game — you should see a brief "REFramework" watermark in the top-left corner

## Step 2: Open the REFramework Menu

Press the **Insert** key on your keyboard at any time during the game. This opens the REFramework overlay menu where all mod settings live. Press **Insert** again to close it.

> **Tip:** The overlay menu is separate from the game's pause menu. You can open it during gameplay, in menus, or anywhere else.

## Step 3: Enter Training Mode

Most tools only work in Training Mode. Start the game, go to **Training Mode** from the main menu, and pick any two characters.

## Step 4: Activate a Training Script

Once in Training Mode, you have two ways to switch between training tools:

### Using the Gamepad
Hold **FUNCTION BUTTON** (defaults to SELECT/BACK) and press **SQUARE/X** to cycle through modes.

### Using the Keyboard
Press **[0]** (zero key, top row) to cycle through modes.

The active mode appears in a floating bar at the top of the screen:
- **Hit Confirm** — Practice confirming hits vs blocks
- **Reaction Drills** — React to random dummy actions
- **Post Guard** — Practice punishing after blocking
- **Custom Combo Trials** — Record and practice your own combos

## Step 5: Explore

Each tool has its own guide in this folder (numbered 01 through 10). Start with whichever sounds most useful to you. Here's a quick map:

| Guide | Tool | What It Does |
|-------|------|-------------|
| 01 | Distance Viewer | Visualize attack ranges on screen |
| 02 | Script Manager | Central hub — mode switching, button config, colors |
| 03 | Custom Combo Trials | Record combos and practice them with validation |
| 04 | Hit Confirm | Train hit confirm reactions (hit vs block) |
| 05 | Post Guard | Practice punishing after blocking |
| 06 | Reaction Drills | React to random dummy attacks |
| 07 | Recording Slot Manager | Manage dummy recording slots (import/export) |
| 08 | Training Remote Control | Control training tools from your phone |

## Quick Glossary

New to fighting games? Here are some terms you'll see in these guides:

- **Dummy** — The opponent character controlled by the CPU in Training Mode
- **Frame** — One unit of game time. SF6 runs at 60 frames per second, so 1 frame = ~0.017 seconds
- **Frame data** — How many frames each phase of a move takes (startup, active, recovery)
- **Hit confirm** — Reacting to whether your attack hit or was blocked, and choosing your next action accordingly
- **Oki (okizeme)** — Attacking the opponent as they get up from a knockdown
- **Meaty** — An attack timed so that its active frames overlap with the opponent's wakeup
- **Punish** — Hitting the opponent during their recovery (after they whiff or you block their attack)
- **Whiff punish** — Hitting the opponent during the recovery of an attack that missed you
- **Drive Impact (DI)** — A powerful armored attack unique to SF6 (costs 1 Drive bar)
- **Drive Rush Cancel (DRC)** — Canceling a normal into a Drive Rush dash for pressure or combos
- **Counter Hit (CH)** — Hitting the opponent during their attack startup, causing extra hitstun
- **Punish Counter (PC)** — Hitting the opponent during their recovery, causing even more hitstun
- **Numpad notation** — A system for writing joystick directions using the number pad layout: 7=up-back, 8=up, 9=up-forward, 4=back, 5=neutral, 6=forward, 1=down-back, 2=down, 3=down-forward
- **Blockstring** — A sequence of attacks designed to keep the opponent blocking
- **Proximity normal** — A different normal attack that comes out when the opponent is close (standing close HP vs standing far HP)
