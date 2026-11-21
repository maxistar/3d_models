"""Parametric iPhone 13 case, ported from the active OpenSCAD phone_case().

Run from the repository root with::

    cd build123d && uv run python phones/iphone_13_case.py

The case uses X for width, Y for phone length, and Z for thickness, matching
the OpenSCAD source. Separate covers and magnetic print-layout parts are not
included.
"""

from dataclasses import dataclass
from pathlib import Path

from build123d import *


@dataclass(frozen=True)
class IPhone13CaseParams:
    """Nominal phone, shell, and control dimensions in millimeters."""

    phone_width: float = 71.05
    phone_length: float = 146.5
    phone_thickness: float = 8.7
    phone_corner_radius: float = 12.0

    # The OpenSCAD case adds 1.5 mm to each side and a 1 mm rear wall.
    wall_thickness: float = 1.5
    back_wall: float = 1.0
    fit_clearance: float = 0.2
    outer_edge_radius: float = 1.5
    front_lip_height: float = 1.0
    # The cavity has 0.2 mm per-side fit clearance; a further 0.2 mm per-side
    # interference at the mouth matches the OpenSCAD opening profile.
    front_opening_inset: float = 0.4

    # Camera island: the source forms one rounded rectangular relief from four
    # camera-sized cylinders.
    camera_diameter: float = 18.34
    camera_cluster_width: float = 30.0
    camera_cluster_length: float = 30.0
    camera_top_offset: float = 3.0
    camera_side_offset: float = 3.0

    # Center positions are measured from the phone's top edge in the source.
    power_button_length: float = 19.0
    power_button_top_offset: float = 43.5
    volume_up_button_length: float = 11.0
    volume_up_button_top_offset: float = 40.0
    volume_down_button_length: float = 11.0
    volume_down_button_top_offset: float = 55.0
    buttons_radius: float = 1.0
    button_recess_radius: float = 3.0
    button_pad_radius: float = 2.4
    button_pad_thickness: float = 2.0
    button_pad_projection: float = 1.0

    silent_switch_length: float = 7.0
    silent_switch_top_offset: float = 29.5
    silent_switch_outer_extra: float = 0.5
    silent_switch_inner_taper: float = 1.0
    silent_switch_inner_wall_clearance: float = 0.05

    socket_depth: float = 10.0
    usb_center_spacing: float = 6.0
    usb_radius: float = 3.0
    speaker_center_spacing: float = 12.0
    speaker_radius: float = 1.5
    speaker_x_offset: float = 18.0
    bottom_socket_center_offset: float = 5.0

    @property
    def half_width(self) -> float:
        return self.phone_width / 2

    @property
    def half_length(self) -> float:
        return self.phone_length / 2

    @property
    def camera_radius(self) -> float:
        return self.camera_diameter / 2

    @property
    def camera_center_spacing_x(self) -> float:
        return self.camera_cluster_width - self.camera_diameter

    @property
    def camera_center_spacing_y(self) -> float:
        return self.camera_cluster_length - self.camera_diameter

    def button_y(self, button_length: float, top_offset: float) -> float:
        return (
            self.half_length
            - button_length / 2
            - top_offset
            + self.buttons_radius
        )


def make_rounded_prism(
    width: float,
    length: float,
    corner_radius: float,
    z_bottom: float,
    height: float,
    edge_radius: float = 0.0,
) -> Part:
    """Extrude a rounded rectangle and optionally round its top/bottom rim."""
    with BuildPart() as prism:
        with BuildSketch(Plane.XY.offset(z_bottom)):
            RectangleRounded(width, length, corner_radius)
        extrude(amount=height)

    part = prism.part
    if edge_radius > 0:
        z_faces = part.faces().filter_by(Axis.Z).sort_by(Axis.Z)
        perimeter_edges = list(z_faces[0].edges()) + list(z_faces[-1].edges())
        part = part.fillet(edge_radius, perimeter_edges)
    return part


def make_bottom_slot(
    x_center: float,
    y_center: float,
    center_z: float,
    center_spacing: float,
    radius: float,
    depth: float,
) -> Part:
    """Capsule cut oriented through the phone's bottom edge along Y."""
    middle = Pos(x_center, y_center, center_z) * Box(
        center_spacing, depth, radius * 2
    )
    left_cap = (
        Pos(x_center - center_spacing / 2, y_center, center_z)
        * Rot(90, 0, 0)
        * Cylinder(radius, depth)
    )
    right_cap = (
        Pos(x_center + center_spacing / 2, y_center, center_z)
        * Rot(90, 0, 0)
        * Cylinder(radius, depth)
    )
    return middle.fuse(left_cap, right_cap)


