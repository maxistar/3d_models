# ASCII STL Export Specification

## Purpose

Ensure generated STL artifacts are stored in ASCII format so mesh changes are reviewable in Git while preserving the existing documentation site viewer workflow.

## Requirements

### Requirement: Batch export produces ASCII STL artifacts
The batch export workflow SHALL generate `.stl` files in ASCII STL format when processing OpenSCAD source files.

#### Scenario: Rebuilding a changed OpenSCAD source
- **WHEN** the batch processing script rebuilds a `.scad` file because its outputs are missing, stale, or forced
- **THEN** the generated `.stl` file is encoded as ASCII STL text

#### Scenario: Preserving existing artifact paths
- **WHEN** a model is regenerated as ASCII STL
- **THEN** the output file keeps the existing `.stl` extension and path convention used by the repository and documentation site

### Requirement: ASCII STL choice is documented
The project documentation SHALL state that generated STL artifacts are exported in ASCII format for Git reviewability.

#### Scenario: Reading regeneration instructions
- **WHEN** a contributor reads the STL/PNG regeneration documentation
- **THEN** the documentation explains that STL output is intentionally ASCII-formatted to make mesh changes easier to inspect in Git

### Requirement: Website viewer supports regenerated artifacts
The documentation site SHALL continue to render regenerated ASCII STL files through the existing STL viewer flow.

#### Scenario: Rendering an ASCII STL model
- **WHEN** the documentation site loads a regenerated ASCII STL file referenced by an existing page
- **THEN** the STL viewer displays the model without requiring a URL, extension, or component API change
