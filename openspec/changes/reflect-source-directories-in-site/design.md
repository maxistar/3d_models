## Context

The generated OpenSCAD catalog already walks the source tree recursively and stores a directory value on each model group, but the Astro section page discards that value and renders a flat list. The repository is public, so directory names are intentional public structure. The site must reflect that structure while continuing to use committed STL files as the only published geometry and while preserving existing links.

## Goals / Non-Goals

**Goals:**

- Make relative OpenSCAD source directories the first level of OpenSCAD browsing.
- Generate directory-aware model URLs and directory pages from the catalog.
- Preserve filename-family grouping, the honeycomb exception, blacklist behavior, previews, and direct STL downloads.
- Keep existing flat and handwritten legacy routes usable.
- Keep generation deterministic and independent of OpenSCAD execution.

**Non-Goals:**

- Renaming or reorganizing source directories.
- Introducing a separate manifest or hand-maintained page registry.
- Generating STL files during site builds.
- Changing build123d discovery or Python model handling.
- Adding descriptions or metadata beyond what can be derived from the source tree.

## Decisions

### Preserve the complete relative directory path

The catalog will retain the normalized POSIX path relative to `openscad`, not only the leaf directory. Directory entries will be derived from eligible groups and will contain their groups in deterministic order. This supports future nested directories without changing the data model again.

The existing `directory` field can remain the source of this value if its contract is made explicit; additional derived directory entries may be added for page generation. Source paths and asset paths remain distinct from public route slugs.

### Use a two-level browsing model

The OpenSCAD landing page will list source directories. Each directory page will list the model groups found directly in that directory, and each group will have a nested model page.

The canonical route shape is:

```text
/3d_models/openscad/
/3d_models/openscad/<directory>/
/3d_models/openscad/<directory>/<group>/
```

Directory route segments will be generated deterministically from directory names, while the displayed directory name will remain tied to the public source folder. Root-level groups remain available from the OpenSCAD landing page because they have no parent directory segment.

This uniform hierarchy is preferred over omitting directory pages for singleton directories: it mirrors the repository consistently and leaves room for future groups without changing URLs.

### Generate routes from catalog data

Astro static paths will be generated from the derived catalog rather than rescanning `openscad`. A catch-all OpenSCAD route or equivalent nested route structure will distinguish directory pages from group pages using catalog lookups. The implementation must fail clearly for route collisions instead of silently choosing one group.

### Keep compatibility routes as aliases

Existing flat generated routes and handwritten legacy routes will remain as compatibility entry points. They will render the same model content or redirect to the nested canonical path, and model pages will expose the canonical directory-aware URL where the route differs.

### Keep directory names public but normalize URLs safely

The visible directory label will come from the source directory name. URL segments may use the repository's existing deterministic slug normalization so spaces or punctuation cannot produce unsafe routes. The generator will detect collisions between normalized directory segments and report the conflicting source paths.

### Treat exclusions before hierarchy construction

Internal sources, `.modelignore` entries, and sources missing same-name STL files will be removed before directory entries are built. Empty directories therefore cannot appear in public navigation, and excluded projects such as `rugged_box` remain absent.

## Risks / Trade-offs

- [Risk] Directory pages add an extra click for singleton projects. → [Mitigation] Keep the pages minimal and expose clear breadcrumbs; revisit only if browsing data shows the extra level is harmful.
- [Risk] Existing external links may point to flat routes. → [Mitigation] Preserve legacy route wrappers or redirects and test every existing compatibility mapping.
- [Risk] Two source directories may normalize to the same URL segment. → [Mitigation] Validate directory slug collisions during catalog generation and fail with both paths identified.
- [Risk] Public folder names may be technical or inconsistent. → [Mitigation] Display them honestly for now; renaming remains an explicit repository change rather than hidden site metadata.
- [Risk] A catch-all route could overlap existing handwritten pages. → [Mitigation] Keep route precedence explicit and add build checks for generated paths and legacy routes.

## Migration Plan

1. Extend catalog generation and tests with normalized directory entries and directory-aware route metadata.
2. Add nested OpenSCAD directory and group routes, breadcrumbs, and grouped landing-page navigation.
3. Update compatibility wrappers/canonical links for existing flat and legacy routes.
4. Build the site and verify representative singleton, multi-group, honeycomb, root-level, blacklisted, and legacy cases.

Rollback is a code revert: the existing flat catalog/page generation can be restored without changing source models or STL assets.

## Open Questions

- Should the display label for the root source directory be `root`, `Other`, or should root-level groups appear directly without a label?
- Should compatibility routes redirect to canonical pages or render the page with a canonical-link marker while preserving the old URL?

