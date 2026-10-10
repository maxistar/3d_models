## ADDED Requirements

### Requirement: Model source names define default project groups
The repository SHALL use a shared meaningful filename prefix as the default way to identify source files that belong to one model project or page.

#### Scenario: Source files share a project prefix
- **WHEN** multiple model source files in one source family share a meaningful prefix
- **THEN** they are treated as members of one default project group

#### Scenario: A source family has one model file
- **WHEN** a source family contains only one eligible model source file
- **THEN** that source is treated as a standalone project group

### Requirement: Project-level grouping exceptions are explicit
The model catalog SHALL support an explicit project grouping exception when filenames do not share the default prefix but belong to one intentional project.

#### Scenario: Honeycomb component names use different prefixes
- **WHEN** files under the honeycomb project use component prefixes such as `panel`, `plug`, or `perimeter`
- **THEN** they remain members of the single `honeycomb` project group

### Requirement: Service sources are marked by a leading underscore
Any source file whose basename starts with `_` SHALL be treated as a service source and SHALL NOT be considered an automatically publishable model.

#### Scenario: Service OpenSCAD library is discovered
- **WHEN** the model scan encounters `_honeycomb_element.scad`
- **THEN** it excludes the file from model groups and from automatic STL generation

### Requirement: Explicit model exclusions are path-based
The repository SHALL provide a documented blacklist based on paths relative to the repository root for sources that must not participate in automatic generation or publication.

#### Scenario: Incompatible external model is blacklisted
- **WHEN** the model scan encounters a path listed in `.modelignore`, such as `openscad/rugged_box/RuggedBoxV1.scad`
- **THEN** it excludes that source from automatic generation, validation, and future model-page discovery

#### Scenario: Same basename exists in multiple locations
- **WHEN** two source files have the same basename but only one relative path is listed in `.modelignore`
- **THEN** only the listed path is excluded
