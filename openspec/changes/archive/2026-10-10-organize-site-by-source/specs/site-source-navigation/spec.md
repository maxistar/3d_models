## ADDED Requirements

### Requirement: Site exposes source-family sections
The documentation site SHALL expose separate top-level navigation entries for OpenSCAD and build123d models.

#### Scenario: Visitor opens the home page
- **WHEN** a visitor opens the documentation site home page
- **THEN** the page provides a link to the OpenSCAD section and a link to the build123d section

#### Scenario: Visitor opens the OpenSCAD section
- **WHEN** a visitor navigates to `/3d_models/openscad/`
- **THEN** the site displays an index of the available OpenSCAD model collections

#### Scenario: Visitor opens the build123d section
- **WHEN** a visitor navigates to `/3d_models/build123d/`
- **THEN** the site displays an index of the available build123d models or model pages

### Requirement: Section indexes link to existing model pages
The OpenSCAD and build123d section indexes SHALL link to the existing pages selected for their respective source family.

#### Scenario: Visitor selects an OpenSCAD collection
- **WHEN** a visitor selects an OpenSCAD collection from the section index
- **THEN** the site opens the corresponding existing collection page and its STL viewer remains available

#### Scenario: Visitor selects a build123d model
- **WHEN** a visitor selects a build123d model from the section index
- **THEN** the site opens the corresponding existing build123d gallery or single-model page

### Requirement: Existing model URLs remain compatible
The navigation change MUST preserve existing model page URLs and published STL asset paths.

#### Scenario: Visitor uses an existing collection URL
- **WHEN** a visitor opens an existing collection URL such as `/3d_models/blocknote` or `/3d_models/honeycomb`
- **THEN** the existing page continues to render without requiring a redirect

#### Scenario: Viewer loads an existing STL asset
- **WHEN** an existing model page requests an STL under `/3d_models/openscad/` or `/3d_models/build123d/`
- **THEN** the asset remains available at the same URL and the current viewer flow can load it

### Requirement: Navigation change does not alter model selection semantics
The first source-navigation step SHALL keep model selection explicit and SHALL NOT automatically expose every STL file in the repository.

#### Scenario: Repository contains auxiliary STL files
- **WHEN** the repository contains STL variants or helper parts that are not listed by a section index
- **THEN** those files are not automatically added to the public navigation