def make_yz_capsule(
    x_start: float,
    y_center: float,
    length: float,
    width: float,
    depth: float,
    x_direction: float,
) -> Part:
    """Create a capsule in the Y/Z plane, extruded along X."""
    radius = width / 2
    end_center_spacing = length - width
    x_center = x_start + x_direction * depth / 2

    middle = Pos(x_center, y_center, 0) * Box(depth, end_center_spacing, width)
    negative_y_cap = (
        Pos(x_center, y_center - end_center_spacing / 2, 0)
        * Rot(0, 90, 0)
        * Cylinder(radius, depth)
    )
    positive_y_cap = (
        Pos(x_center, y_center + end_center_spacing / 2, 0)
        * Rot(0, 90, 0)
        * Cylinder(radius, depth)
    )
    return middle.fuse(negative_y_cap, positive_y_cap)


def make_sliced_spherical_capsule(
    profile_center_x: float,
    slice_center_x: float,
    y_center: float,
    length: float,
    radius: float,
    slice_thickness: float,
) -> Part:
    """Make a button pad from a rounded capsule sliced to the case wall width."""
    end_center_spacing = length - 2 * radius
    middle = (
        Pos(profile_center_x, y_center, 0)
        * Rot(90, 0, 0)
        * Cylinder(radius, end_center_spacing)
    )
    negative_y_cap = Pos(
        profile_center_x,
        y_center - end_center_spacing / 2,
        0,
    ) * Sphere(radius)
    positive_y_cap = Pos(
        profile_center_x,
        y_center + end_center_spacing / 2,
        0,
    ) * Sphere(radius)
    capsule = middle.fuse(negative_y_cap, positive_y_cap)
    slice_box = Pos(slice_center_x, y_center, 0) * Box(
        slice_thickness,
        length + 2 * radius + 2.0,
        2 * radius + 2.0,
    )
    return capsule.intersect(slice_box)


def make_silent_switch_cutter(params: IPhone13CaseParams) -> Part:
    """Loft the switch opening from its wider exterior to narrower interior."""
    outer_length = params.silent_switch_length + params.silent_switch_outer_extra
    outer_width = 2 * (params.buttons_radius + 1.0) + params.silent_switch_outer_extra
    inner_length = outer_length - params.silent_switch_inner_taper
    inner_width = outer_width - params.silent_switch_inner_taper
    switch_y = params.button_y(
        params.silent_switch_length,
        params.silent_switch_top_offset,
    )

    outer_x = -params.half_width - params.wall_thickness - 0.05
    inner_x = (
        -params.half_width
        + params.fit_clearance
        + params.silent_switch_inner_wall_clearance
    )
    outer_plane = Plane(
        origin=(outer_x, switch_y, 0),
        x_dir=(0, 1, 0),
        z_dir=(1, 0, 0),
    )
    inner_plane = Plane(
        origin=(inner_x, switch_y, 0),
        x_dir=(0, 1, 0),
        z_dir=(1, 0, 0),
    )

    with BuildPart() as cutter:
        with BuildSketch(outer_plane):
            Rectangle(outer_length, outer_width)
        with BuildSketch(inner_plane):
            Rectangle(inner_length, inner_width)
        loft()
    return cutter.part


def make_front_lip_cutter(
    cavity_width: float,
    cavity_length: float,
    cavity_corner_radius: float,
    opening_inset: float,
    transition_z: float,
    outer_top_z: float,
) -> Part:
    """Create the tapered opening through the retaining lip at the case mouth."""
    opening_width = cavity_width - 2 * opening_inset
    opening_length = cavity_length - 2 * opening_inset
    opening_corner_radius = cavity_corner_radius - opening_inset

    with BuildPart() as lip_cutter:
        with BuildSketch(Plane.XY.offset(transition_z)):
            RectangleRounded(cavity_width, cavity_length, cavity_corner_radius)
        with BuildSketch(Plane.XY.offset(outer_top_z)):
            RectangleRounded(opening_width, opening_length, opening_corner_radius)
        loft()

        with BuildSketch(Plane.XY.offset(outer_top_z)):
            RectangleRounded(opening_width, opening_length, opening_corner_radius)
        extrude(amount=1.0)

    return lip_cutter.part


