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
uv run python simple/cable_winder.py
```

## Models

| File | Description |
|---|---|
| `simple/mug.py` | Parametric mug with handle — adjust `HEIGHT`, `OUTER_R`, `WALL` at the top of the file |
| `simple/gridfinity_1x1.py` | Simple Gridfinity 1x1 bin (1U) |
| `simple/honeycomb_wall_8x8.py` | Honeycomb storage wall panel, 8x8 elements |
| `simple/cable_winder.py` | Parametric cable-winder spool with toroidal wire channel |

## Create a static PNG preview from STL

If you want a quick image preview (for chat/docs), you can render STL to PNG with `matplotlib` + `numpy-stl`.

1) Create a temporary venv and install render dependencies:

```bash
python3 -m venv /tmp/stlimg
/tmp/stlimg/bin/pip install matplotlib numpy-stl
```

2) Render an STL to PNG (example for cylinder):

```bash
/tmp/stlimg/bin/python - <<'PY'
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
from stl import mesh

stl_path = 'simple/cylinder_r20_h5.stl'
out_path = 'simple/cylinder_r20_h5.png'

m = mesh.Mesh.from_file(stl_path)
fig = plt.figure(figsize=(6,6), dpi=180)
ax = fig.add_subplot(111, projection='3d')

poly = Poly3DCollection(m.vectors, alpha=1.0)
poly.set_facecolor('#f4ab22')
poly.set_edgecolor('#333333')
poly.set_linewidth(0.08)
ax.add_collection3d(poly)

scale = m.points.flatten()
ax.auto_scale_xyz(scale, scale, scale)
ax.set_box_aspect((1, 1, 0.3))
ax.view_init(elev=28, azim=35)
ax.axis('off')

plt.tight_layout(pad=0)
plt.savefig(out_path, bbox_inches='tight', pad_inches=0.02)
print(f'✅ Exported {out_path}')
PY
```
