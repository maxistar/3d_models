## Context

`build123d/simple/honeycomb_wall_8x8.py` currently creates 64 sharp-edged hexagonal rings with circumradius 12 mm and inner radius 10.2 mm. Its point-right cells are placed using point-up lattice pitches, so neighboring cells overlap before they are fused. The closest plain OpenSCAD reference is `openscad/honeycomb/small_wall.scad`, which uses the reusable cell profile from `_honeycomb_element.scad`; its outer frame and modular clips are outside this change.

## Goals / Non-Goals

**Goals:**
- Match the reusable OpenSCAD cell's 8 mm height, outer apothem 11.8 mm, inner apothem 10 mm, and tapered inner wall profile.
- Match the OpenSCAD flat-top hex orientation and lattice spacing while retaining an 8×8 build123d panel.
- Preserve the existing script, STL path, and gallery URL.

**Non-Goals:**
- Recreate the 14×10 clipped `small_wall` panel, its perimeter frame, or its 195×330 mm bounds.
- Add interlocking clips and slots from `panel_9x8.scad` or `panel_9x9.scad`.
- Change the website or add dependencies.

## Decisions

- Define cell dimensions by apothem to match OpenSCAD's `h_outer=11.8` and `h_inner=10`; derive circumradii as `2 * apothem / sqrt(3)`.
- Model the cell's inner profile using polygonal sections at the OpenSCAD Z breakpoints: 0, 0.5, 5, 6, and 8 mm. Keep the outer radius constant and change the inner radius to reproduce the bottom lead-in and top relief.
- Keep vertices at 0° and place columns at `1.5 * r_outer` horizontal pitch, with `sqrt(3) * r_outer` vertical pitch and alternate columns shifted vertically by half a pitch. This follows the OpenSCAD flat-top cell orientation and avoids the current unintended overlap.
- Use the 8×8 array as the comparison target; compare a representative cell/profile and lattice pitch to the OpenSCAD source rather than comparing panel bounds with the larger framed `small_wall` STL.

## Risks / Trade-offs

- **[Shared-wall Boolean risk]** Adjacent hollow cells meet along faces; fuse operations can create invalid seams. Validate the final panel as one solid and inspect intersections around cell junctions.
- **[Reference scope]** `small_wall.scad` uses more cells and an outer frame. The 8×8 output will have different overall bounds by design; compare local cell geometry and pitch.
- **[Profile tessellation]** OpenSCAD's `$fn=6` revolve and build123d's polygon sections may triangulate differently. Compare dimensions and cross-sections, not triangle order or count.

## Verification Notes

- The default build123d output is one valid solid with an 8 mm height and bounds `[-13.625, -11.8, 0]` to `[156.693, 188.8, 8]` for its 8×8 layout.
- Derived cell dimensions are outer radius 13.625466 mm (apothem 11.8 mm) and main inner radius 11.547005 mm (apothem 10 mm). Inner radii at the profile breakpoints are 12.047005 mm at Z=0, 11.547005 mm at Z=0.5 and Z=5, and 12.547005 mm at Z=6 and Z=8.
- Lattice pitches are 20.438199 mm horizontally and 23.6 mm vertically, with an 11.8 mm alternating column offset. Representative edge-neighbor intersections have zero volume.
- The build123d STL has 4,676 triangles; `small_wall.stl` has 13,850 but contains a 14×10 clipped field and perimeter rails, so those counts are not directly comparable. Both cell profiles use six-sided geometry; remaining STL triangulation may differ.
