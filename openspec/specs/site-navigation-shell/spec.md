# site-navigation-shell Specification

## Purpose
TBD - created by archiving change improve-site-navigation. Update Purpose after archive.
## Requirements
### Requirement: Site provides consistent primary navigation
Every rendered site page SHALL include a shared header with links to the home page, the OpenSCAD section, and the build123d section.

#### Scenario: Visitor opens a model page
- **WHEN** a visitor opens any model page
- **THEN** the page header provides links to Home, OpenSCAD, and build123d

#### Scenario: Visitor selects a primary section
- **WHEN** a visitor selects OpenSCAD or build123d from the shared header
- **THEN** the browser navigates to the corresponding existing section URL

### Requirement: Site provides contextual logical navigation
Pages with a known parent section SHALL provide a visible link to that parent, and the link SHALL use a destination URL rather than browser history.

#### Scenario: Visitor opens an OpenSCAD model
- **WHEN** a visitor opens a generated or legacy OpenSCAD model page
- **THEN** the page provides a visible link back to the OpenSCAD section

#### Scenario: Visitor opens a source section
- **WHEN** a visitor opens the OpenSCAD or build123d section page
- **THEN** the page provides a visible link back to the site home page

#### Scenario: Visitor opens a page directly
- **WHEN** a visitor loads a deep link without prior site navigation
- **THEN** the contextual link still points to the correct logical parent

### Requirement: Site exposes author profile links
The shared site footer SHALL provide links to the author's Printables and Thingiverse profiles.

#### Scenario: Visitor views any page footer
- **WHEN** a visitor views the footer on any site page
- **THEN** the footer contains a link to `https://www.printables.com/@maxistar_3544573`
- **AND** the footer contains a link to `https://www.thingiverse.com/maxistar/designs`

#### Scenario: Visitor selects an external profile
- **WHEN** a visitor selects a Printables or Thingiverse link
- **THEN** the profile opens as an external destination without changing the current model page context

### Requirement: Pages expose meaningful metadata
The shared layout SHALL render a page-specific document title when a page supplies one and SHALL provide a sensible site title fallback otherwise.

#### Scenario: Visitor opens a named model page
- **WHEN** a model page supplies the title `Mi9 Pro`
- **THEN** the document title identifies the page as `Mi9 Pro | Maxistar 3D models`

#### Scenario: Page omits an optional title
- **WHEN** a page does not supply a page-specific title
- **THEN** the document still has a non-empty site title

### Requirement: Minimal shell remains accessible without JavaScript
The shared navigation SHALL use semantic HTML links and SHALL provide visible keyboard focus styling without requiring client-side JavaScript.

#### Scenario: Scripts are unavailable
- **WHEN** JavaScript is disabled or unavailable
- **THEN** the header, contextual links, footer links, and primary navigation remain usable

#### Scenario: Keyboard user moves focus
- **WHEN** a keyboard user focuses a navigation or profile link
- **THEN** the focused link has a visually distinguishable focus state

