"""
Parametric cable winder spool (build123d).

Usage:
    uv run python simple/cable_winder.py
"""

from dataclasses import dataclass
from pathlib import Path

from build123d import *


@dataclass
class CableWinderParams:
    inner_diameter: float = 29
    outer_diameter: float = 33
    spool_height: float = 16
    max_diameter: float = 35
    angle_height: float = 2
    border_height: float = 1

    wire_diameter: float = 3
    wire_offset: float = 0.25
    wire_vertical_offset: float = 3

    # kept for future full body version
    body_diameter: float = 60
    body_sphere_scale: float = 0.7
    body_thickness: float = 2
    body_offset: float = 0.3
    body_inset: float = 2
    extra_ring_width: float = 1
    extra_ring_height: float = 2


def make_wire_channel(diameter: float, spool_diameter: float) -> Part:
    """Wire channel primitive: torus around spool axis."""
    with BuildPart() as channel:
        Torus(major_radius=spool_diameter / 2, minor_radius=diameter / 2)
    return channel.part


def make_spool(
    inner_diameter: float = 29,
    outer_diameter: float = 33,
    spool_height: float = 16,
    max_diameter: float = 35,
    angle_height: float = 2,
    border_height: float = 1,
    wire_diameter: float = 3,
    wire_offset: float = 0.25,
    wire_vertical_offset: float = 3,
) -> Part:
    channel_width = outer_diameter - inner_diameter

    # === spoolSolid() ===
    with BuildPart() as spool_solid:
        Cylinder(radius=outer_diameter / 2, height=spool_height)

        with Locations((0, 0, spool_height / 2 - border_height - angle_height / 2)):
            Cone(
                bottom_radius=max_diameter / 2,
                top_radius=outer_diameter / 2,
                height=angle_height,
                rotation=(180, 0, 0),
            )

        with Locations((0, 0, spool_height / 2 - border_height / 2)):
            Cylinder(radius=max_diameter / 2, height=border_height)

        with Locations((0, 0, -spool_height / 2 + border_height + angle_height / 2)):
            Cone(
                bottom_radius=outer_diameter / 2,
                top_radius=max_diameter / 2,
                height=angle_height,
            )

        with Locations((0, 0, -spool_height / 2 + border_height / 2)):
            Cylinder(radius=max_diameter / 2, height=border_height)

    # === difference(spoolSolid, inner cylinder) ===
    with BuildPart() as spool_outline:
        add(spool_solid.part)
        with BuildPart(mode=Mode.SUBTRACT):
            Cylinder(radius=inner_diameter / 2, height=spool_height * 2)

    # === intersection(cylinder, translated wireChannel(...)) ===
    outer_channel_shape = make_wire_channel(
        diameter=wire_diameter + wire_offset + channel_width,
        spool_diameter=outer_diameter - (wire_diameter + wire_offset),
    )

    with BuildPart() as outer_channel_intersection:
        with BuildPart() as outer_cyl:
            Cylinder(radius=outer_diameter / 2, height=spool_height)
        add(outer_cyl.part)
        add(Pos(0, 0, -wire_vertical_offset) * outer_channel_shape, mode=Mode.INTERSECT)

    # === union(...) then subtract inner wireChannel(...) ===
    inner_channel_shape = make_wire_channel(
        diameter=wire_diameter + wire_offset,
        spool_diameter=outer_diameter,
    )

    with BuildPart() as final_spool:
        add(spool_outline.part)
        add(outer_channel_intersection.part)
        with BuildPart(mode=Mode.SUBTRACT):
            add(Pos(0, 0, -wire_vertical_offset) * inner_channel_shape)

    return final_spool.part


def make_cable_winder(params: CableWinderParams) -> Part:
    return make_spool(
        inner_diameter=params.inner_diameter,
        outer_diameter=params.outer_diameter,
        spool_height=params.spool_height,
        max_diameter=params.max_diameter,
        angle_height=params.angle_height,
        border_height=params.border_height,
        wire_diameter=params.wire_diameter,
        wire_offset=params.wire_offset,
        wire_vertical_offset=params.wire_vertical_offset,
    )


if __name__ == "__main__":
    params = CableWinderParams()
    model = make_cable_winder(params)

    out = Path(__file__).parent / "cable_winder.stl"
    export_stl(model, str(out))
    print(f"✅  Exported {out}")
