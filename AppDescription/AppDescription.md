# OneBeat Application Description

## Context
- Interactive exhibition installation
- Display: 1080x1920 portrait (BrightSign HD1026)
- Rendered as a single-page HTML app with Canvas 2D

---

## App States

The app has three distinct visual states, driven by how many touchbuttons are currently pressed:

### State: Idle (0 buttons pressed)
- light sage/beige (`#D8DDB5`) with scattered decorative circle outlines
- **Water line**: below the visible screen area (not visible)
- **Center bubble**: Bubble_idle.png in the center of the screen
  - 2 PNGs fade in at the same position, both centered:
    1. Bubble PNG: circular shape, slowly rotating
    2. Text PNG: text overlay, not rotating (e.g. "Dank euch – für die Gesundheit aller")
- **Transition to Active**: when any touchbutton is pressed, crossfade to Active state palette and spawn a PNG bubble

### State: Active (1–7 buttons pressed)
- **Background**: light sage/beige (`#D8DDB5`)
- **Water line**: visible, rises proportionally with the number of pressed buttons
  - 0 buttons = offscreen below; 8 buttons = near the top (but some "air" remains visible)
- **PNG bubbles**: each new TouchDown spawns a bubble (see PNG Bubble Animation below)
- **Center bubble**: a dark green filled circle with a thin ring outline, positioned in the lower portion of the screen
  - Contains text (e.g. "Gentherapien verbessert")
  - Size and vertical position correspond to the number of active buttons (more buttons = larger circle, higher position)

### State: Full (all 8 buttons pressed)
- **Initial transition**: when the 8th button is pressed, it first triggers a PNG bubble animation like all other buttons (see PNG Bubble Animation below)
- **After timeout**: the Full state visuals fade in
- **Background**: light sage/beige (`#D8DDB5`)
- **Water line**: very high, near the top, but a strip of "air" remains visible
- **Center bubble**: large dark green circle, centered
  - Surrounded by concentric tech-ring decorations: multiple circular outlines with tick marks (like a clock face)
  - These rings fade in after the timeout
  - Text inside: e.g. "Deine Daten für die Gesundheit aller"

---

## Water Animation
- The screen is divided into two parts (upper = air, lower = water) separated by a wavy horizontal line
- The wave is generated from 2 interfering sine waves
- Small bubbles float inside the water portion
- The visual resembles the fluid surface when looking at a glass of water from the side
- The water surface Y-position is controlled by the number of active touchbuttons:
  - 0 buttons: water line is below the screen (not visible)
  - 1–7 buttons: water line rises proportionally
  - 8 buttons: water line is near the top, leaving a small air gap

---

## PNG Bubble Animation: TouchBubbles
- Triggered on each TouchDown event:
  1. 2 PNGs fade in at the same position and size:
     - Bubble PNG: circular bubble shape
     - Text PNG: text overlay
  2. Both PNGs slowly drift downward and shrink
  3. The text PNG fades out first
  4. Then the bubble PNG fades out
- Multiple bubbles can be active simultaneously (one per button press)

---

## Touchbuttons (Serial Protocol)
- 8 physical touchbuttons (XT-1GW6 via Nexmo XN-185)
- 2 serial devices connected to BrightSign HD1025:
  1. **XT-1GW6** (input): sends button state changes to BrightSign
  2. **Teensy microcontroller** (output): receives commands from BrightSign
- TouchDown and TouchRelease events toggle an internal boolean state per button
- Serial command format (received from XT-1GW6):
  - `1+` = Touchbutton 1 pressed
  - `1-` = Touchbutton 1 released
  - `2+` = Touchbutton 2 pressed
  - `2-` = Touchbutton 2 released
  - ... up to `8+` / `8-`
- BrightSign reads these commands from XT-1GW6 and forwards them to the Teensy microcontroller

---

## Background Animation
- Animated network/web pattern behind all content
- Slowly moving dots connected to nearby neighbors with thin lines
- Dot distribution is cluster-like: some areas denser, some sparser
- Fallback: static PNG image (for performance or compatibility)

---

## Transitions
- State changes (Idle ↔ Active ↔ Full) should crossfade smoothly
- The tech-ring decoration in Full state fades in with a delay after all 8 buttons are pressed
- When buttons are released, the app transitions back (Full → Active → Idle) with corresponding visual changes

