## Why

The OpenSCAD catalog already discovers models recursively, but the generated site flattens all groups into one list and hides the source directory that organizes them. Because the repository is public and its folder structure is meaningful, the site should expose that structure so visitors can browse models in the same hierarchy as the source tree.

## What Changes

- Represent the relative OpenSCAD source directory as a first-class part of the generated catalog.
- Group the OpenSCAD landing page by source directory instead of rendering one flat list of model groups.
- Add directory-aware pages and nested model URLs for discovered OpenSCAD groups.
- Add breadcrumbs and contextual links showing the path from OpenSCAD to directory to model group.
- Preserve the honeycomb logical grouping and blacklist behavior while placing the resulting group in its source directory.
- Preserve existing flat model URLs as compatibility routes pointing to the new nested canonical pages.
- Keep STL asset URLs and direct downloads based on the existing source directory layout.

## Capabilities

### New Capabilities

<!-- No new standalone capability; this change extends the existing catalog and navigation contracts. -->

### Modified Capabilities

- `source-driven-site-catalog`: expose deterministic relative directory information and nested group routing while retaining source/STL discovery rules.
- `site-navigation-shell`: add directory-aware navigation, breadcrumbs, and compatibility links for nested OpenSCAD pages.

## Impact

- The catalog generator and generated catalog data shape.
- Astro OpenSCAD index, directory, and model routes.
- Shared model-page navigation and breadcrumbs.
- Existing legacy and flat OpenSCAD routes, which will need compatibility handling.
- Catalog and site-generation tests.

