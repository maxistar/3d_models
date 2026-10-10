## 1. Confirm migration scope

- [x] 1.1 Record all current references to the `blocknote`, `helping_hand`, `honeycomb_element`, and `RuggedBoxV1` filenames in source files, scripts, and Astro pages.
- [x] 1.2 Verify whether old direct STL paths need compatibility aliases; preserve them when they are consumed outside the repository, otherwise update all repository references to canonical names.
- [x] 1.3 Confirm the exact relative paths of every `RuggedBoxV1.scad` source that must be excluded.

## 2. Add source selection rules

- [x] 2.1 Add a root `.modelignore` file with comments explaining the exclusion policy and entries for every incompatible `RuggedBoxV1.scad` source.
- [x] 2.2 Rename `honeycomb_element.scad` to `_honeycomb_element.scad` and update all OpenSCAD `use`/`include` references.
- [x] 2.3 Document the prefix grouping rule, the `honeycomb` project exception, leading-underscore service files, and `.modelignore` in the model-generation documentation.

## 3. Normalize model-family names

- [x] 3.1 Rename the `blocknote` component sources to the `blocknote_*` convention and rename their matching STL/PNG artifacts.
- [x] 3.2 Rename `helping_left_base.scad` and `helping_right_base.scad` to `helping_hand_left_base.scad` and `helping_hand_right_base.scad`, including matching artifacts.
- [x] 3.3 Update OpenSCAD references and Astro page data to use the canonical renamed paths while keeping existing page URLs unchanged.

## 4. Apply filtering to batch generation

- [x] 4.1 Update `scripts/process.sh` to skip basenames beginning with `_` before checking or generating outputs.
- [x] 4.2 Update `scripts/process.sh` to read `.modelignore`, resolve entries relative to the repository root, and skip matching files with an explicit reason.
- [x] 4.3 Ensure skipped sources are excluded from missing-output failures and do not invoke OpenSCAD.

## 5. Validate the migration

- [x] 5.1 Verify that every renamed eligible source has a matching STL artifact, preserve any existing PNG previews, and confirm that the excluded sources are not regenerated.
- [x] 5.2 Build the documentation site and verify the existing model pages, including `blocknote`, `helpinghand`, and `honeycomb`.
- [x] 5.3 Search for stale old filenames and confirm that no unintended direct references or broken model links remain.
- [x] 5.4 Run the repository's available checks and inspect the final diff for accidental geometry or unrelated changes.
