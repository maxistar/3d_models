## 1. Extend the source catalog

- [x] 1.1 Define the generated catalog representation for normalized relative directory paths, directory entries, group membership, and nested route metadata.
- [x] 1.2 Update `scripts/generate-site-catalog.mjs` to derive directory entries after source filtering, preserve complete nested paths, order directories/groups/items deterministically, and validate directory/group route collisions.
- [x] 1.3 Extend catalog tests for singleton directories, multi-group directories, nested directories, root-level sources, the honeycomb grouping exception, excluded-only directories, and slug collisions.

## 2. Generate directory-aware OpenSCAD pages

- [x] 2.1 Change the OpenSCAD landing page to list discovered source directories as the first navigation level and link each directory to its generated page.
- [x] 2.2 Add generated directory pages that list the groups found directly below each source directory.
- [x] 2.3 Add nested model routes whose paths include the source directory and reuse the existing preview and STL download rendering.
- [x] 2.4 Add directory and group breadcrumbs/context links, including correct behavior for root-level groups and the honeycomb project.

## 3. Preserve compatibility and verify the site

- [x] 3.1 Keep existing flat generated routes and handwritten legacy routes usable, and expose the nested route as the canonical destination where applicable.
- [x] 3.2 Verify that blacklisted sources and missing STL outputs do not create directory entries or pages, while imported/orphan STL behavior remains unchanged.
- [x] 3.3 Run catalog tests and a production site build, then verify representative directory, nested model, legacy, preview, download, and navigation URLs.
- [x] 3.4 Run `git diff --check` and confirm catalog generation remains free of OpenSCAD or geometry compilation.
