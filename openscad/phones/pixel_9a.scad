/**
 * Xiaomi Mi 9 Pro case and cover.
 *
 * Coordinate system:
 *   X — phone width, left/right
 *   Y — phone length, bottom/top
 *   Z — case thickness
 *
 * The phone body is centered around the X/Y origin. Values named
 * `phone_half_*` are half-dimensions used as corner coordinates.


- make simple version
- make strip thicker
- make usb
- make round hollow for buttons
- make rounding


- [x] make usb 1mm (0.5) highter
- [x] move it a side a litle a make wider
- [x] move camere 1mm highter
- [x] move buttons 2, 3mm higher
- [x] make rounding 0.5 - 1mm bigger
- [x] remove interne rounding
- make buttons more bigger






 */

// ── Rendering ────────────────────────────────────────────────────────────────

$fn = 100;

// masured values
phone_width = 73.21;
phone_length = 154.0;
phone_thickness = 8.5;

// - Расстояние между камерами 30.14. 
cameras_distanse = 30.14;

//- camera diametr 18.34. 
camera_radius = 18.34 / 2;

// Сверху до камеры 15.74
// Камера, расстояние до центра. 23.31
camera_top_offset = 15.74 - 1.5;
// до камеры сбоку 6.79. 
camera_side_offset = 6.79;

//длина кнопки питания 14.06.
power_button_length = 14.06;
//длина кнопок громкости 23.86.
volume_button_length = 23.86;

//до кнопки питания сверху 43.39. (-0.39) 
power_button_top_offset = 43 - 2;

//расстояние между кнопками 7.51 (-0.51)
volume_button_top_offset = 7 + power_button_top_offset + power_button_length - 1;

buttons_radius = 1;

// External button caps: rounded profile and X distances from the outer wall.
case_button_radius = buttons_radius + 0.5;
case_button_protrusion = 1.25;
case_button_wall_overlap = 0.25;

// ── Main dimensions (mm) ─────────────────────────────────────────────────────

phone_half_width = phone_width / 2;
phone_half_length = phone_length / 2;
corner_radius = 10 + 1;
edge_radius = 1;

// ── Hardware ─────────────────────────────────────────────────────────────────

magnet_radius = 4 / 2 + 0.05; // 4 mm magnet diameter plus clearance

// ── Feature positions ────────────────────────────────────────────────────────

camera_position = [-23.2, -66, 0];
speaker_cut_offset = 18;

latch_positions = [
  [-20, 50, 0],
  [-20, 20, 0],
  [-20, -10, 0],
];

cover_layout_x_offset = phone_half_width * 2 + 37;

strip_thickness = 0.5;

// ── Profiles and main volumes ────────────────────────────────────────────────

// Positive expansion grows the body in X/Y/Z; extra_height adds to the total
// Z height independently. Both adjustments keep the body centered.
module outer_case_body(
  expansion = 0,
  extra_height = 0,
  edge_radius = edge_radius,
  corner_radius = corner_radius
) {
  phone_half_width_without_radius = phone_half_width - corner_radius - edge_radius;
  phone_half_length_without_radius = phone_half_length - corner_radius - edge_radius;
  minkowski() {
    hull() {
      for (x = [-phone_half_width_without_radius, phone_half_width_without_radius]) {
        for (y = [-phone_half_length_without_radius, phone_half_length_without_radius]) {
          translate([x, y, 0])
            cylinder(
              h=phone_thickness - edge_radius * 2 + extra_height,
              r=corner_radius,
              center=true
            );
        }
      }
    }
    sphere(r=edge_radius + expansion);
  }
}

// Preserve the rounded upper half, but remove the edge rounding on the
// lower half (Z <= 0) so the case cavity has a flat bottom.
module inner_case_volume_no_round_bottom() {
  union() {
    outer_case_body();

    difference() {
      outer_case_body(edge_radius=0);

      // Remove the upper half of the body without edge rounding.
      translate([0, 0, phone_length])
        cube([phone_length * 2, phone_length * 2, phone_length * 2], center=true);
    }
  }
}

module sockets() {
  translate([-1.5, -phone_half_length + 5, 0.8]) {
    usb_cut();
  }
  translate([speaker_cut_offset, -phone_half_length + 5, 0.8]) {
    speaker_cut();
  }

  // 8.21
  /*
  translate([-8.21, -phone_half_length + 5, 0]) {
    rotate([90, 0, 0]) {
      cylinder(h=10, r=1.5);
    }
  }*/

  //- Верхний датчик 22.30 . 
  translate([22.30, phone_half_length + 5, 0]) {
    rotate([90, 0, 0]) {
      cylinder(h=10, r=2);
    }
  }
}

module phone_body_model() {

  difference() {
    outer_case_body();
    sockets();
  }

  translate([-phone_width / 2 + cameras_distanse / 2 + camera_radius + camera_side_offset, phone_half_length - camera_radius - camera_top_offset, -2]) {
    cameraBlock();
  }

