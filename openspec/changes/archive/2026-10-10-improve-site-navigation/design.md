## Context

The site currently uses a nearly empty shared `Layout.astro`. Pages provide
their own occasional links, but there is no consistent header, footer, page
title, or parent navigation. The site should remain a small documentation
catalog rather than become a dashboard or a full client-side application.

## Goals / Non-Goals

**Goals:**

- Put a small, consistent site shell around every page.
- Make the main sections reachable from every page.
- Provide reliable logical back links for section and model pages.
- Expose the author's Printables and Thingiverse profiles without distracting
  from the model content.
- Improve document titles, typography, spacing, focus visibility, and basic
  responsive behavior.
- Keep the navigation available in static HTML without JavaScript.

**Non-Goals:**

- Adding a JavaScript hamburger menu, client-side router, or UI framework.
- Introducing a logo, icon library, card grid, theme switcher, or animation
  system.
- Changing STL viewer behavior or model/catalog discovery.
- Rewriting all page content or adding descriptions to models.

## Decisions

### Use `Layout.astro` as the single site shell

Extend the existing layout with:

1. a header containing the site name and primary links;
2. a main content wrapper with an optional contextual back link; and
3. a footer containing external profile links.

The layout accepts props such as `title`, `backHref`, and `backLabel`. Pages
with no parent context, such as the home page, omit the back link. Existing
pages can adopt the shell incrementally without changing their routes.

Alternative considered: repeat a small navigation block in every page. Rejected
because it will drift as pages are added and makes the minimal UI harder to
maintain.

### Keep primary navigation text-only and server-rendered

The header links are ordinary anchors for Home, OpenSCAD, and build123d. The
current path determines an `aria-current="page"` marker and a subtle active
style. The layout does not require JavaScript and remains usable when scripts
are disabled.

Alternative considered: a collapsible mobile menu. Deferred because the
current navigation has only three links and a wrapping horizontal layout is
adequate for the expected screen sizes.

### Use logical back links, not browser history

Model pages link back to their source section, while source-section pages link
back to the home page. The link text describes the destination, for example
`← OpenSCAD models`, rather than calling `history.back()`.

This keeps deep links and direct visits predictable.

### Keep external profiles in the footer

The footer contains text links to the exact Printables and Thingiverse profile
URLs. External links open in a new tab with `rel="noreferrer"` and are visually
secondary to model navigation.

Alternative considered: put profile links in the main header. Rejected because
they are useful secondary destinations and should not compete with model
navigation.

### Use restrained global CSS

Add a small set of layout-level styles: system font stack, readable line
height, a centered content width, neutral colors, link states, visible focus
outline, and responsive spacing. Preserve the existing viewer's dimensions and
allow long galleries to scroll naturally.

Document titles follow `<page title> | Maxistar 3D models`, with a fallback site
title for pages that do not provide one.

## Risks / Trade-offs

- [Risk] A shared style can accidentally affect the STL viewer. → Mitigation:
  scope layout styles to the shell/content elements and keep viewer component
  styles unchanged.
- [Risk] Hard-coded `/3d_models/` links may be inconvenient if the deployment
  base changes. → Mitigation: use the existing Astro base-path convention and
  keep link construction centralized in the layout/page props.
- [Risk] A text-only menu may become crowded as sections grow. → Mitigation:
  allow wrapping and revisit the interaction only when there are more primary
  destinations.
- [Risk] External profile URLs can change independently of the repository. →
  Mitigation: keep them in one footer location so they can be updated easily.

## Migration Plan

1. Extend `Layout.astro` with props, header, footer, metadata, and minimal CSS.
2. Update the home, OpenSCAD, build123d, and generated model-page call sites
   with titles and parent links.
3. Verify existing routes and STL viewer pages render inside the new shell.
4. Build the static site and inspect desktop/mobile-width HTML/CSS behavior.

Rollback is removing the shared shell markup/styles and restoring the previous
page-local links; model assets and routes are unaffected.

## Open Questions

- Whether the site name should remain `Maxistar · 3D models` or use a shorter
  label such as `3D models`.
- Whether the footer should include a copyright/year line in addition to the
  two profile links.
