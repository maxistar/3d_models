## Why

The OpenSCAD site pages currently contain hand-maintained lists of STL files and hand-maintained navigation. Adding or removing a model therefore requires editing Astro pages separately from the model source, which allows stale links and makes the site stop reflecting the repository. The OpenSCAD source convention and local STL generation flow are now defined well enough to derive the site catalog automatically.

## What Changes

- Add a site-catalog generation step that discovers eligible OpenSCAD source/STL pairs from the repository.
- Group files into model pages using the established filename-prefix convention, with explicit support for the `honeycomb` project exception and singleton pages.
- Exclude `_*.scad`, paths listed in `.modelignore`, sources without a same-name STL, and imported/legacy STL files without a source from public model discovery.
- Generate model pages with STL previews and direct STL download links.
- Generate the OpenSCAD section navigation from the discovered catalog instead of maintaining its model list manually.
- Keep model generation separate: `scripts/process.sh` remains a local OpenSCAD exporter, and CI does not run OpenSCAD.
- Leave the current build123d pages and Python model generation outside this change.
- Preserve existing public model routes where they can be mapped to discovered groups.

## Capabilities

### New Capabilities

- `source-driven-site-catalog`: Discover eligible OpenSCAD models, group them into pages, and expose previews and downloads from generated site data.

### Modified Capabilities

- `site-source-navigation`: Replace manually curated OpenSCAD collection membership with navigation derived from the source-driven catalog while retaining the OpenSCAD/build123d top-level sections and compatible existing routes.

## Impact

- Adds a repository-local site catalog generator and derived catalog data used by Astro.
- Changes Astro page generation and the OpenSCAD section index under `docs/src/pages/`.
- Updates the docs build command so catalog generation runs before the static Astro build.
- Keeps committed STL assets and the existing local OpenSCAD generation workflow unchanged.
- Does not add OpenSCAD or other heavy geometry-generation dependencies to CI; the deployment workflow only builds the catalog and static site from committed sources and outputs.
- Existing manually authored build123d pages remain in place for a later change.
