## Why

The documentation site currently exposes model collections as a mostly flat set of pages. Visitors cannot immediately distinguish OpenSCAD models from build123d models, and the existing build123d pages mix collection-level and single-model views. Introducing two source-oriented top-level sections will make the site structure clearer while leaving the model catalog and download workflow open for later design.

## What Changes

- Add an `/openscad/` section index for OpenSCAD model collections.
- Add a `/build123d/` section index for build123d models.
- Update the home page to link to these two top-level sections.
- Keep the current model pages and their existing URLs working during this first stage.
- Keep the current STL asset paths unchanged.
- Do not yet introduce automatic model discovery, a centralized model manifest, or STL download controls.

## Capabilities

### New Capabilities

- `site-source-navigation`: Organize the model site around OpenSCAD and build123d top-level navigation sections while preserving existing model pages.

### Modified Capabilities

## Impact

- Affected Astro pages under `docs/src/pages/`, especially the home page and new section index pages.
- No changes to STL generation, model source files, or published asset paths.
- No new dependencies or runtime APIs.
- Existing deep links should remain compatible; future URL migration can be considered separately.
