# Hit Confirm Training

Practice confirming hits into combos. The dummy blocks randomly, and you must react: continue the combo on hit, stop on block.

## What Is a Hit Confirm?

A hit confirm means reacting to whether your attack actually hit the opponent or was blocked. On hit, you continue into a full combo for maximum damage. On block, you stop attacking to stay safe. This is one of the most important skills in competitive play.

## Prerequisites

- Be in **Training Mode**
- Set the Script Manager to mode **1 (Hit Confirm)** — see Guide 02
- Record at least one attack sequence in the dummy's recording slots — see Guide 07 (Recording Slot Manager) for how to record dummy actions

## How It Works

1. Attack the dummy — it will randomly block or get hit
2. **On hit**: Continue your combo (confirm the hit)
3. **On block**: Stop attacking (confirm the block)
4. The script evaluates your reaction and shows SUCCESS or FAIL

## Setup

1. The dummy guard is automatically set to **Random** when Hit Confirm mode activates
2. Record your attack sequence in the training recording slots (see Guide 07)
3. Start a session using the controls below

## Controls

| Action | Keyboard | Gamepad |
|--------|----------|---------|
| Timer - / Trials - | [1] | FUNC + DOWN |
| Timer + / Trials + | [2] | FUNC + UP |
| Reset (idle) / Stop (active) | [3] | FUNC + LEFT |
| Start (idle) / Pause (active) | [4] | FUNC + RIGHT |

## Result Messages

| Message | Meaning |
|---------|---------|
| HIT CONFIRM SUCCESS | You correctly continued the combo on hit |
| BLOCK CONFIRMED | You correctly stopped on block |
| FAIL: HIT NOT CONFIRMED | The hit landed but you dropped the combo |
| FAIL: GAP IN COMBO AFTER HIT CONFIRMED | You confirmed, then dropped mid-combo |
| FAIL: ON BLOCK MISCONFIRM | Dummy blocked but you kept attacking |
| FAIL: GAP DETECTED AFTER DRC | Gap in your combo after a Drive Rush Cancel on block |
| FAIL: HEAVY DR CANCEL | Used Heavy + Drive Rush on block (unsafe option) |
| FAIL: SUBOPTIMAL (NEED HEAVY) | Drive Rush on hit but didn't follow up with a Heavy attack (suboptimal damage) |
| SUCCESS: OPTIMAL DRC HIT CONFIRM | Drive Rush on hit followed by the correct Heavy attack |

**Drive Rush Cancel (DRC)** is when you cancel a normal attack into a Drive Rush dash. The script tracks these separately because the optimal follow-up differs on hit vs block.

## Session Modes

- **TRIALS**: Fixed number of attempts — practice until you reach the count
- **TIMER**: Timed session — practice for a set duration
- Stats are exported to `data/Stats/HitConfirm_SessionStats.txt` at session end

## Tips

- The script detects multi-hit moves (same action with multiple active frames) and handles them correctly
- Drive Rush Cancel confirms are tracked separately with optimal/suboptimal feedback
- Light attacks only need combo count to validate; medium/heavy attacks need a new action to follow
