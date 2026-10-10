## Why

The model site is intentionally minimal, but individual pages currently have little shared orientation: navigation is repeated or absent, page titles are generic, and visitors have no consistent way to return to the model sections or find the author's external model profiles. A small shared site shell can improve navigation and discoverability without introducing a heavy visual design or client-side menu system.

## What Changes

- Add a shared header with the site name and simple links to Home, OpenSCAD, and build123d.
- Add contextual logical back links from model and section pages.
- Add a compact footer with links to the author's Printables and Thingiverse profiles.
- Make document titles reflect the current page instead of using a generic title.
- Add restrained global typography, spacing, link, focus, and layout styles while preserving the minimal visual character.
- Keep navigation server-rendered and usable without JavaScript.
- Preserve all existing model routes and STL viewer behavior.

## Capabilities

### New Capabilities

- `site-navigation-shell`: Provide a consistent, minimal, accessible shell with primary navigation, contextual back links, page titles, and external profile links.

### Modified Capabilities

## Impact

- Changes the shared Astro layout and model-page presentation under `docs/src/`.
- Updates pages that need contextual titles or parent links.
- Adds no runtime dependencies and no client-side navigation framework.
- Does not change model discovery, STL generation, published asset paths, or build123d model generation.
- External links point to the existing Printables and Thingiverse profile URLs.