def make_phone_case(params: IPhone13CaseParams = IPhone13CaseParams()) -> Part:
    """Construct the phone case and raised power/volume button pads."""
    outer_width = params.phone_width + 2 * params.wall_thickness
    outer_length = params.phone_length + 2 * params.wall_thickness
    outer_z_bottom = -(params.phone_thickness / 2 + params.back_wall)
    outer_height = params.phone_thickness + 2 * params.back_wall

    outer_case = make_rounded_prism(
        width=outer_width,
        length=outer_length,
        corner_radius=params.phone_corner_radius + params.wall_thickness,
        z_bottom=outer_z_bottom,
        height=outer_height,
        edge_radius=params.outer_edge_radius,
    )

    cavity_bottom = outer_z_bottom + params.back_wall
    outer_top_z = outer_z_bottom + outer_height
    transition_z = outer_top_z - params.front_lip_height
    cavity = make_rounded_prism(
        width=params.phone_width + 2 * params.fit_clearance,
        length=params.phone_length + 2 * params.fit_clearance,
        corner_radius=params.phone_corner_radius + params.fit_clearance,
        z_bottom=cavity_bottom,
        height=transition_z - cavity_bottom,
    )
    case = outer_case.cut(cavity)

    front_lip_cutter = make_front_lip_cutter(
        cavity_width=params.phone_width + 2 * params.fit_clearance,
        cavity_length=params.phone_length + 2 * params.fit_clearance,
        cavity_corner_radius=params.phone_corner_radius + params.fit_clearance,
        opening_inset=params.front_opening_inset,
        transition_z=transition_z,
        outer_top_z=outer_top_z,
    )
    case = case.cut(front_lip_cutter)

    # The camera relief is the rounded hull of four circles in the source.
    camera_center_x = (
        params.half_width
        - params.camera_center_spacing_x / 2
        - params.camera_radius
        - params.camera_side_offset
    )
    camera_center_y = (
        params.half_length
        - params.camera_center_spacing_y / 2
        - params.camera_radius
        - params.camera_top_offset
    )
    camera_relief = make_rounded_prism(
        width=params.camera_cluster_width,
        length=params.camera_cluster_length,
        corner_radius=params.camera_radius,
        z_bottom=-6.35,
        height=8.7,
    ).translate((camera_center_x, camera_center_y, 0))
    case = case.cut(camera_relief)

    bottom_y = -params.half_length + params.bottom_socket_center_offset
    socket_cutters = [
        make_bottom_slot(
            0,
            bottom_y - params.socket_depth / 2,
            0,
            params.usb_center_spacing,
            params.usb_radius,
            params.socket_depth,
        ),
        make_bottom_slot(
            params.speaker_x_offset,
            bottom_y - params.socket_depth / 2,
            0,
            params.speaker_center_spacing,
            params.speaker_radius,
            params.socket_depth,
        ),
        make_bottom_slot(
            -params.speaker_x_offset,
            bottom_y - params.socket_depth / 2,
            0,
            params.speaker_center_spacing,
            params.speaker_radius,
            params.socket_depth,
        ),
    ]
    for cutter in socket_cutters:
        case = case.cut(cutter)

    # Inner button recesses leave a 1 mm outer skin for tactile pressing.
    controls = [
        (1, params.power_button_length, params.power_button_top_offset),
        (-1, params.volume_up_button_length, params.volume_up_button_top_offset),
        (-1, params.volume_down_button_length, params.volume_down_button_top_offset),
    ]
    for side, length, top_offset in controls:
        y_center = params.button_y(length, top_offset)
        recess_start_x = side * (params.half_width + 0.5)
        recess_direction = -side
        recess = make_yz_capsule(
            x_start=recess_start_x,
            y_center=y_center,
            length=length,
            width=2 * params.button_recess_radius,
            depth=10.0,
            x_direction=recess_direction,
        )
        case = case.cut(recess)

    switch_cutter = make_silent_switch_cutter(params)
    case = case.cut(switch_cutter)

    # Raised pads are added after the recesses and overlap the outer shell.
    for side, length, top_offset in controls:
        y_center = params.button_y(length, top_offset)
        pad_length = length - 2 * (3.0 - params.button_pad_radius)
        outer_side_x = params.half_width + params.wall_thickness
        pad_center_x = side * (
            outer_side_x
            + params.button_pad_projection
            - params.button_pad_thickness / 2
        )
        profile_center_x = side * (
            outer_side_x - params.button_pad_projection / 2
        )
        pad = make_sliced_spherical_capsule(
            profile_center_x=profile_center_x,
            slice_center_x=pad_center_x,
            y_center=y_center,
            length=pad_length,
            radius=params.button_pad_radius,
            slice_thickness=params.button_pad_thickness,
        )
        case = case.fuse(pad)

    return case


def main() -> None:
    case = make_phone_case()
    output_path = Path(__file__).with_name("iphone_13_case.stl")
    export_stl(case, str(output_path), ascii_format=True)
    print(f"Exported {output_path}")


if __name__ == "__main__":
    main()
