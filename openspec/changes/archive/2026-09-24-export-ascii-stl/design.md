## Context

The repository stores parametric OpenSCAD sources alongside generated mesh artifacts used for printing and for the documentation site's 3D previews. The batch export script currently invokes OpenSCAD with `--export-format binstl`, producing binary STL files. Binary STL files are compact, but Git cannot show meaningful diffs when generated mesh output changes.

The documentation site renders STL files via `react-stl-viewer`, whose bundled STL loader supports automatic detection of both binary and ASCII STL. OpenSCAD also supports explicit ASCII STL output with `--export-format asciistl`.

## Goals / Non-Goals

**Goals:**

- Make generated STL files text-diffable by exporting ASCII STL from the batch processing script.
- Keep existing `.stl` paths and website references unchanged.
- Document the intentional ASCII STL choice so future script changes do not accidentally revert to binary output.
- Verify the docs viewer can render regenerated ASCII STL files.

**Non-Goals:**

- Replace STL with another mesh format such as 3MF, OBJ, or glTF.
- Redesign the website viewer or change page routing.
- Change OpenSCAD source model geometry.
- Introduce a separate release artifact pipeline for binary STL files.

## Decisions

- Use OpenSCAD `--export-format asciistl` for generated `.stl` files.
  - Rationale: it preserves the existing file extension and website paths while making artifacts readable and diffable.
  - Alternative considered: rely on OpenSCAD's default `.stl` output. Rejected because OpenSCAD help indicates binary STL may become the future default, so the script should be explicit.
  - Alternative considered: add a configurable `--ascii` flag while keeping binary as default. Rejected for now because the repository goal is to make tracked artifacts reviewable by default.

- Keep the React STL viewer dependency unchanged.
  - Rationale: the current viewer's loader already supports both binary and ASCII STL with automatic detection.
  - Alternative considered: replace or wrap the viewer with a custom Three.js loader. Rejected because no additional viewer capability is needed.

- Regenerate existing tracked STL artifacts after changing the script.
  - Rationale: switching only the script would leave existing files binary until manually rebuilt, reducing the immediate value of the change.
  - Alternative considered: convert files lazily as sources change. Rejected because the repository would contain mixed binary and ASCII STL files for an extended period.

## Risks / Trade-offs

- ASCII STL files are typically larger than binary STL files → Accept the larger repository size for improved reviewability; verify that docs build and load performance remain acceptable.
- Large ASCII STL diffs can still be noisy for high-detail meshes → Reviewers can inspect textual changes when useful, while `.scad` remains the primary source of intent.
- Regenerating all STL files may produce broad diffs if OpenSCAD output ordering or precision differs → Use the existing batch script consistently and review changes as generated artifacts.
- Some external tools prefer binary STL for transfer efficiency → Users can still convert ASCII STL to binary in slicers or OpenSCAD if needed; repository artifacts prioritize Git visibility.
