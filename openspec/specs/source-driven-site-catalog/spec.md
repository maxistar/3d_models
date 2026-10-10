# source-driven-site-catalog Specification

## Purpose
TBD - created by archiving change generate-site-from-openscad-sources. Update Purpose after archive.
## Requirements
### Requirement: Catalog discovers eligible OpenSCAD model sources
The site catalog generator SHALL recursively inspect the `openscad` tree and SHALL include only `.scad` files that do not start with `_`, are not excluded by `.modelignore`, and have a same-name `.stl` beside them.

#### Scenario: Eligible source has a committed STL
- **WHEN** `openscad/phones/mi9_pro_case.scad` and `openscad/phones/mi9_pro_case.stl` both exist and the source is not excluded
- **THEN** the catalog contains that source as a model item

#### Scenario: Internal source is present
- **WHEN** a `.scad` file begins with `_`
- **THEN** the catalog excludes it even when a same-name STL exists

#### Scenario: Source is blacklisted
- **WHEN** a `.scad` path is listed in `.modelignore`
- **THEN** the catalog excludes it and does not create a public model item for it

#### Scenario: Source has no generated STL
- **WHEN** an eligible `.scad` file has no same-name `.stl`
- **THEN** the catalog excludes it and reports the missing output without invoking OpenSCAD

### Requirement: Catalog does not promote orphan STL files
The site catalog SHALL derive public model items from eligible source files rather than discovering pages from STL files alone.

#### Scenario: STL has no matching source
- **WHEN** an STL file exists without an eligible same-name `.scad`
- **THEN** the STL is not added to the public model catalog

#### Scenario: Imported STL is used by a source
- **WHEN** a source imports an STL dependency that has no same-name source
- **THEN** the dependency remains available as an asset but does not become a standalone catalog item

### Requirement: Catalog groups model items into stable pages
The generator SHALL group eligible sources within their project directory by the established filename-family convention, SHALL create singleton groups for files without a family, and SHALL group all eligible sources in `openscad/honeycomb` into one `honeycomb` project.

#### Scenario: Root source has suffixed parts
- **WHEN** a directory contains `mi9_pro.scad`, `mi9_pro_case.scad`, and `mi9_pro_cover.scad`
- **THEN** those sources appear in one stable `mi9_pro` group

#### Scenario: Project contains unrelated families
- **WHEN** a directory contains multiple meaningful filename families
- **THEN** each family is represented as its own group unless an explicit project override combines them

#### Scenario: Directory is the honeycomb exception
- **WHEN** an eligible source is located in `openscad/honeycomb`
- **THEN** it appears in the single `honeycomb` project group regardless of its individual prefix

#### Scenario: Source is a singleton
- **WHEN** a source has no matching family members in its project directory
- **THEN** it receives a group/page of its own

#### Scenario: Group slug would collide
- **WHEN** two discovered groups would generate the same public slug
- **THEN** catalog generation fails with a diagnostic identifying both groups

### Requirement: Catalog-backed pages provide preview and download access
Each generated model page SHALL render the catalog items with an STL preview and a direct link to download the corresponding STL asset.

#### Scenario: Visitor opens a generated group page
- **WHEN** a visitor opens a generated OpenSCAD group page
- **THEN** the page renders a preview for each catalog item in that group

#### Scenario: Visitor downloads a model
- **WHEN** a visitor selects an item's download link
- **THEN** the browser receives the same committed STL asset used by the preview

### Requirement: Site build regenerates the derived catalog
The docs build SHALL run catalog generation before Astro static generation, and catalog generation SHALL not invoke OpenSCAD or any geometry compiler.

#### Scenario: CI builds documentation
- **WHEN** the deployment workflow runs `npm run build`
- **THEN** the catalog is generated from checked-out sources and committed STL files before Astro builds the site

#### Scenario: New source/output pair is added
- **WHEN** a new eligible `.scad`/`.stl` pair is committed and the site is rebuilt
- **THEN** the corresponding group or singleton appears in the generated OpenSCAD navigation and pages without a handwritten Astro page change

#### Scenario: Model output is missing
- **WHEN** a new `.scad` source is committed without its STL output
- **THEN** the site build does not invoke OpenSCAD and reports the source as excluded from the catalog

### Requirement: Catalog generation is deterministic and inspectable
The generator SHALL order groups and items deterministically and SHALL report discovered, excluded, and missing sources in a human-readable summary.

#### Scenario: Same repository is built twice
- **WHEN** catalog generation runs twice without source changes
- **THEN** it produces the same group order, item order, slugs, and asset paths

#### Scenario: Generation completes
- **WHEN** the generator finishes
- **THEN** its summary identifies included model items and the reasons excluded sources were not published