  translate([phone_width / 2 + 1 / 2, phone_half_length - power_button_length / 2 - power_button_top_offset, 0]) {
    sideButton(button_length=power_button_length);
  }

  translate([phone_width / 2 + 1 / 2, phone_half_length - volume_button_length / 2 - volume_button_top_offset, 0]) {
    sideButton(button_length=volume_button_length);
  }
}

// Length runs along Y; depth runs along X, through the side wall.
module sideButton(button_length = power_button_length, button_depth_x = 1, buttons_radius = buttons_radius) {
  hull() {
    translate([0, button_length / 2 - buttons_radius, 0])
      rotate([0, 90, 0])
        cylinder(r=buttons_radius, h=button_depth_x, center=true);

    translate([0, -button_length / 2 + buttons_radius, 0])
      rotate([0, 90, 0])
        cylinder(r=buttons_radius, h=button_depth_x, center=true);
  }
}

module cameraBlock(camera_radius = camera_radius) {

  hull() {
    translate([-cameras_distanse / 2, 0, 0])
      cylinder(h=phone_thickness, r=camera_radius, center=true);
    translate([cameras_distanse / 2, 0, 0])
      cylinder(h=phone_thickness, r=camera_radius, center=true);
  }
}

// 2D phone opening profile used for the flat cover.
// Positive expansion grows the outline in X/Y; negative expansion shrinks it.
// extra_corner_radius increases rounding while preserving the outline dimensions.
module phone_opening_profile(expansion = 0, extra_corner_radius = 0) {

  phone_half_width_without_radius = phone_half_width - corner_radius - edge_radius - extra_corner_radius;
  phone_half_length_without_radius = phone_half_length - corner_radius - edge_radius - extra_corner_radius;

  hull() {
    for (x = [-phone_half_width_without_radius, phone_half_width_without_radius]) {
      for (y = [-phone_half_length_without_radius, phone_half_length_without_radius]) {
        translate([x, y])
          circle(r=corner_radius + expansion + extra_corner_radius);
      }
    }
  }
}

// ── Reusable cutouts ─────────────────────────────────────────────────────────

module camera_cut(expansion = 0, height = 20) {
  translate(camera_position) {
    hull() {
      cylinder(h=height, r=6 + expansion, center=true);

      translate([0, 28, 0])
        cylinder(h=height, r=6 + expansion, center=true);
    }
  }
}

module speaker_cut() {
  rotate([90, 0, 0])
    linear_extrude(height=10)
      hull() {
        translate([-6, 0])
          circle(r=1.5);

        translate([6, 0])
          circle(r=1.5);
      }
}

module usb_cut() {
  rotate([90, 0, 0])
    linear_extrude(height=10)
      hull() {
        translate([-3.5, 0])
          circle(r=3);

        translate([3.5, 0])
          circle(r=3);
      }
}

// ── Case ─────────────────────────────────────────────────────────────────────

module case_front_cutout() {
  linear_extrude(10)
    phone_opening_profile(expansion=0.5, extra_corner_radius=1);

  // Trim above the case rim. At the current dimensions the cube is above
  // the outer body; retain the limit if the body height is increased.
  translate([0, 0, 11.5])
    cube([200, 200, 10], center=true);
}

module case_camera_cutout() {
  translate([-( -phone_width / 2 + cameras_distanse / 2 + camera_radius + camera_side_offset), phone_half_length - camera_radius - camera_top_offset, -5]) {
    cameraBlock(camera_radius=camera_radius + 1);
  }
}

module case_button_cutouts() {
  translate([phone_width / 2 - 0.5, phone_half_length - power_button_length / 2 - power_button_top_offset, 0]) {
    sideButton(button_length=power_button_length, button_depth_x=2.6, buttons_radius=buttons_radius + 1);
  }

  translate([phone_width / 2 - 0.5, phone_half_length - volume_button_length / 2 - volume_button_top_offset, 0]) {
    sideButton(button_length=volume_button_length, button_depth_x=2.6, buttons_radius=buttons_radius + 1);
  }
}

module case_buttons() {
  translate([phone_width / 2 + 1.5, phone_half_length - power_button_length / 2 - power_button_top_offset, 0]) {
    button_plug(button_length=power_button_length);
  }

  translate([phone_width / 2 + 1.5, phone_half_length - volume_button_length / 2 - volume_button_top_offset, 0]) {
    button_plug(button_length=volume_button_length);
  }
}

module phone_case() {
  difference() {
    outer_case_body(expansion=1.5, extra_height=0.5, edge_radius=0);
    inner_case_volume_no_round_bottom();
    case_front_cutout();
    sockets();
    case_camera_cutout();
    case_button_cutouts();
  }

  case_buttons();
}

