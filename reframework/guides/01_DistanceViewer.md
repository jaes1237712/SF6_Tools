# Distance Viewer

Real-time visualization of attack ranges, opponent zones, crossup distances, and jump arcs. Works in Training Mode and online matches.

## What Is This For?

Understanding your character's effective ranges is key to controlling neutral (the mid-range spacing game where both players are looking for openings). This tool shows you exactly where each of your moves can reach, so you can learn optimal spacing for pokes, anti-airs, and whiff punishes (hitting the opponent's missed attacks).

## Getting Started — Basic Mode

Basic Mode works out of the box with no setup. Just open the REFramework menu (Insert), find **Distance Viewer**, and make sure **Expert Mode** is OFF.

### What You See

A simple zone-based display using predefined distance thresholds. Four colored zones (Red/Orange/Yellow/Green) give you a quick read on your current spacing relative to the opponent.

### Crossup Indicator

Shows whether a forward jump from the current distance will cross up (land behind the opponent):
- **CrossUpSt** (red): Will cross up a standing opponent
- **CrossUpCr** (yellow): Will cross up a crouching opponent
- **No Cross** (grey): Won't cross up

### Jump Arc

A visual arc showing the forward jump trajectory from your current position.

---

## Expert Mode

Expert Mode replaces the simple zones with precise per-move range visualization. Each move gets its own colored marker on a distance line, so you can see exactly which attacks reach at your current spacing.

### How to Enable

1. Open the REFramework menu (Insert)
2. Find **Distance Viewer**
3. Toggle **Expert Mode** ON
4. The viewer loads attack range data from `data/SF6_DistanceViewer_data/SF6Distance_Data_Attacks.json` (included with the mod)

### What You See

#### Horizontal Line
A colored line extending from your character to the opponent, segmented by attack ranges:
- Each segment corresponds to a move's maximum reach
- Color gradient from close (red) to far (blue)
- A cursor marks the current distance

#### Vertical Markers
Full-height lines at each move's range boundary (configurable: top half, bottom half, or full screen).

#### Opponent Zone Label
Text above the opponent's head showing which move can reach from the current distance. Displays the move input with direction icons and updates in real-time as you move.

### Zone Configuration

You can customize the colored zones by assigning specific moves as reference points:

- **Red Zone**: Pick a move from the dropdown to define the "danger zone" — inside this range, that move will reach. A **TELEPORT** button places both characters at exactly that move's max range so you can practice spacing.
- **Orange Zone**: Same idea, but for a second reference move (typically a slightly longer-range poke).
- **Yellow Offset**: Adjust the width of the yellow zone beyond the orange zone (default 50).

This lets you build a personalized spacing map for your character — for example, set Red Zone to your best close-range punish and Orange Zone to your longest poke.

### Per-Move Preferences

Each character has a move list in Expert Mode. You can:
- Toggle visibility of individual moves to only show the ones you care about
- Use **Max Only** to show only the farthest-reaching move per guard type (standing/crouching)

### Display Options

| Option | Description |
|--------|-------------|
| Show Markers | Vertical lines at each move's range |
| Show Vertical Cursor | Moving line tracking current distance |
| Show Horizontal Lines | Horizontal distance bar |
| Show Numbers | Distance values on the bar |
| Show Opp Zone | Zone label above opponent |
| Crossup Show | Crossup distance indicator |
| Show Jump Arc | Forward jump arc visualization |
| Fill Background | Colored background fill between markers |
| Color Text | Color the zone text to match the zone color |

### Auto Active Mode

Automatically performs an action when the opponent enters a specific range:

1. In the **Auto Active** section, check **Enable**
2. Select a move from the dropdown — this includes all your character's logged moves plus **FORWARD JUMP** (uses the crossup distance as trigger range)
3. Set the **Delay** in frames with the -/+ buttons (0 = instant, 60 = 1 second delay before firing)
4. The dummy will auto-fire the selected move when the opponent is in range

**FORWARD JUMP** is especially useful for practicing anti-airs: the dummy will automatically jump at you from the right distance, so you can drill your anti-air reactions.

Useful for practicing anti-airs, whiff punishes, or spacing traps.

---

## Notes

- The viewer works in Training Mode, online matches, Battle Hub, and replays
- Attack range data is stored in `data/SF6_DistanceViewer_data/SF6Distance_Data_Attacks.json`
- Stance characters (e.g., characters with alternate fighting stances) show separate move sets per stance
