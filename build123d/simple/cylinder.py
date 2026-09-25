"""
Simple parametric cylinder.

Usage:
    uv run python simple/cylinder.py
"""

from pathlib import Path
from build123d import BuildPart, Cylinder, Part, export_stl

RADIUS = 20.0  # mm
HEIGHT = 5.0   # mm


def make_cylinder(radius: float = RADIUS, height: float = HEIGHT) -> Part:
    with BuildPart() as model:
        Cylinder(radius=radius, height=height)
    return model.part


if __name__ == "__main__":
    cylinder = make_cylinder()
    out = Path(__file__).parent / "cylinder_r20_h5.stl"
    export_stl(cylinder, str(out))
    print(f"✅ Exported {out}")