// Y length includes the rounded ends. Local X=0 is the outer wall:
// retain a small overlap inside the wall and a rounded cap outside it.
module button_plug(
  button_length = power_button_length,
  button_radius = case_button_radius,
  protrusion = case_button_protrusion,
  wall_overlap = case_button_wall_overlap
) {
  end_offset = button_length / 2 - button_radius;

  intersection() {
    hull() {
      for (y = [-end_offset, end_offset])
        translate([0, y, 0])
          sphere(r=button_radius);
    }

    // Trim both sides of the spherical hull to X=[-wall_overlap, protrusion].
    translate([(protrusion - wall_overlap) / 2, 0, 0])
      cube([protrusion + wall_overlap, button_length, button_radius * 2], center=true);
  }
}

// ── Magnetic latches ─────────────────────────────────────────────────────────

module latch_cap() {
  cap_height = 2;

  translate([0, 0, 1.1])
    cylinder(h=1, r1=4.5, r2=5.4);

  cylinder(h=cap_height, r=4.5);
}

module latch_cut() {
  inner_height = 20;
  outer_height = 13;
  latch_offset = 6;

  cylinder(h=inner_height, r=4.5, center=true);

  hull() {
    cylinder(h=inner_height, r=4.5, center=true);

    translate([0, latch_offset, 0])
      cylinder(h=inner_height, r=4.5, center=true);
  }

  translate([0, latch_offset, 0])
    cylinder(h=inner_height, r=5.5, center=true);

  hull() {
    cylinder(h=outer_height, r=5.5, center=true);

    translate([0, latch_offset, 0])
      cylinder(h=outer_height, r=5.5, center=true);
  }
}

module magnetic_latch() {
  translate([-phone_half_width * 2 - 12, 0, 0]) {
    difference() {
      cylinder(h=2.3, r=10);
      cylinder(h=10, r=magnet_radius);
    }

    difference() {
      cylinder(h=2.8, r=8);
      cylinder(h=4, r=7);
    }
  }

  hull() {
    translate([-phone_half_width, 0, 0])
      cylinder(h=strip_thickness, r=10);

    translate([-phone_half_width * 2 - 10, 0, 0])
      cylinder(h=strip_thickness, r=10);
  }
}

// ── Flat cover ───────────────────────────────────────────────────────────────

module cover(thickness = 2) {
  linear_extrude(thickness)
    phone_opening_profile(expansion=1);
}

module flat_cover_with_camera_cut() {
  difference() {
    cover();
    camera_cut();
  }
}

module camera_rim() {
  difference() {
    translate([0, 0, 2 / 2])
      camera_cut(height=1.5, expansion=1 - 0.1);
    camera_cut(height=20);
  }
}

module magnet_cover() {
  translate([cover_layout_x_offset, 0, 0]) {
    difference() {
      union() {
        cover(thickness=1.5);
        linear_extrude(2.5)
          phone_opening_profile(expansion=-2.5);
      }

      translate([25, 0, 0.2])
        cylinder(h=10, r=magnet_radius);

      translate([25, 0, -1.5 + 0.5])
        difference() {
          cylinder(h=3, r=8 + 0.2, center=true);
          cylinder(h=4, r=7 - 0.2, center=true);
        }
    }
  }
}

module connector_strip() {
  translate([55, 0])
    linear_extrude(strip_thickness)
      square([100, phone_half_length * 2], center=true);
}

// ── Print layout ─────────────────────────────────────────────────────────────

module cover_layout() {
  // Main flat cover with camera and case clearance cuts.
  difference() {
    flat_cover_with_camera_cut();

    translate([-5, 0, 10 + strip_thickness])
      cube([2, 500, 20], center=true);

    translate([0, 0, 8])
      outer_case_body(expansion=-2, extra_height=1, edge_radius=2);
  }

  camera_rim();

  // Matching latch caps.
  for (position = latch_positions)
    translate(position)
      latch_cap();

  // Top cover with a magnet pocket.
  magnet_cover();

  magnetic_latch();

  // Thin connector strip used to keep the parts together while printing.
  connector_strip();
}

module phone_solid($fn = 30) {

  // Main flat cover with camera and case clearance cuts.
  flat_cover_with_camera_cut();

  translate([0, 0, 8]) {
    phone_case();
  }

  // Top cover with a magnet pocket.
  magnet_cover();

  magnetic_latch();

  // Thin connector strip used to keep the parts together while printing.
  connector_strip();
}

module preview() {
  translate([0, 0, 8 + 0]) {
    phone_case();
  }

  translate([0, 0, 8 + 20]) {
    phone_body_model();

    //}
  }

  translate([50, 0, 8 + 20]) {
    //cube([phone_width, phone_length, phone_thickness], center=true);
  }
}

phone_case();
//inner_case_volume_no_round_bottom();

/*
difference() {
  //preview();
  phone_case();
  translate([0, 150, 0])
    cube([300, 300, 300], center=true);
}
*/

/*
cover_layout();

translate([0, 0, 8 - 100]) {
  phone_solid();
}
*/
