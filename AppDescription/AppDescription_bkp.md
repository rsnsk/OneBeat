# Application Context

- is shown in exhibition context

# AppDescription

## Water Animation
- simple water animation: 
  - screen is devided into two parts, upper and lower, inbetween a horizontal line that is generated from 2 interfering sine waves
  - small bubbles inside the lower part (water)
  - like the fluid surface when looking at a glass of water from the side
  - the water surface can be moved vertically


## Touchbuttons
- TouchDown and TouchRelease events coming in via serial/USB toggling an internal state
- state changes are transmitted via serial/USB with custom commands: 
  - 1+ Touchbutton 1 down event
  - 1- Touchbutton 1 release event
  - 2+ ...
- the number of touchbuttons, that are in state touchdown at the same time is controlling the height of the water surface, the more the higher

## PNG Bubbles
- each Touchdown event also triggers this behavior:
  - 2 PNGs with alpha fades in, both same size and same position 
      1. PNG: circular shape like a bubble
      2. PNG: text overlay
  - both PNGs slowly move down and get smaller
  - first the text png fades out
  - then the bubble png fades out
- case: no touchbutton is down
  - the water line is low and not visible anymore
  - 2 PNGs fade in at the same position
    1. bubble like png, slowly rotating
    2. text png, not rotating
- case: all 8 touchbuttons are down
  - the water line is very high but there is still some air visible
  - a PNG fades in with a delay

## Background:
- web like animation
- an amount of dots is moving slowly 
- the dots are connected to some of their neighbors with thin lines
- the connections and positions are cluster-like: some areas with more and some with less dots/connections
- Background fallback: static png image

