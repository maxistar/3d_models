## MODIFIED Requirements

### Requirement: Site provides contextual logical navigation
Pages with a known parent section SHALL provide visible links to their logical parents, and OpenSCAD directory and model pages SHALL expose the source hierarchy through breadcrumbs or equivalent contextual navigation. Links SHALL use destination URLs rather than browser history.

#### Scenario: Visitor opens an OpenSCAD model
- **WHEN** a visitor opens a generated or legacy OpenSCAD model page
- **THEN** the page provides a visible link to the OpenSCAD section and identifies its source directory before the model group

#### Scenario: Visitor opens an OpenSCAD directory
- **WHEN** a visitor opens an OpenSCAD directory page
- **THEN** the page provides a visible link back to the OpenSCAD section and links to the model groups in that directory

#### Scenario: Visitor opens a source section
- **WHEN** a visitor opens the OpenSCAD or build123d section page
- **THEN** the page provides a visible link back to the site home page

#### Scenario: Visitor opens a page directly
- **WHEN** a visitor loads a deep link without prior site navigation
- **THEN** the contextual links still point to the correct logical parents in the source hierarchy

### Requirement: Site preserves compatibility for existing OpenSCAD links
The site SHALL keep existing flat and legacy OpenSCAD model URLs usable after directory-aware routes are introduced, and SHALL identify the nested directory-aware URL as the canonical destination when a distinct canonical route exists.

#### Scenario: Visitor opens an existing flat model URL
- **WHEN** a visitor opens an existing route such as `/3d_models/openscad/mi9-pro`
- **THEN** the site serves the model or redirects it to the corresponding directory-aware page without a broken link

#### Scenario: Visitor follows a legacy model link
- **WHEN** a visitor opens an existing legacy model route such as `/3d_models/blocknote`
- **THEN** the route remains usable and exposes the directory-aware page as its canonical destination

#### Scenario: Visitor opens a directory-aware model URL
- **WHEN** a visitor opens `/3d_models/openscad/phones/mi9-pro`
- **THEN** the page renders the same model items and STL downloads as the corresponding legacy page

## ADDED Requirements

### Requirement: Site reflects public source directories in OpenSCAD navigation
The OpenSCAD landing page SHALL list discovered source directories as the first navigation level, and each directory page SHALL list the groups discovered below that directory.

#### Scenario: Visitor opens the OpenSCAD section
- **WHEN** a visitor opens `/3d_models/openscad/`
- **THEN** the page shows the public source directories rather than one flat list of all model groups

#### Scenario: Visitor selects a source directory
- **WHEN** a visitor selects a directory such as `phones` or `random`
- **THEN** the browser opens the corresponding directory-aware page

#### Scenario: Visitor selects a model group
- **WHEN** a visitor selects a group from a directory page
- **THEN** the browser opens a nested model page whose URL includes the source directory path

#### Scenario: Source directory is excluded from the catalog
- **WHEN** a directory contains only excluded or incomplete sources
- **THEN** the directory does not appear in OpenSCAD navigation

