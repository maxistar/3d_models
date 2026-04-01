# build123d models

Parametric 3D models built programmatically with [build123d](https://build123d.readthedocs.io/).

Unlike OpenSCAD, build123d works with real BREP geometry — enabling proper fillets,
chamfers, shell operations and STEP export.

## Setup

```bash
# Install uv if you don't have it
curl -Lsf https://astral.sh/uv/install.sh | sh

# Install dependencies
uv sync
```

## Running models manually

Each script generates an STL file next to itself when run.

General form:

```bash
uv run python simple/<model_name>.py
```

Examples:

```bash
uv run python simple/mug.py
uv run python simple/gridfinity_1x1.py
uv run python simple/honeycomb_wall_8x8.py
```

## Models

| File | Description |
|---|---|
| `simple/mug.py` | Parametric mug with handle — adjust `HEIGHT`, `OUTER_R`, `WALL` at the top of the file |
| `simple/gridfinity_1x1.py` | Simple Gridfinity 1x1 bin (1U) |
| `simple/honeycomb_wall_8x8.py` | Honeycomb storage wall panel, 8x8 elements |
