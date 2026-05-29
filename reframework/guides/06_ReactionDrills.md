# Reaction Drills

Train your reactions against randomized dummy recordings. The dummy performs random actions from its recording slots, and you must react in time.

## Prerequisites

- Be in **Training Mode**
- Set the Script Manager to mode **2 (Reaction Drills)** — see Guide 02
- Record multiple actions in the dummy's recording slots — the more variety, the better (see Guide 07 for how to record dummy actions)

## How It Works

1. The dummy randomly picks one of its recorded actions and performs it
2. You must react and interrupt or punish the action
3. The script tracks your success rate per slot

## Setup

1. Record various attacks in slots 1-8 (e.g., different pokes, special moves, Drive Impact, throws)
2. Activate the slots you want to practice against (or use **Activate All**)
3. The dummy guard is automatically set to **No Guard**
4. Start a session using the controls below

## Controls

| Action | Keyboard | Gamepad |
|--------|----------|---------|
| Timer - / Trials - | [1] | FUNC + DOWN |
| Timer + / Trials + | [2] | FUNC + UP |
| Reset (idle) / Stop (active) | [3] | FUNC + LEFT |
| Start (idle) / Pause (active) | [4] | FUNC + RIGHT |

## Menu Options

- **Auto-activate**: Forces all filled slots active when starting a session
- **Manual mode**: You manually press Play each time instead of auto-looping
- **Show Slot Percentages**: Displays per-slot success rate on the overlay (e.g., `S1:95% S2:87%`)

## Scoring

- **Success**: You interrupted the dummy's action (hit it before it completes)
- **Fail**: The dummy's action hit you, you blocked, or you whiffed (missed entirely)

## D2D Overlay

- Per-slot success percentages (when enabled)
- Overall success rate
- Session timer or remaining trials
- Color-coded feedback per attempt

## Session Modes

- **TRIALS**: Fixed number of attempts
- **TIMER**: Timed session
- Stats exported to `data/Stats/TrainingReactions_SessionStats.txt`

## Tips

- Record a mix of fast and slow attacks to train different reaction windows
- Use slot weights in the Recording Slot Manager (Guide 07) to make certain actions appear more often
- The auto-loop waits for the dummy's action to complete before starting the next one
- Per-slot stats help identify which situations you struggle with most
