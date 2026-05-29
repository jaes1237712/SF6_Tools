# Post-Guard Training

Practice punishing the dummy after blocking its attacks. The dummy attacks, you block, then punish during its recovery.

## What Is a Punish?

After you block an attack, the opponent is briefly stuck in recovery. If the attack is "unsafe," you can hit them during that recovery window — this is called a **punish**. Learning which moves are punishable and reacting in time is key to strong defense.

## Prerequisites

- Be in **Training Mode**
- Set the Script Manager to mode **3 (Post Guard)** — see Guide 02
- Record at least one attack sequence in the dummy's recording slots — see Guide 07 (Recording Slot Manager) for how to record dummy actions

## How It Works

1. The dummy performs a recorded attack
2. You block it
3. **If the dummy is in recovery**: Punish with your own attack
4. **If the dummy does nothing after**: Wait and don't press buttons
5. **If the dummy uses Drive Impact** (a powerful armored attack, costs 1 Drive bar): React with your own Drive Impact or counter

## Setup

1. Record attacks for the dummy to perform — see Guide 07 (Recording Slot Manager)
2. The dummy guard is automatically set to **Guard All** when Post Guard activates
3. Start a session using the controls below

## Controls

| Action | Keyboard | Gamepad |
|--------|----------|---------|
| Timer - / Trials - | [1] | FUNC + DOWN |
| Timer + / Trials + | [2] | FUNC + UP |
| Reset (idle) / Stop (active) | [3] | FUNC + LEFT |
| Start (idle) / Pause (active) | [4] | FUNC + RIGHT |

## Scoring

- **Success**: You punished the dummy during its recovery window
- **Fail**: You attacked when you shouldn't have (the dummy's move was safe) or didn't punish in time
- **DI Counter**: Detected and tracked separately when Drive Impact is involved

## Configuration

In the REFramework menu:
- **block_stun_grace**: Extra frames of leniency after blockstun ends before the script starts judging you (default 10 — at 60fps, that's about 0.17 seconds)
- **observation_window**: Maximum time you have to land your punish after blockstun ends (default 120 frames = 2 seconds)
- **Debug Info**: Shows player states, current phase, and scoring details

## Session Modes

- **TRIALS**: Fixed number of attempts
- **TIMER**: Timed session
- Stats exported to `data/Stats/PostGuard_Stats.txt`

## Tips

- The script detects parries and throw techs as valid defensive options
- Focus on recognizing which moves are punishable vs safe — the script trains your decision-making, not just your reactions
