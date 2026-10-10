## MODIFIED Requirements

### Requirement: Batch export produces ASCII STL artifacts
The batch export workflow SHALL generate `.stl` files in ASCII STL format when processing eligible `.scad` source files. Service sources whose basenames start with `_` and sources listed in `.modelignore` SHALL be skipped rather than treated as missing or failed model outputs.

#### Scenario: Rebuilding a changed OpenSCAD source
- **WHEN** the batch processing script rebuilds an eligible `.scad` file because its outputs are missing, stale, or forced
- **THEN** the generated `.stl` file is encoded as ASCII STL text

#### Scenario: Preserving existing artifact paths
- **WHEN** an eligible model is regenerated as ASCII STL
- **THEN** the output file keeps the existing `.stl` extension and path convention used by the repository and documentation site

#### Scenario: Skipping a service source
- **WHEN** the batch processing script encounters a `.scad` file whose basename starts with `_`
- **THEN** it skips the file without invoking OpenSCAD and without reporting a missing STL as a build failure

#### Scenario: Skipping a blacklisted source
- **WHEN** the batch processing script encounters a source path listed in `.modelignore`
- **THEN** it skips the file without invoking OpenSCAD and without reporting a missing STL as a build failure
