## Why

The local Astro setup exposes the entire `build123d` project through `docs/public`, including its virtual environment. Vite then follows a stale Python executable symlink while copying static assets and fails the build. The site only needs generated STL files, and deployment already stages those files separately.

## What Changes

- Keep build123d model URLs stable while limiting local public assets to generated STL files.
- Align the local setup instructions with the existing deployment asset staging.

## Capabilities

### New Capabilities
- `site-static-model-assets`: Defines which model artifacts are staged for static site delivery.

### Modified Capabilities

## Impact

- Affects `docs/public` local asset setup and `docs/README.md` instructions.
- No route or model-viewer API changes; current STL URLs remain unchanged.
