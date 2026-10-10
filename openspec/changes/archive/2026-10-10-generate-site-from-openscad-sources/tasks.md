## 1. Catalog discovery and grouping

- [x] 1.1 Add a repository-level Node.js site-catalog generator that scans `openscad/` recursively and writes deterministic derived catalog data for Astro.
- [x] 1.2 Implement shared exclusion handling for `_*.scad` and repository-relative `.modelignore` entries, including diagnostics for excluded sources.
- [x] 1.3 Include only `.scad` sources with same-name `.stl` outputs, report missing outputs, and keep orphan/imported STL files out of the catalog.
- [x] 1.4 Implement directory-local filename-family grouping, singleton groups, stable slugs, collision detection, and the explicit `honeycomb` grouping override.
- [x] 1.5 Add catalog summary output and deterministic ordering for groups and model items.

## 2. Astro catalog-backed pages

- [x] 2.1 Add a reusable Astro model-page component that renders catalog items through the existing STL viewer and exposes a direct STL download link for each item.
- [x] 2.2 Add a dynamic OpenSCAD group route backed by the generated catalog and generate one canonical page per discovered group.
- [x] 2.3 Replace the hard-coded OpenSCAD section index with catalog-backed navigation while leaving the build123d section unchanged.
- [x] 2.4 Convert existing OpenSCAD flat pages into catalog-backed compatibility wrappers, including legacy collection pages that combine multiple filename families.
- [x] 2.5 Preserve current STL asset URLs and verify existing routes such as `/blocknote`, `/honeycomb`, and `/cablewinder` still render.

## 3. Build integration

- [x] 3.1 Add the catalog generation command to the docs build before `astro build`, with a separately invokable local command for inspection.
- [x] 3.2 Keep derived catalog output out of version control and ensure the docs build uses the committed `openscad` assets copied by the existing deployment workflow.
- [x] 3.3 Verify the deployment workflow runs catalog/site generation without installing or invoking OpenSCAD.

## 4. Verification and cleanup

- [x] 4.1 Add focused tests or fixtures for source/output pairing, blacklist and underscore exclusions, orphan STL handling, grouping, singleton pages, honeycomb override, and slug collisions.
- [x] 4.2 Run the catalog against the current repository and inspect the discovered groups, including `mi9_pro`, `honeycomb`, singleton sources, and blacklisted sources.
- [x] 4.3 Build the static site and verify generated OpenSCAD pages contain previews, download links, and deterministic navigation.
- [x] 4.4 Remove obsolete hard-coded STL arrays and manual OpenSCAD navigation only after their catalog-backed replacements pass verification.
