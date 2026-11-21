## 1. Create the build123d case

- [x] 1.1 Add named iPhone/case parameters and preserve the OpenSCAD X/Y/Z coordinate convention.
- [x] 1.2 Build the rounded outer shell, inner cavity, and front opening for the case only.
- [x] 1.3 Add the lower openings, camera relief, tapered silent-switch slot, button recesses, and raised button features.
- [x] 1.4 Export the result as `build123d/phones/iphone_13_case.stl` from the model script.

## 2. Publish the case preview

- [x] 2.1 Stage the phone STL for local and deployment builds without copying Python sources or `.venv`.
- [x] 2.2 Add the phone case STL URL to the existing build123d gallery.

## 3. Verify the result

- [x] 3.1 Compare the exported model's envelope and feature locations with the current OpenSCAD case and refine clearances where needed.
- [x] 3.2 Build the documentation site and verify the gallery can load the staged STL.

## 4. Add the front retaining lip

- [x] 4.1 Taper the cavity into a slightly narrower front opening and verify the generated solid and gallery STL.
- [x] 4.2 Replace flat button-pad faces with rounded sliced-capsule profiles and verify the model and gallery STL.
