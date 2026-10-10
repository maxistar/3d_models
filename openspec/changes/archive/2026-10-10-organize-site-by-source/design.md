## Context

The Astro site currently has a flat set of page files under `docs/src/pages/`. OpenSCAD collections such as Blocknote, Helping Hand, Cable Organizer, and Honeycomb are represented by separate pages, while build123d has both a mixed gallery page and individual model pages. The site already publishes assets below `/3d_models/openscad/` and `/3d_models/build123d/`.

This change is intentionally a navigation and information-architecture step. The existing model pages, STL paths, viewer components, and deployment copy step should remain usable without migration of the model catalog.

## Goals / Non-Goals

**Goals:**

- Make OpenSCAD and build123d visible as the two primary source sections.
- Add a dedicated index page for each section.
- Give each section index links to the existing pages that belong to it.
- Link the home page to the two source sections.
- Preserve existing deep links and published STL asset paths.

**Non-Goals:**

- Moving existing model pages into nested URL directories.
- Replacing page-local STL arrays with a model manifest.
- Adding STL download controls.
- Automatically discovering or validating every STL file.
- Changing the STL viewer implementation or deployment workflow.

## Decisions

### Use section index pages as a compatibility layer

Create an `/openscad/` index page and reuse the existing `build123d.astro` page as the `/build123d/` section index. The build123d page already owns that route and gallery, so it will gain links to the available single-model pages instead of being duplicated by a nested index file. Current pages such as `/blocknote`, `/honeycomb`, `/mug`, and `/gridfinity_1x1` remain available.

Alternatives considered:

- Move every page immediately to `/openscad/<collection>` and `/build123d/<model>`. Rejected for this step because it introduces redirects, canonical URL decisions, and a larger change surface.
- Create `src/pages/build123d/index.astro` alongside the existing `build123d.astro`. Rejected because both files generate the same static route.
- Only rename labels on the home page. Rejected because it would not provide a reusable landing page for either source family.

### Keep section membership explicit

Each index page will explicitly link to the current collection/model pages. This keeps the first step predictable and avoids exposing intermediate or auxiliary STL files that happen to exist in the repository.

Alternatives considered:

- Scan all STL files at build time. Rejected because the repository contains variants, helper parts, and files that are not intended as public catalog entries.
- Introduce a centralized model manifest now. Deferred to a later change that also defines metadata and download behavior.

### Keep asset paths independent from page routes

The new navigation routes will not change `/3d_models/openscad/...` or `/3d_models/build123d/...` asset URLs. Pages continue to pass the existing asset URLs to the current viewer components.

## Risks / Trade-offs

- [Risk] The same model remains reachable through both a new section index and its existing flat URL. → Mitigation: treat the new indexes as navigation only and defer canonical URLs/redirects to a later migration.
- [Risk] Section indexes can become stale as new models are added. → Mitigation: keep the lists explicit for now and make catalog discovery/validation a separate follow-up change.
- [Risk] The current hard-coded `/3d_models` base path remains duplicated in pages. → Mitigation: do not expand this change; handle base-path normalization together with the future model catalog.

## Migration Plan

1. Add the OpenSCAD section index and extend the existing build123d section page with model links.
2. Update the home page to link to `/openscad/` and `/build123d/`.
3. Verify that existing collection/model URLs and STL viewer URLs still resolve.
4. Build the static site and inspect the generated section pages.

Rollback is deleting the two index pages and restoring the previous home-page links; no model assets or source files are changed.

## Open Questions

- Should the OpenSCAD index group pages by collection only, or also expose individual printable parts?
- Should the build123d index link to the existing mixed gallery, individual model pages, or both?
- When the catalog manifest is introduced, should it also become the source for section indexes?
