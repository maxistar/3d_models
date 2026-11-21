## Context

The deployment workflow already copies build123d STL files into `docs/public/build123d/simple`. The local README instead instructs developers to symlink the entire `build123d` project. Vite follows that link during the static build and reaches `.venv/bin/python`, whose target may not exist on the current machine.

## Goals / Non-Goals

**Goals:**
- Keep the existing `/3d_models/build123d/simple/<model>.stl` URLs.
- Make local asset setup match the deployment workflow by publishing only generated STL files from build123d.
- Remove the current local whole-project symlink and stage the same model files for the requested build.

**Non-Goals:**
- Change model routes, viewer behavior, or the OpenSCAD asset setup.
- Rebuild Python environments or alter build123d source files.
- Change deployment behavior, which already copies only build123d STL files.

## Decisions

- Replace the documented `build123d` directory symlink with a real `docs/public/build123d/simple` directory populated from `build123d/simple/*.stl`. This preserves the URLs used by existing Astro pages while excluding `.venv`, Python source, and project configuration.
- Keep the deployment workflow unchanged because its existing copy step already stages only STL outputs at the same public path.
- Remove the current local symlink and copy only STL assets before building, mirroring deployment.

Alternatives considered:
- Repair the stale Python interpreter link: rejected because the site does not need the virtual environment, and its presence in public assets is accidental.
- Symlink the whole `build123d/simple` directory: rejected because that directory also contains Python source files and still publishes more than the site needs.

## Risks / Trade-offs

- [Risk] Local staged STL files can become stale after a model is regenerated. → Mitigation: document that the STL copy step should be rerun after model outputs change; deployment already refreshes the files on every build.
- [Risk] A developer may retain the old directory symlink. → Mitigation: document its removal before creating the staged asset directory.

## Migration Plan

1. Remove the local `docs/public/build123d` symlink.
2. Create `docs/public/build123d/simple` and copy the generated STL files there.
3. Update local setup instructions to use this staging instead of linking the entire project.
4. Run the docs production build to confirm Vite no longer traverses `.venv` and model URLs still resolve.

Rollback is to restore the old local symlink and README instructions; the deployment workflow and source model tree are unaffected.

## Open Questions

None.
