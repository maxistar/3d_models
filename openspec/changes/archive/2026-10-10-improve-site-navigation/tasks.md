## 1. Shared site shell

- [x] 1.1 Extend `docs/src/layouts/Layout.astro` with page title, site header, primary navigation, content wrapper, and footer props.
- [x] 1.2 Add minimal responsive CSS for typography, spacing, links, active navigation, and visible keyboard focus states without changing STL viewer styles.
- [x] 1.3 Add Printables and Thingiverse profile links to the shared footer with safe external-link attributes.

## 2. Page integration

- [x] 2.1 Add contextual parent/back links and meaningful titles to the home, OpenSCAD index, and build123d pages.
- [x] 2.2 Update the reusable OpenSCAD `ModelPage` component and legacy model wrappers to pass page titles and logical parent links.
- [x] 2.3 Ensure generated OpenSCAD pages and existing model routes keep their current URLs and viewer/download behavior.

## 3. Verification

- [x] 3.1 Build the static site and verify the shared header/footer, page titles, primary links, and external profile links are present in generated HTML.
- [x] 3.2 Verify model and section pages remain usable without JavaScript and that keyboard focus styles are visible.
- [x] 3.3 Check the rendered layout at narrow and wide viewport widths, then run `git diff --check` and review the final route changes.
