# Build123d Honeycomb Panel

## Purpose

Define the build123d 8×8 honeycomb panel and its relationship to the reusable OpenSCAD honeycomb cell.

## Requirements

### Requirement: Build123d honeycomb panel follows the OpenSCAD cell profile and lattice
The repository SHALL provide an 8×8 build123d honeycomb panel whose cell dimensions, inner-wall profile, orientation, and placement pitch closely match the reusable OpenSCAD cell used by `small_wall.scad`. It SHALL preserve the existing STL output path and SHALL exclude perimeter frames, clips, and slots.

#### Scenario: Generate the 8×8 panel
- **WHEN** a developer runs `build123d/simple/honeycomb_wall_8x8.py` with default parameters
- **THEN** it exports `build123d/simple/honeycomb_wall_8x8.stl` as one valid connected panel with 8 mm cell height and 8 rows by 8 columns

#### Scenario: Match the OpenSCAD cell profile
- **WHEN** a build123d cell is compared with `_honeycomb_element.scad` `basic_model()`
- **THEN** its outer apothem is 11.8 mm, its inner apothem is 10 mm in the main wall, and its inner profile includes the 0.5 mm bottom lead-in and top relief from the OpenSCAD profile

#### Scenario: Place cells on the OpenSCAD lattice
- **WHEN** the 8×8 panel is assembled
- **THEN** flat-top cells use a horizontal pitch of `1.5 * r_outer`, a vertical pitch of `sqrt(3) * r_outer`, and alternate columns are shifted vertically by half the vertical pitch, with no unintended cell overlap

#### Scenario: Keep the panel scope
- **WHEN** the build123d panel is exported
- **THEN** it contains the 8×8 honeycomb field without the perimeter frame, connection clips, or slots from the larger OpenSCAD variants
