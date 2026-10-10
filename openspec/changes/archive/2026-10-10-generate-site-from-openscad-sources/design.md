## Context

The repository currently has two independent concerns that are easy to confuse:

```text
OpenSCAD sources + local process.sh  -> committed STL/PNG assets
committed assets + handwritten Astro -> static documentation site
```

The model exporter is intentionally local because OpenSCAD builds are expensive
and can require incompatible versions. The site build, however, is lightweight
and already runs in CI. Existing Astro pages duplicate the model catalog in
hard-coded STL arrays and section indexes, so a new eligible model requires
manual site edits.

The design must keep OpenSCAD generation out of CI while allowing the site build
to discover committed source/output pairs. It must also preserve the current
top-level source navigation and existing flat model URLs during migration.

## Goals / Non-Goals

**Goals:**

- Generate a derived OpenSCAD catalog during the docs build.
- Discover eligible `.scad`/same-name `.stl` pairs recursively under `openscad/`.
- Apply `_*.scad` and `.modelignore` exclusion rules consistently with
  `scripts/process.sh`.
- Group files into model pages using filename-prefix families, with an explicit
  `honeycomb` project grouping rule and singleton pages.
- Generate canonical OpenSCAD pages with STL preview and direct download links.
- Keep existing flat routes working through generated-data compatibility pages.
- Keep build123d discovery and Python model generation out of this change.

**Non-Goals:**

- Running OpenSCAD or generating STL/PNG files in CI.
- Treating orphan or imported STL files as public model sources.
- Extracting descriptions or metadata from comments in SCAD files.
- Replacing the existing build123d pages.
- Introducing a manually maintained model manifest.
- Redesigning the STL viewer or the visual style of the site.

## Decisions

### Use a separate site-catalog generator

Add a repository-level Node.js script, for example
`scripts/generate-site-catalog.mjs`. The docs package invokes it before
`astro build`. The script only reads sources and committed outputs and writes a
derived catalog for the Astro build.

This keeps responsibilities separate:

```text
scripts/process.sh --recursive openscad/
  -> local geometry generation

scripts/generate-site-catalog.mjs
  -> lightweight discovery and grouping

astro build
  -> HTML/static page generation
```

The catalog is generated into an ignored build-artifact location such as
`docs/src/generated/model-catalog.ts` and is not treated as a hand-edited
source of truth.

Alternative considered: make `process.sh` also generate Astro pages. Rejected
because it couples geometry generation to the site and would make local model
processing responsible for documentation concerns.

### Discover source/output pairs, not all STL files

The generator recursively scans `.scad` files and accepts a source only when:

1. its basename does not start with `_`;
2. its repository-relative path is not excluded by `.modelignore`; and
3. a same-basename `.stl` exists next to it.

The catalog stores the source path, STL asset path, group identity, display
name, and any legacy route aliases needed for compatibility. STL files without
an eligible source remain usable as imported dependencies or repository
artifacts but do not create pages.

Missing same-name STL outputs are skipped with a clear diagnostic. The
generator does not invoke OpenSCAD to repair them.

Alternative considered: scan the public asset directory and infer pages from
STL names. Rejected because it would expose helper/legacy assets and would make
generated files, rather than model sources, authoritative.

### Group by directory-local filename families

Discovery is performed within each OpenSCAD project directory so unrelated
projects cannot merge by filename. The default grouping algorithm is:

- an exact basename with descendants named `<basename>_*.scad` forms one family;
- remaining files sharing a meaningful prefix form a family when at least two
  files share it;
- a file that belongs to no family becomes a singleton page;
- the `openscad/honeycomb` directory is an explicit override and all eligible
  files in it form the `honeycomb` project page.

The grouping result has stable slugs derived from the source directory and
family name. If a slug collision occurs, the generator fails with a diagnostic
instead of silently merging pages.

Alternative considered: use one page per directory. Rejected because it would
hide meaningful families in directories such as `random` and would not support
the intended singleton behavior.

### Generate canonical pages and preserve legacy routes

Use a generic Astro model-page component and a dynamic OpenSCAD route such as
`docs/src/pages/openscad/[slug].astro`. Its `getStaticPaths()` reads the
derived catalog and creates one page per discovered group.

The OpenSCAD section index also reads the catalog, so adding a new source/STL
pair automatically adds a navigation entry. Existing flat pages such as
`/blocknote`, `/honeycomb`, and `/cablewinder` remain as small compatibility
wrappers backed by the same catalog. A compatibility alias may point to one
group or to a directory collection when an existing page historically combined
several families.

Alternative considered: immediately move every existing page to a new nested
URL and remove the flat routes. Rejected because it would break published
links and is unnecessary for establishing source-driven discovery.

### Add downloads at the model-item level

Every catalog item rendered on a model page exposes its committed STL asset URL
as both the viewer input and a direct download link. The download link uses the
browser `download` behavior where supported, while retaining a normal asset URL
fallback.

No separate copied download directory or API is introduced.

### Run discovery in the existing docs build

Add a docs package script or `prebuild` hook that runs the catalog generator
before `astro build`. CI continues to copy committed `openscad` assets and then
runs `npm run build`; it never installs or invokes OpenSCAD.

Local development can run the same step through `npm run build` or a dedicated
catalog command. The generator should produce deterministic ordering so the
derived output and generated routes are stable across machines.

## Risks / Trade-offs

- [Risk] A new source may be present before its STL is generated. → Mitigation:
  skip it with a visible diagnostic; local `process.sh --recursive` remains the
  repair path.
- [Risk] Filename grouping can produce an unexpected family. → Mitigation:
  keep grouping directory-local, make `honeycomb` explicit, detect collisions,
  and print the discovered groups during generation.
- [Risk] Existing flat pages and new canonical pages can duplicate content. →
  Mitigation: make flat pages compatibility wrappers backed by the same data and
  use canonical `/openscad/<slug>` links in new navigation.
- [Risk] A generated catalog becomes stale during local development. →
  Mitigation: run generation as part of `npm run build`; do not commit the
  derived file.
- [Risk] CI publishes a page whose STL asset was not copied. → Mitigation:
  validate every catalog asset path against the copied/public asset tree during
  generation or build.

## Migration Plan

1. Implement and locally test the catalog generator against the current
   OpenSCAD tree.
2. Add deterministic grouping output and verify `honeycomb`, `mi9_pro`,
   singleton models, and blacklisted sources.
3. Add the generic model page, dynamic OpenSCAD routes, and download links.
4. Convert the OpenSCAD section index and existing flat OpenSCAD pages to use
   catalog data.
5. Add the generator to the docs build and verify the CI copy/build flow.
6. Remove obsolete hard-coded STL arrays only after their catalog-backed
   replacements render successfully.

Rollback consists of removing the build hook and generated route/component
usage; committed STL assets and the local model-generation script are not
modified by this change.

## Open Questions

- Whether future project-specific grouping overrides should live in a small
  configuration file or remain code-level exceptions after `honeycomb`.
- Whether generated pages should show source filenames in addition to friendly
  labels.
- Whether missing STL diagnostics should become a failing build after the
  catalog is stable, rather than remaining warnings.
