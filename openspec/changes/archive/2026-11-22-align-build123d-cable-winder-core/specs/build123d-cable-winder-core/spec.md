## ADDED Requirements

### Requirement: Build123d generates a center spool close to the OpenSCAD reference
The repository SHALL provide a build123d model that generates the cable winder's center spool using the OpenSCAD reference dimensions and channel profile. It SHALL preserve the existing output path and SHALL NOT include the top or bottom housing halves or their hooks.

#### Scenario: Generate the center spool
- **WHEN** a developer runs `build123d/simple/cable_winder.py` with its default parameters
- **THEN** it exports `build123d/simple/cable_winder.stl` as one valid solid with a 29 mm inner diameter, 33 mm spool diameter, 35 mm maximum flange diameter, and 16 mm height

#### Scenario: Match the OpenSCAD wire channels
- **WHEN** the default build123d spool is compared with `openscad/cable_organizer/winder_center.stl`
- **THEN** the channel cuts follow the offset and clipped profile of OpenSCAD `wireChannel()` rather than a single centered torus approximation

#### Scenario: Match the flange taper orientation
- **WHEN** the build123d spool is inspected at its lower flange
- **THEN** the maximum diameter is at the bottom edge and the taper narrows toward the spool body, matching OpenSCAD `spoolSolid()`

#### Scenario: Keep the scope to the center spool
- **WHEN** the build123d output is generated
- **THEN** it contains the center spool only and excludes the upper/lower housing halves and hooks
