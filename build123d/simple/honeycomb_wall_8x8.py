"""
Honeycomb storage wall panel: 8x8 elements (build123d).

Usage:
    uv run python simple/honeycomb_wall_8x8.py
"""

from pathlib import Path
from math import sqrt
from build123d import *

# ── Parameters ────────────────────────────────────────────────────────────────

ROWS = 8
COLS = 8
OUTER_APOTHEM = 11.8    # mm, OpenSCAD h_outer
INNER_APOTHEM = 10.0    # mm, OpenSCAD h_inner
DEPTH = 8.0             # mm, OpenSCAD total_height

OUTER_RADIUS = 2 * OUTER_APOTHEM / sqrt(3)
INNER_RADIUS = 2 * INNER_APOTHEM / sqrt(3)
BOTTOM_INNER_RADIUS = INNER_RADIUS + 0.5
TOP_INNER_RADIUS = INNER_RADIUS + 1.0

# ── Single hex ring element ───────────────────────────────────────────────────

with BuildPart() as outer_cell:
    with BuildSketch(Plane.XY):
        RegularPolygon(radius=OUTER_RADIUS, side_count=6, rotation=0)
    extrude(amount=DEPTH)

with BuildPart() as inner_cavity:
    # These sections reproduce basic_polygon() in _honeycomb_element.scad.
    for z, radius in (
        (-0.01, BOTTOM_INNER_RADIUS),
        (0.0, BOTTOM_INNER_RADIUS),
        (0.5, INNER_RADIUS),
        (DEPTH - 3.0, INNER_RADIUS),
        (DEPTH - 2.0, TOP_INNER_RADIUS),
        (DEPTH, TOP_INNER_RADIUS),
        (DEPTH + 0.01, TOP_INNER_RADIUS),
    ):
        with BuildSketch(Plane.XY.offset(z)):
            RegularPolygon(radius=radius, side_count=6, rotation=0)
    loft(ruled=True)

cell = outer_cell.part.cut(inner_cavity.part)

# ── Array placement (honeycomb lattice) ──────────────────────────────────────

x_step = 1.5 * OUTER_RADIUS
y_step = sqrt(3) * OUTER_RADIUS

panel = None
for col in range(COLS):
    for row in range(ROWS):
        x = col * x_step
        y = row * y_step + (y_step / 2 if col % 2 == 0 else 0)
        placed = cell.translate((x, y, 0))
        panel = placed if panel is None else panel.fuse(placed)

# ── Export ────────────────────────────────────────────────────────────────────

out = Path(__file__).parent / "honeycomb_wall_8x8.stl"
export_stl(panel, str(out), ascii_format=True)
print(f"✅  Exported {out}")
