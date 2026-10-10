## MODIFIED Requirements

### Requirement: Catalog groups model items into stable pages
The generator SHALL group eligible sources within their relative source directory by the established filename-family convention, SHALL create singleton groups for files without a family, SHALL expose the normalized relative directory path for every group, and SHALL group all eligible sources in `openscad/honeycomb` into one `honeycomb` project group.

#### Scenario: Root source has suffixed parts
- **WHEN** a directory contains `mi9_pro.scad`, `mi9_pro_case.scad`, and `mi9_pro_cover.scad`
- **THEN** those sources appear in one stable `mi9_pro` group with the directory path `phones`

#### Scenario: Project contains unrelated families
- **WHEN** a directory contains multiple meaningful filename families
- **THEN** each family is represented as its own group unless an explicit project override combines them

#### Scenario: Directory is the honeycomb exception
- **WHEN** an eligible source is located in `openscad/honeycomb`
- **THEN** it appears in the single `honeycomb` project group regardless of its individual prefix, and the group retains the directory path `honeycomb`

#### Scenario: Source is a singleton
- **WHEN** a source has no matching family members in its project directory
- **THEN** it receives a group/page of its own while retaining its source directory path

#### Scenario: Nested source directory is present
- **WHEN** an eligible source is located below a nested relative directory such as `openscad/phones/xiaomi`
- **THEN** the catalog retains the complete normalized path `phones/xiaomi` rather than only the leaf directory name

#### Scenario: Group slug would collide
- **WHEN** two discovered groups would generate the same public slug within their directory route
- **THEN** catalog generation fails with a diagnostic identifying both groups

### Requirement: Catalog generation is deterministic and inspectable
The generator SHALL order directory entries, groups, and items deterministically, SHALL expose directory paths in the derived catalog, and SHALL report discovered, excluded, and missing sources in a human-readable summary.

#### Scenario: Same repository is built twice
- **WHEN** catalog generation runs twice without source changes
- **THEN** it produces the same directory order, group order, item order, slugs, and asset paths

#### Scenario: Generation completes
- **WHEN** the generator finishes
- **THEN** its summary identifies included model items, source directories, and the reasons excluded sources were not published

## ADDED Requirements

### Requirement: Catalog exposes directory navigation data
The derived catalog SHALL provide enough information for the site generator to render directory landing pages and nested group links without rescanning the source tree during Astro page generation.

#### Scenario: Directory contains several groups
- **WHEN** a source directory contains multiple discovered groups
- **THEN** the catalog exposes one directory entry containing those groups in deterministic order

#### Scenario: Directory contains one group
- **WHEN** a source directory contains one discovered group
- **THEN** the catalog still exposes that directory entry so the source hierarchy remains visible

#### Scenario: Directory has no eligible sources
- **WHEN** every source in a directory is internal, blacklisted, or missing its same-name STL
- **THEN** the directory is absent from public navigation

