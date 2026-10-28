/**
 * Xiaomi Mi 9 Pro case and cover.
 *
 * Coordinate system:
 *   X — phone width, left/right
 *   Y — phone length, bottom/top
 *   Z — case thickness
 *
 * The phone body is centered around the X/Y origin. `phone_width` and
 * `phone_length` are the full base profile dimensions, including corner radii,
 * before clearance offsets and outer case rounding are applied.


   - make simple version
   - make strip thicker
   - make usb
   - make round hollow for buttons
   - make rounding

   - verify phone size - now it is too small!!! 
 */

// ── Rendering ────────────────────────────────────────────────────────────────

$fn = 30;

// ── Main dimensions (mm) ─────────────────────────────────────────────────────

phone_width = 74.5;
phone_length = 156.6;
corner_radius = 9;
outline_z_scale = 0.9;
phone_thickness = 8.8;

// Coordinates of the corner centers, derived from the full profile dimensions.
phone_corner_x = phone_width / 2 - corner_radius;
phone_corner_y = phone_length / 2 - corner_radius;

// ── Hardware ─────────────────────────────────────────────────────────────────

magnet_radius = 4 / 2 + 0.05; // 4 mm magnet diameter plus clearance

// ── Feature positions ────────────────────────────────────────────────────────

camera_position = [-23.2, -66, 0];

// Side buttons: Y is the center of each button; length includes rounded ends.
button_cutout_x = -38;
button_plug_x = -37.9;
power_button_y = -17.5;
volume_button_y = -38;
power_button_length = 15;
volume_button_length = 24;
button_cutout_radius = 3;
button_plug_radius = 2.4;
power_button_plug_y_offset = -0.1;

// Flat faces of the button plugs, relative to their center on X.
button_plug_right_trim_x = 5.8;
button_plug_left_trim_x = -6.3;
button_plug_trim_width = 10;
button_plug_trim_height = 10;

latch_positions = [
  [-20, 50, 0],
  [-20, 20, 0],
  [-20, -10, 0],
];

cover_layout_x_offset = phone_corner_x * 2 + 37;

strip_thickness = 0.5;

// ── Profiles and main volumes ────────────────────────────────────────────────

// Rounded external volume used to form the newer case shape.
module outer_case_body(offset = 0, thickness_offset = 0, edge_radius = 3) {
  minkowski() {
    hull() {
      for (x = [-phone_corner_x, phone_corner_x]) {
        for (y = [-phone_corner_y, phone_corner_y]) {
          translate([x, y, 0])
            cylinder(
              h=phone_thickness + thickness_offset,
              r=corner_radius + offset,
              center=true
            );
        }
      }
    }
    sphere(r=edge_radius);
  }
}

// Inner volume subtracted from the case to create the wall thickness.
module inner_case_volume(offset = 0) {
  hull() {
    for (x = [-phone_corner_x, phone_corner_x]) {
      for (y = [-phone_corner_y, phone_corner_y]) {
        translate([x, y, 0])
          scale([1, 1, outline_z_scale])
            sphere(corner_radius - offset);
      }
    }
  }
}

module inner_case_volume_no_round_bottom(offset = 0) {

  inner_case_volume(offset);

  translate([0, 0, -phone_thickness / 2 + 0.7])
    linear_extrude(phone_thickness, center=true)
      phone_opening_profile(offset);
}

// 2D phone opening profile used for the flat cover.
module phone_opening_profile(offset = 0, corner_radius = corner_radius) {
  hull() {
    for (x = [-phone_corner_x, phone_corner_x]) {
      for (y = [-phone_corner_y, phone_corner_y]) {
        translate([x, y])
          circle(corner_radius - offset);
      }
    }
  }
}

// ── Reusable cutouts ─────────────────────────────────────────────────────────

module camera_cut(offset = 0, height = 20) {
  translate(camera_position) {
    hull() {
      cylinder(h=height, r=6 + offset, center=true);

      translate([0, 28, 0])
        cylinder(h=height, r=6 + offset, center=true);
    }
  }
}

// Slot along X; center_distance is the spacing between the rounded ends.
module rounded_slot_cut(center_distance, radius, depth = 10) {
  rotate([90, 0, 0])
    linear_extrude(height=depth)
      hull() {
        translate([-center_distance / 2, 0])
          circle(r=radius);

        translate([center_distance / 2, 0])
          circle(r=radius);
      }
}

module speaker_cut() {
  rounded_slot_cut(center_distance=10, radius=1.5);
}

module usb_cut() {
  rounded_slot_cut(center_distance=7, radius=3);
}

// Top edge: speaker, USB-C, speaker.
module top_edge_cutouts() {
  translate([16, 83, 0])
    speaker_cut();

  translate([0, 83, 0])
    usb_cut();

  translate([-16, 83, 0])
    speaker_cut();
}

