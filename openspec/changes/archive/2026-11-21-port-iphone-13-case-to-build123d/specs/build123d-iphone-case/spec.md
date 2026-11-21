## ADDED Requirements

### Requirement: Build123d provides a parametric iPhone 13 case model
The repository SHALL provide a build123d Python source that generates a printable iPhone 13 case and a matching STL. The model SHALL preserve the current OpenSCAD case's nominal dimensions and major fit features while allowing reasonable geometric differences in edge transitions. It SHALL exclude separate covers, magnetic accessories, and print-layout parts.

#### Scenario: Generate the build123d case
- **WHEN** a developer runs the build123d case source in the configured Python environment
- **THEN** the script exports `build123d/phones/iphone_13_case.stl`

#### Scenario: Compare the case to the OpenSCAD reference
- **WHEN** the generated case is inspected against the active `phone_case()` geometry
- **THEN** the overall envelope and locations of the lower openings, camera relief, side controls, and silent-switch slot correspond to the current reference, without requiring identical mesh surfaces

#### Scenario: Case-only output
- **WHEN** the build123d case STL is generated
- **THEN** it contains the case and its tactile button features without flat covers, magnetic latches, or print connectors

#### Scenario: Retain the phone at the front opening
- **WHEN** the build123d case is generated
- **THEN** the opening is 0.2 mm smaller per side than the nominal phone outline and transitions over a shallow tapered retaining lip

#### Scenario: Print tactile button pads without a flat overhang
- **WHEN** the build123d case is generated
- **THEN** the raised button pads have the rounded capsule profile of the OpenSCAD plugs, with curved outer surfaces that avoid a broad horizontal underside

### Requirement: Build123d case is visible in the website gallery
The documentation site SHALL include an interactive preview of the generated case STL in the existing build123d gallery. Static asset staging SHALL publish the STL at its gallery URL without exposing Python source files or the build123d virtual environment.

#### Scenario: Build the documentation site
- **WHEN** the local or deployment site build stages model assets
- **THEN** `/3d_models/build123d/phones/iphone_13_case.stl` is available to the gallery and the build123d Python environment is not copied into the public site

#### Scenario: View the case in the gallery
- **WHEN** a visitor selects the iPhone 13 case in the build123d gallery
- **THEN** the interactive STL viewer loads the generated case model
