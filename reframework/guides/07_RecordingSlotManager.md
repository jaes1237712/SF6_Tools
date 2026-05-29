# Recording Slot Manager

Manage the 8 training dummy recording slots: import, export, activate, and configure weights.

## What Are Recording Slots?

Training Mode lets you record up to 8 action sequences for the dummy to play back. Several training scripts (Hit Confirm, Reaction Drills, Post Guard) rely on these recordings. This manager lets you save, load, and organize your slot data.

## Prerequisites

- Be in **Training Mode**

## Importing Slot Data

1. Open the REFramework menu (Insert) and find **Recording Slot Manager**
2. In **SOLO OPERATIONS**, select a `.json` file from the dropdown (filtered by your current character)
3. Click **IMPORT** — the slots are populated from the file
4. If **Activate On Load** is checked, all imported slots auto-activate

## Exporting Slot Data

1. Click **EXPORT** to save current slots to the default character file
2. Or click **SAVE AS** to choose a custom filename
3. Files are saved to `data/SF6_RecordingSlotManager_data/[Character].json`
4. **EXPORT ALL CHARS**: Hold the button for 1 second to export data for all characters at once

## Live Slots Table

The table shows all 8 slots with:

| Column | Description |
|--------|-------------|
| ID | Slot number (1-8) |
| Active | Checkbox to enable/disable the slot for playback |
| Weight | Probability weight for random selection (higher = more frequent) |
| Frames | Total frame count of the recording |
| Import | Dropdown to import replay data into this specific slot |

- **ACTIVATE ALL / DEACTIVATE ALL**: Quick toggle for all slots
- **Refresh All**: Re-read slot data from the game

## Replay Input Logger

Record inputs during replays to import into training slots later:

1. Expand **REPLAY INPUT LOGGER**
2. Choose recording target: **P1**, **P2**, or **Dual**
3. The recording captures inputs during replay playback
4. Saved files appear in `data/TrainingComboTrials_data/ReplayRecords/`
5. Import them via the slot table's dropdown

## Data Format

Slot data uses a timeline format:
```json
{"timeline": ["10f : 5", "3f : 2+LP", "1f : 236+HP"]}
```
Each entry: `[frame_count]f : [direction]+[buttons]`

## Notes

- The manager handles memory allocation automatically — if a slot doesn't have enough memory, it queues allocation steps
- Dirty state tracking warns you about unsaved changes
- Files are filtered by character name so you only see relevant data
- Weight values affect how often a slot is picked during random playback — useful for Reaction Drills (Guide 06) where you want certain actions to appear more often
