# Training Remote Control

Control your training tools from your phone via a web interface. No app install required — it runs in your phone's browser.

## What Is the Training Remote Control?

The Training Remote Control lets you adjust training mode settings, switch tools, and trigger actions from your phone while you play. Instead of pausing to navigate menus with a controller, you tap buttons on a web page served by a local server running on your PC.

## Setup

1. Navigate to `SF6_TrainingRemoteControlServer/` inside the REFramework folder
2. Launch **SF6_TrainingRemoteControl.exe**
3. A tray icon appears in the Windows taskbar — it is hexagonal and cyan-colored
4. Right-click the tray icon and note the URL displayed (your local IP on port 4850)
5. Open that URL in your phone's browser
6. Alternatively, click **Show QR Code** in the tray menu and scan it with your phone's camera

Your phone and PC must be on the same local network (Wi-Fi).

## Tray App Features

The tray application manages the server and provides quick access options:

| Option | Description |
|--------|-------------|
| Start Server | Manually start the web server |
| Stop Server | Manually stop the web server |
| Show QR Code | Display a QR code window to scan with your phone |
| Start with Windows | Toggle auto-launch when Windows boots |

The tray app also handles automatic lifecycle management:

- **Auto-starts** the server when Street Fighter 6 launches
- **Auto-stops** the server 5 seconds after Street Fighter 6 closes
- You can still start and stop the server manually at any time via the tray menu

## Phone Interface

The web interface is divided into sections matching the training tools:

### TRAINING MODE

Switch between training modes with a single tap:

- **Disabled** — all training scripts inactive
- **Hit Confirm** — see Guide 04
- **Reaction Drills** — see Guide 06
- **Post Guard** — see Guide 05
- **Combo Trials** — see Guide 03

The selected mode syncs immediately with the Script Manager (Guide 02).

### COMBO TRIALS

When Combo Trials mode is active, additional controls appear:

| Control | Description |
|---------|-------------|
| Record | Start recording a combo sequence |
| Start Trial | Begin the current trial |
| Stop | Stop the active trial |
| Reset | Reset trial progress |
| Demo | Play back the recorded combo demonstration |
| Position | Toggle between ANY, EXACT, and MIRROR positioning |
| File Selector | Dropdown to pick a combo trial file |

### DISTANCE VIEWER

Configure the Distance Viewer overlay from your phone:

- Zone configuration — adjust distance zones and thresholds
- Move visibility — toggle which moves appear in the overlay
- Auto Activate — automatically enable the distance viewer when entering Training Mode

### SHELDON BOXES

Toggle hitbox, hurtbox, and collision box display options for the Sheldon's Boxes mod.

### UI Toggle

A **VISIBLE / HIDDEN** toggle to show or hide the entire in-game training UI overlay. Useful when you want a clean screen for recording gameplay or screenshots.

## How It Works

The server runs on **port 4850** and serves a lightweight web page to your phone. The phone interface and the game sync in real-time — changes made on your phone are reflected in-game immediately, and in-game state changes update the phone interface.

Bridge data is stored in `data/SF6_TrainingRemoteControl_data/`.

## Notes

- The server only accepts connections from your local network
- Multiple devices can connect simultaneously
- If the QR code does not scan, type the URL manually — it is your PC's local IP followed by `:4850`
- The tray app stays running in the background and uses minimal resources
