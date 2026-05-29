# Custom Combo Trials

Record your own combos and practice them with full validation, stats tracking, and visual feedback.

## Prerequisites

- Be in **Training Mode**
- Set the Script Manager to mode **4 (Custom Combo Trials)** — see Guide 02 for how to switch modes
- A dummy character must be present

## Quick Start — Recording a Combo

1. Switch to mode 4 (press **[0]** until "CUSTOM COMBO TRIALS" is active, or click it in the top bar)
2. Press **[1]** (keyboard) or **FUNC + LEFT** (gamepad) to start recording as P1
3. Perform your combo on the dummy
4. Press **[1]** again to stop recording and save

The combo is now saved and ready to practice.

## Quick Start — Playing a Trial

1. With a combo recorded, press **[2]** (keyboard) or **FUNC + UP** (gamepad) to start the trial
2. Perform the recorded combo — each step lights up green on success
3. If you drop the combo, it resets and you try again
4. Press **[2]** again to stop the trial

## Controls

| Action | Keyboard | Gamepad |
|--------|----------|---------|
| Record P1 / Stop & Save | [1] | FUNC + LEFT |
| Start Trial / Stop Trial | [2] | FUNC + UP |
| Record P2 | [3] | FUNC + DOWN |
| Switch Position Mode | [4] | FUNC + RIGHT |
| Demo (during trial) | D key | - |

## Position Modes

Cycle through 3 modes with the Switch Position button:

1. **Forced Position OFF** — Characters stay where you leave them
2. **Forced Position ON** — Characters teleport to recorded starting positions before each attempt
3. **Mirrored** — Same as Forced but positions are flipped (practice both sides)

## D2D Overlay

The floating window shows:
- Step list with direction/button icons for each move
- Current step highlighted during playback
- Green overlay on validated steps, dark overlay on failed steps
- Combo count per step (e.g., `[Combo: 3]`)

## Recording Features

- **Counter Type**: If a step lands as Counter Hit (hitting the opponent during their attack startup) or Punish Counter (hitting during recovery), it's recorded and automatically applied during playback
- **Guard Type**: The dummy's guard is managed automatically — guard after 1st hit during combos, no guard during oki (wakeup pressure) sequences
- **Follow-ups**: Multiple actions on the same step are grouped visually
- **Delay tracking**: Frame gaps between steps are recorded

## Session Mode

In the REFramework menu under **SESSION CONFIGURATION**:
- **TRIALS mode**: Set a number of attempts (10-200)
- **TIMER mode**: Set a duration (1-60 minutes)
- Start/Stop/Pause/Reset the session
- Stats are exported to `data/Stats/` at the end

## Combo Data

- Combos are saved per character in `data/TrainingComboTrials_data/CustomCombos/[CharacterName]/`
- Each file is a `.json` containing the step sequence, positions, and metadata
- Use the **Recording Slot Manager** (see Guide 07) to import/export slot data alongside combos

## Tips

- The first step is always validated on action detection — you don't need to hit the dummy
- For oki sequences (attacks timed against the opponent's wakeup after a knockdown), record a movement step (dash/jump) before the meaty attack — the system tolerates combo count gaps for movement steps
- Use **Demo** mode to watch the dummy perform your combo (useful for verifying timing)
- Flip inputs update dynamically before you start the combo, so walking to the other side works naturally
- You can also control Combo Trials from your phone via the Training Remote Control (see Guide 09). Available actions: Record, Start/Stop Trial, Reset, Demo, Position toggle.
