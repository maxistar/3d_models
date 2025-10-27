# 3D Models Collection

## Overview
This repository gathers a set of parametric OpenSCAD designs for everyday 3D prints. The models range from cable organizers and modular wall storage to planters, hobby parts, and small household accessories. Each `.scad` file can be opened in OpenSCAD to customize dimensions before exporting printable meshes (`.stl`/`.3mf`).

You can see models visualisations [here](https://projects.maxistar.me/3d_models/).

## Repository layout
- `openscad/` – source models grouped by theme. Most folders also contain pre-exported meshes ready for slicing.
- `openscad/cable_organizer/` – reusable cable spool core (`spull_complete.scad`) and preset variants for thicker wires and watch chargers.
- `openscad/honeycomb/` – modular hexagonal wall system with clips, panels, perimeters, and corner pieces.
- Other `.scad` files in `openscad/` are standalone household, hobby, or plant-care prints.

## Working with the models
1. Open a `.scad` file in [OpenSCAD](https://openscad.org/).
2. Review the parameters defined near the top of the file and adjust dimensions to fit your hardware or use-case.
3. Render (`F6`) to create a solid mesh, then export it as `.stl` or `.3mf` for slicing.
4. Several designs expose booleans (for example `showTopPart`, `showCenter`, `showBottomPart`) that let you print assemblies in separate pieces. Toggle them as needed before export.【F:openscad/cable_organizer/spull_complete.scad†L108-L136】【F:openscad/cable_organizer/spull_bigger_thin.scad†L1-L18】

## Model catalog

### Cable management spools (`openscad/cable_organizer`)
- **`spull_complete.scad`** – Core generator that builds a two-part spool with a customizable wire channel, hook ring, and optional large cut-outs for gripping or cable exits. Key parameters let you set the inner/outer diameters, spool height, wire diameter, hook geometry, and whether to render the top, core, or bottom bodies for separate printing.【F:openscad/cable_organizer/spull_complete.scad†L1-L149】【F:openscad/cable_organizer/spull_complete.scad†L200-L253】
- **`spull_bigger_thin.scad`** – Uses the core generator to produce a taller 70 mm body with 4.5 mm wire channels and exposes only the center section (ideal for remixing with other end caps).【F:openscad/cable_organizer/spull_bigger_thin.scad†L1-L18】
- **`spull_watch_charger.scad`** – Variant sized for round smartwatch chargers: expands the inner diameter to ~39.5 mm, outer diameter to 45 mm, and shifts the wire channel upward to accommodate the puck form factor.【F:openscad/cable_organizer/spull_watch_charger.scad†L1-L23】
- **`spull_simple.scad`** – Simplified body that replaces the sculpted shell with a slimmer form, adds posts for wrapping cable ends, and still accepts the same adjustable spool core.【F:openscad/cable_organizer/spull_simple.scad†L1-L132】【F:openscad/cable_organizer/spull_simple.scad†L200-L237】

### Modular honeycomb wall system (`openscad/honeycomb`)
- **`honeycomb_element.scad`** – Defines the base hexagonal cell with configurable clips and locking pins on each of the six faces. Booleans (`pin_1…pin_6`, `slot_1…slot_6`) let you create tiles that interlock on specific sides.【F:openscad/honeycomb/honeycomb_element.scad†L1-L116】
- **`panel_9x9.scad`** – Builds a 9×9 array of cells, automatically mixing clip and pin configurations for edges and corners so large panels stay aligned when assembled.【F:openscad/honeycomb/panel_9x9.scad†L1-L29】
- **Perimeter and corner pieces** – Files such as `perimeter_top_double.scad`, `perimeter_bottom_single_v2.scad`, and `corner_7.scad` trim cells to create tidy borders, corners, or side caps when mounting panels to a wall.【F:openscad/honeycomb/corner_7.scad†L1-L49】【F:openscad/honeycomb/wall.scad†L1-L132】
- **`wall.scad`** – Example assembly that positions multiple panels plus perimeters and corners to form a full wall layout, useful as a reference when arranging your own configurations.【F:openscad/honeycomb/wall.scad†L1-L154】

### Plant care and bottle accessories
- **`watering_box.scad`** – Square self-watering planter base with a recessed pot seat, central drain/fill tube, and optional side tube for irrigation lines.【F:openscad/watering_box.scad†L1-L31】
- **`watering_box_round.scad`** – Round variant with similar reservoir geometry and optional radial supports for additional rigidity.【F:openscad/watering_box_round.scad†L1-L37】【F:openscad/watering_box_round.scad†L39-L48】
- **`watering_box_round_with_device.scad`** – Adds a pocket for electronics (e.g., pump or sensors) plus a routed cable tube, enabling automated watering setups.【F:openscad/watering_box_round_with_device.scad†L1-L48】【F:openscad/watering_box_round_with_device.scad†L50-L60】
- **`bottle_cap.scad`** – Rounded cup-style cap sized for ~39 mm bottles, with six internal gripping arms and three external legs so the bottle can be suspended or drained upside down.【F:openscad/bottle_cap.scad†L1-L92】

### Household utilities and workspace helpers
- **`battery_plug.scad`** – Simple 18 mm diameter plug with four 1.5 mm pass-through holes for organizing small cylindrical batteries or covering exposed terminals.【F:openscad/battery_plug.scad†L1-L18】
- **`hook_big.scad`** – Large flat-backed hook created via a tapered extrusion, useful for hanging bags or headphones from shelves or wall mounts.【F:openscad/hook_big.scad†L1-L22】
- **`pen_monitor_holder.scad`** – Clip that slides over a monitor bezel and provides a rounded 35×45×55 mm pocket to park pens or styluses within reach.【F:openscad/pen_monitor_holder.scad†L1-L48】
- **`trolley_coin.scad`** – Shopping-cart coin replacements in two styles: a Euro-sized token and a handled version with “NeuConf” lettering for easier retrieval.【F:openscad/trolley_coin.scad†L1-L53】【F:openscad/trolley_coin.scad†L55-L72】

### Kitchen, hobbies, and props
- **`cake_mold.scad`** – Thin-walled hemispherical mold (80 mm radius) with a flat base for casting or baking dome-shaped desserts.【F:openscad/cake_mold.scad†L1-L16】
- **`spinning_top.scad`** – Gyroscopic top with a faceted core and three magnet pockets for tuning spin stability.【F:openscad/spinning_top.scad†L1-L52】
- **`lightsaber.scad`** – Removes a cylindrical channel from the included emitter shroud STL, tailoring the prop to house electronics or a blade stub.【F:openscad/lightsaber.scad†L1-L12】

### Electronics and optics
- **`cherry_mx_v2.scad`** – Parametric Cherry MX keycap featuring a gently spherical top and cross-shaped stem; adjust `cap_size`, `cap_height`, and `inner_size` to fit different switches.【F:openscad/cherry_mx_v2.scad†L1-L32】
- **`linseHolder.scad`** – Lens holder with a ball-and-socket connector system. Modules generate both the lens cup (with space for a 59.75 mm optic) and a matching connector element with tensioning cuts for snap-fit articulation.【F:openscad/linseHolder.scad†L1-L78】【F:openscad/linseHolder.scad†L80-L142】

## Printing notes
- Most designs set `$fn` to high values for smoother curves; you can reduce these for faster previews or increase them for finer prints.【F:openscad/bottle_cap.scad†L1-L3】【F:openscad/watering_box_round.scad†L1-L8】
- Several folders include pre-exported `.stl` and `.3mf` files if you prefer to slice without modifying the source. The OpenSCAD files remain the single source of truth for making dimensional tweaks.

## Contributing
Feel free to extend existing models or add new ones. When contributing:
- Keep parametric variables grouped near the top of each file for easier customization.
- Include rendered previews (`.stl`/`.3mf`) when possible so others can quickly print without rebuilding the mesh.
