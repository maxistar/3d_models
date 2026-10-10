## MODIFIED Requirements

### Requirement: Section indexes link to existing model pages
The OpenSCAD and build123d section indexes SHALL link to the model pages selected for their respective source family. OpenSCAD membership and links SHALL be derived from the source-driven catalog; build123d membership MAY remain explicitly curated until build123d discovery is introduced.

#### Scenario: Visitor selects an OpenSCAD collection
- **WHEN** a visitor selects an OpenSCAD collection from the section index
- **THEN** the site opens the catalog-backed canonical collection page and its STL previews and download links remain available

#### Scenario: A new OpenSCAD group is discovered
- **WHEN** the catalog contains a new eligible OpenSCAD group
- **THEN** the OpenSCAD section index links to that group without a manual index edit

#### Scenario: Visitor selects a build123d model
- **WHEN** a visitor selects a build123d model from the section index
- **THEN** the site opens the corresponding existing build123d gallery or single-model page

### Requirement: Existing model URLs remain compatible
The source-driven navigation change MUST preserve existing OpenSCAD model page URLs and published STL asset paths for currently published collections.

#### Scenario: Visitor uses an existing collection URL
- **WHEN** a visitor opens an existing collection URL such as `/3d_models/blocknote` or `/3d_models/honeycomb`
- **THEN** the compatibility page renders catalog-backed model data without requiring a redirect

#### Scenario: Viewer loads an existing STL asset
- **WHEN** an existing model page requests an STL under `/3d_models/openscad/` or `/3d_models/build123d/`
- **THEN** the asset remains available at the same URL and the viewer and download flow can load it

### Requirement: Navigation change does not alter model selection semantics
The OpenSCAD section SHALL expose eligible source/STL groups from the catalog and SHALL NOT automatically expose every STL file in the repository.

#### Scenario: Repository contains auxiliary STL files
- **WHEN** the repository contains STL variants, imported dependencies, or helper parts without eligible source entries
- **THEN** those files are not added to the public OpenSCAD navigation

#### Scenario: Repository contains a blacklisted source
- **WHEN** a source is listed in `.modelignore`
- **THEN** it is absent from the OpenSCAD section index and generated model pages
