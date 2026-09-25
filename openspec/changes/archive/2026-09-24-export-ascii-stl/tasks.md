## 1. Export Workflow

- [x] 1.1 Update `scripts/process.sh` to invoke OpenSCAD with `--export-format asciistl` for `.stl` output.
- [x] 1.2 Confirm the script still preserves existing output names and skip/rebuild behavior.

## 2. Documentation

- [x] 2.1 Update README regeneration instructions to mention ASCII STL output and the Git diff rationale.
- [x] 2.2 Ensure documentation still describes OpenSCAD as the required export tool.

## 3. Generated Artifacts

- [x] 3.1 Regenerate tracked STL outputs with the updated ASCII export workflow.
- [x] 3.2 Spot-check generated STL files to confirm they are text-based ASCII STL.

## 4. Verification

- [x] 4.1 Build the docs site to verify existing STL references and React viewer integration still compile.
- [x] 4.2 Run or document a browser/viewer smoke check for at least one regenerated ASCII STL model.
- [x] 4.3 Add a Three.js loader compatibility shim so `react-stl-viewer` can decode ASCII STL with current Three.js.
