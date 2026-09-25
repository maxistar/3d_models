"""
Honeycomb storage wall panel: 8x8 elements (build123d).

Usage:
    uv run python simple/honeycomb_wall_8x8.py
"""

from pathlib import Path
from build123d import *

# ── Parameters ────────────────────────────────────────────────────────────────

ROWS = 8
COLS = 8
CELL_RADIUS = 12.0      # mm, center -> vertex of hex
WALL = 1.8              # mm, hex wall thickness
DEPTH = 8.0             # mm, panel thickness (Z)

# ── Single hex ring element ───────────────────────────────────────────────────

with BuildPart() as cell_builder:
    with BuildSketch():
        RegularPolygon(radius=CELL_RADIUS, side_count=6)
        RegularPolygon(radius=CELL_RADIUS - WALL, side_count=6, mode=Mode.SUBTRACT)
    extrude(amount=DEPTH)

cell = cell_builder.part.solids()[0]

# ── Array placement (honeycomb lattice) ──────────────────────────────────────

x_step = (3**0.5) * CELL_RADIUS
y_step = 1.5 * CELL_RADIUS

panel = None
for row in range(ROWS):
    for col in range(COLS):
        x = col * x_step + (x_step / 2 if row % 2 else 0)
        y = row * y_step
        placed = cell.translate((x, y, 0))
        panel = placed if panel is None else panel.fuse(placed)

# ── Export ────────────────────────────────────────────────────────────────────

out = Path(__file__).parent / "honeycomb_wall_8x8.stl"
export_stl(panel, str(out))
print(f"✅  Exported {out}")
