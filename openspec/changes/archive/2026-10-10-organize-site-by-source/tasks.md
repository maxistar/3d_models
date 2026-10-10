## 1. Add source-family index pages

- [x] 1.1 Define the explicit OpenSCAD collection links for the section index using the existing pages for Blocknote, Helping Hand, Helping Hand Solid, Cable Organizer, and Honeycomb.
- [x] 1.2 Create `docs/src/pages/openscad/index.astro` with an OpenSCAD section title and links to the selected existing collection pages.
- [x] 1.3 Define the explicit build123d model/page links using the existing build123d gallery and single-model pages.
- [x] 1.4 Extend the existing `docs/src/pages/build123d.astro` section page with links to the selected existing model pages.

## 2. Connect the new sections to site navigation

- [x] 2.1 Update `docs/src/pages/index.astro` so the primary navigation links to `/openscad/` and `/build123d/`.
- [x] 2.2 Keep existing collection and model page files unchanged so their current URLs remain available.
- [x] 2.3 Keep existing STL URL arrays and public asset paths unchanged.

## 3. Verify the static site

- [x] 3.1 Run the Astro production build from `docs/`.
- [x] 3.2 Verify the generated site contains `/openscad/index.html` and `/build123d/index.html`.
- [x] 3.3 Verify both section indexes link to existing pages and that existing model pages continue to reference their current STL URLs.
