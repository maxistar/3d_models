## 1. Match the OpenSCAD center-spool geometry

- [x] 1.1 Correct the lower flange taper orientation in the build123d spool.
- [x] 1.2 Replace the centered torus channel approximation with the offset, clipped channel profile from OpenSCAD `wireChannel()`.
- [x] 1.3 Preserve the existing build123d parameters, center-spool-only scope, and `build123d/simple/cable_winder.stl` export path.

## 2. Verify the result

- [x] 2.1 Compare the build123d output against `openscad/cable_organizer/winder_center.stl` for envelope, channel profile, and flange direction.
- [x] 2.2 Confirm the generated shape is one valid solid and record any remaining tessellation-level differences.
