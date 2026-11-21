## ADDED Requirements

### Requirement: Local build123d site assets contain only STL model outputs
The local site setup SHALL stage generated build123d STL files under `docs/public/build123d/simple/` without exposing the build123d project directory or its Python virtual environment through the static public directory.

#### Scenario: Build123d virtual environment exists locally
- **WHEN** a developer stages build123d assets and runs the documentation site build
- **THEN** the public build123d asset directory contains the model STL files without traversing `.venv` or requiring its Python interpreter links to resolve

#### Scenario: Existing model page requests a build123d STL
- **WHEN** an existing page requests `/3d_models/build123d/simple/<model>.stl`
- **THEN** the same generated STL remains available at that public URL
