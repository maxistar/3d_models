## Why

The current build123d 8×8 honeycomb panel uses a different cell profile and a lattice pitch that causes adjacent cells to overlap. Aligning the cell and placement geometry with the plain OpenSCAD wall panel will make the Python version a more reliable basis for future parametric models.

## What Changes

- Match the build123d cell dimensions and inner-wall profile to the reusable OpenSCAD honeycomb element.
- Correct the hex orientation and lattice spacing so neighboring cells meet without unintended overlap.
- Keep the build123d panel at 8×8 cells, without the OpenSCAD wall's perimeter frame or the modular panel's clips and slots.
- Preserve the existing `build123d/simple/honeycomb_wall_8x8.stl` output path and gallery URL.

## Capabilities

### New Capabilities
- `build123d-honeycomb-panel`: Generate a build123d 8×8 honeycomb panel whose cells and lattice closely match the OpenSCAD reference.

### Modified Capabilities
- None.

## Impact

- `build123d/simple/honeycomb_wall_8x8.py` and its generated STL.
- Add a capability spec for the cell profile, lattice spacing, output size, and comparison to `openscad/honeycomb/_honeycomb_element.scad` and `small_wall.scad`.
- No site changes or new dependencies are expected because the STL path remains unchanged.
