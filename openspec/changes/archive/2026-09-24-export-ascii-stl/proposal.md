## Why

Generated STL files are currently exported in binary form, which makes mesh changes opaque in Git diffs. Exporting STL files as ASCII text will make generated model changes easier to review while keeping the existing website viewer workflow intact.

## What Changes

- Change the OpenSCAD batch export workflow to generate ASCII STL files instead of binary STL files.
- Document that generated `.stl` files are intentionally ASCII-formatted for Git reviewability.
- Verify that the existing React STL viewer continues to load and render ASCII STL files.
- Regenerate existing tracked STL outputs as ASCII where appropriate.

## Capabilities

### New Capabilities
- `ascii-stl-export`: Generated STL artifacts are exported in ASCII format so mesh output is text-diffable in Git.

### Modified Capabilities

## Impact

- Affects `scripts/process.sh`, which currently invokes OpenSCAD with `--export-format binstl`.
- Affects generated `.stl` artifacts under model directories when they are regenerated.
- Affects documentation describing how outputs are regenerated.
- No expected runtime API changes for the Astro/React documentation site; `react-stl-viewer` uses an STL loader that supports both binary and ASCII STL files.
