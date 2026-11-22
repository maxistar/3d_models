## Why

The current build123d cable winder exports only the center spool, and its rendered shape differs visibly from the existing OpenSCAD center spool. Aligning the channel cuts and flange profiles will make the build123d model a trustworthy alternative for future parametric work.

## What Changes

- Match the build123d center spool's wire-channel geometry to the OpenSCAD `spoolInnerComplete()` implementation.
- Correct the lower tapered flange so it follows the OpenSCAD profile.
- Keep the scope to the center spool; the upper and lower housing pieces and their hooks remain out of scope.
- Preserve the existing build123d STL output path used by the site gallery.

## Capabilities

### New Capabilities
- `build123d-cable-winder-core`: Generate a center spool in build123d that closely matches the existing OpenSCAD spool.

### Modified Capabilities
- None.

## Impact

- `build123d/simple/cable_winder.py` and its generated `cable_winder.stl`.
- Add a capability spec for the center spool's dimensions, channel profiles, and parity checks against `openscad/cable_organizer/winder_center.stl`.
- No website gallery or dependency changes are expected because the existing STL URL remains unchanged.
