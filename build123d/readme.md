# build123d model
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

## Running a model

Each script generates an STL file next to itself when run:

```bash
uv run python simple/mug.py
```

## Models

| File | Description |
|---|---|
| `simple/mug.py` | Parametric mug with handle — adjust `HEIGHT`, `OUTER_R`, `WALL` at the top of the file |