// Bottom edge: audio jack and microphones.
module bottom_edge_cutouts() {
  translate([22.5, -60, 0])
    rotate([90, 0, 0])
      cylinder(h=30, r=3.3);

  translate([-25, -60, 0])
    rotate([90, 0, 0])
      cylinder(h=30, r=2);

  translate([-10, -60, 0])
    rotate([90, 0, 0])
      cylinder(h=30, r=2);
}

module button_inner_cutouts() {
      button_inner_cutout(power_button_y, power_button_length);
      button_inner_cutout(volume_button_y, volume_button_length);
}

module button_cutouts() {

  difference() {
    union() {
      button_cutout(power_button_y, power_button_length);
      button_cutout(volume_button_y, volume_button_length);
    }
    cube([phone_width - 1, phone_length, phone_thickness], center=true);
  }
}

module button_cutout(center_y, button_length) {
  end_offset = button_length / 2 - button_cutout_radius;

  translate([button_cutout_x, center_y, 0])
    hull()for (y = [-end_offset, end_offset])
      translate([0, y, 0])
        sphere(r=button_cutout_radius);
}

module button_inner_cutout(center_y, button_length) {
  end_offset = button_length / 2 - button_cutout_radius;

  translate([button_cutout_x+1.3, center_y, 0])
    hull()for (y = [-end_offset, end_offset])
      translate([0, y, 0])
    rotate([0, 90, 0])
      cylinder(h=10, r=3);
}

// ── Case ─────────────────────────────────────────────────────────────────────

module phone_case() {

  difference() {
    outer_case_body(offset=-2, thickness_offset=1, edge_radius=2);

    //inner_case_volume(1);
    inner_case_volume_no_round_bottom(1);

    // Open front of the case.
    linear_extrude(10)
      phone_opening_profile(2.5, corner_radius=corner_radius);

    // Remove the upper part of the body to form the case rim.
    translate([0, 0, 5 + 5])
      cube([200, 200, 10], center=true);

    top_edge_cutouts();
    bottom_edge_cutouts();
    //button_cutouts();
    button_inner_cutouts();

    camera_cut(1);

    /*
    for (position = latch_positions)
      translate(position)
        latch_cut();
        */

    translate([-45.1, -8.5, 0])
      rotate([90, 0, 0])
        cylinder(h=43, r=7);
  }

  //button_cutouts();
  //button_inner_cutouts();

  translate([button_plug_x, power_button_y + power_button_plug_y_offset, 0])
    button_plug(power_button_length);

  translate([button_plug_x, volume_button_y, 0])
    button_plug(volume_button_length);
}

module button_plug(button_length = power_button_length) {
  end_offset = button_length / 2 - button_cutout_radius;

  difference() {
    hull() {
      translate([0, end_offset, 0])
        sphere(button_plug_radius);
      translate([0, -end_offset, 0])
        sphere(button_plug_radius);
    }

    translate([button_plug_right_trim_x, 0, 0])
      cube([button_plug_trim_width, end_offset * 2 + button_plug_radius * 2, button_plug_trim_height], center=true);

    translate([button_plug_left_trim_x, 0, 0])
      cube([button_plug_trim_width, end_offset * 2 + button_plug_radius * 2, button_plug_trim_height], center=true);
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
  translate([-phone_corner_x * 2 - 12, 0, 0]) {
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
    translate([-phone_corner_x, 0, 0])
      cylinder(h=strip_thickness, r=10);

    translate([-phone_corner_x * 2 - 10, 0, 0])
      cylinder(h=strip_thickness, r=10);
  }
}

// ── Flat cover ───────────────────────────────────────────────────────────────

module cover(thickness = 2) {
  linear_extrude(thickness)
    phone_opening_profile(-1);
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
      camera_cut(height=1.5, offset=1 - 0.1);
    camera_cut(height=20);
  }
}

module magnet_cover() {
  translate([cover_layout_x_offset, 0, 0]) {
    difference() {
      union() {
        cover(thickness=1.5);
        linear_extrude(2.5)
          phone_opening_profile(2.5);
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
  // Span between the corner centers keeps the strip clear of the rounded ends.
  translate([55, 0])
    linear_extrude(strip_thickness)
      square([100, phone_corner_y * 2], center=true);
}

// ── Print layout ─────────────────────────────────────────────────────────────

module cover_layout() {
  // Main flat cover with camera and case clearance cuts.
  difference() {
    flat_cover_with_camera_cut();

    translate([-5, 0, 10 + strip_thickness])
      cube([2, 500, 20], center=true);

    translate([0, 0, 8])
      outer_case_body(offset=-2, thickness_offset=1, edge_radius=2);
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

  //inner_case_volume_no_round_bottom();
}

translate([0, 0, 8 + 50]) {
  phone_case();
}

cover_layout();

translate([0, 0, 8 - 100]) {
  phone_solid();
}
