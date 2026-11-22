## Why

The iPhone 13 case currently exists as an OpenSCAD model. A build123d version would make the case available in the repository's Python CAD workflow while retaining the OpenSCAD model as the geometric reference. The case is the requested scope; its separate covers and magnetic accessories are not part of this change.

## What Changes

- Add a parametric build123d source for the iPhone 13 case and export its STL.
- Recreate the current case's major shape and functional cutouts, aiming for close visual and dimensional similarity without requiring exact surface parity.
- Publish the generated STL in the existing build123d website gallery while exposing only model outputs as public assets.

## Capabilities

### New Capabilities
- `build123d-iphone-case`: Covers the parametric case model, STL output, and its website preview.

### Modified Capabilities

## Impact

- Adds a build123d model and STL under `build123d/phones/`.
- Updates build123d gallery entries and static STL staging for the website.
- Does not change the existing OpenSCAD model, add dependencies, or include separate covers, magnetic latches, or print-layout parts.
