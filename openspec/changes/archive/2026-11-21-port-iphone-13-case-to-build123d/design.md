## Context

`openscad/phones/iphone_13.scad` contains the active `phone_case()` output plus optional covers and print-layout geometry. The requested build123d version covers only `phone_case()`. The repository uses build123d 0.10.0 in `build123d/uv.lock`; its existing examples export STL files from Python scripts. The build123d website gallery is a manually maintained URL list, and deployment currently copies only files under `build123d/simple`.

## Goals / Non-Goals

**Goals:**
- Create a parameterized build123d case source and a generated STL under `build123d/phones/`.
- Preserve the current OpenSCAD coordinate axes and nominal case/phone dimensions for easier comparison.
- Recreate the major fit and interaction features: shell and opening, lower port/speaker cutouts, camera relief, inner button recesses and tactile bumps, and tapered silent-switch slot.
- Aim for close geometry while accepting differences in edge blending and surface topology.
- Add the STL to the existing build123d gallery and stage it at a stable public URL without copying Python source or `.venv`.

**Non-Goals:**
- Port flat covers, magnetic parts, connector strips, or print layouts.
- Require mesh-level equality with the OpenSCAD output.
- Correct phone measurements or feature placement beyond the current active `phone_case()` unless separately requested.
- Add a new CAD dependency or replace the existing OpenSCAD model.

## Decisions

- Put the source and output at `build123d/phones/iphone_13_case.py` and `build123d/phones/iphone_13_case.stl`. This keeps the more involved model separate from the introductory `simple` examples.
- Use a parameter dataclass and small construction functions for the outer shell, cavity, and cutouts. Follow the repository's existing Python script/export convention and build123d 0.10.0.
- Keep X as width, Y as phone length, and Z as thickness to match the OpenSCAD source. Use a rounded 2D profile extruded into the shell, then selected edge fillets and boolean cuts. This is easier to maintain than translating each OpenSCAD `minkowski()` expression and is expected to differ slightly at transitions.
- Derive feature positions from named parameters rather than copying repeated coordinate expressions. Keep user-adjustable clearances explicit.
- Stage only the resulting STL at `/3d_models/build123d/phones/iphone_13_case.stl`; update local instructions and deployment staging for that specific model directory, and add its URL to the existing gallery. Do not publish the Python project or virtual environment.
- Compare the generated model against the current OpenSCAD case using overall dimensions, cutout locations, and visual inspection. Treat those checks as the acceptance basis rather than exact triangle matching.

Alternatives considered:
- Reproduce the OpenSCAD Minkowski construction directly: rejected as the default because it is expensive and may be harder to edit in build123d; it remains an option for any edge region where fillets cannot get close enough.
- Put the case under `build123d/simple`: rejected because it misrepresents the model's complexity and makes future phone models harder to organize.
- Build a fully automatic build123d catalog: deferred; this change needs one model added to the current gallery, not a catalog redesign.

## Risks / Trade-offs

- [Risk] Fillet selection may fail or alter adjacent transitions in OpenCascade. → Mitigation: construct the rounded profile first, apply fillets to a deliberately selected edge set, and validate after each major operation.
- [Risk] A close outer shape may still fit differently because wall and button clearances are not equivalent to the OpenSCAD Minkowski result. → Mitigation: keep clearances named and compare key widths/depths with the reference STL before calling the model complete.
- [Risk] The gallery URL could point to a missing file if local staging and CI staging diverge. → Mitigation: update both staging paths and verify the built site contains the exact STL URL.

## Migration Plan

1. Add the parametric case source and export its STL.
2. Add the STL to local site asset instructions and deployment staging without exposing the surrounding Python project.
3. Add the STL URL to the build123d gallery.
4. Generate the model, inspect key dimensions/features, and build the site.

Rollback removes the new build123d case files and gallery/staging entries; the OpenSCAD case and current build123d models remain unchanged.

## Open Questions

None for the agreed scope. The current OpenSCAD feature layout is the reference; any hardware-position corrections can be explored separately.
