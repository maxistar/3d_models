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
 */

// ── Rendering ────────────────────────────────────────────────────────────────

$fn = 50;

// ── Main dimensions (mm) ─────────────────────────────────────────────────────

phone_half_width = 30;
phone_half_length = 70.8;
corner_radius = 9;
outline_z_scale = 0.8;
phone_thickness = 8.8;

// ── Hardware ─────────────────────────────────────────────────────────────────

magnet_radius = 4 / 2 + 0.05; // 4 mm magnet diameter plus clearance

// ── Feature positions ────────────────────────────────────────────────────────

camera_position = [-23.2, -66, 0];

latch_positions = [
  [-20, 50, 0],
  [-20, 20, 0],
  [-20, -10, 0],
];

cover_layout_x_offset = phone_half_width * 2 + 35;

strip_thickness = 0.5;

// ── Profiles and main volumes ────────────────────────────────────────────────

// Rounded external volume used to form the newer case shape.
module outer_case_body(offset = 0, thickness_offset = 0, edge_radius = 3) {
  minkowski() {
    hull() {
      for (x = [-phone_half_width, phone_half_width]) {
        for (y = [-phone_half_length, phone_half_length]) {
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
    for (x = [-phone_half_width, phone_half_width]) {
      for (y = [-phone_half_length, phone_half_length]) {
        translate([x, y, 0])
          scale([1, 1, outline_z_scale])
            sphere(corner_radius - offset);
      }
    }
  }
}

// 2D phone opening profile used for the flat cover.
module phone_opening_profile(offset = 0) {
  hull() {
    for (x = [-phone_half_width, phone_half_width]) {
      for (y = [-phone_half_length, phone_half_length]) {
        translate([x, y])
          circle(corner_radius - offset);
      }
    }
  }
}

// ── Reusable cutouts ─────────────────────────────────────────────────────────

module camera_cut(offset = 0, hight = 20) {
  translate(camera_position) {
    hull() {
      cylinder(h=hight, r=6 + offset, center=true);

      translate([0, 28, 0])
        cylinder(h=hight, r=6 + offset, center=true);
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

module phone_case() {
  difference() {
    outer_case_body(offset=-2, thickness_offset=1, edge_radius=2);

    inner_case_volume(1.5);

    // Open front of the case.
    linear_extrude(10)
      phone_opening_profile(1.9);

    // Remove the upper part of the body to form the case rim.
    translate([0, 0, 5 + 4.8])
      cube([200, 200, 10], center=true);

    // Top edge: speaker, USB-C, speaker.
    translate([15, 83, 0])
      speaker_cut();

    translate([0, 83, 0])
      usb_cut();

    translate([-15, 83, 0])
      speaker_cut();

    // Bottom edge: audio jack and microphones.
    translate([22.5, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=3.3);

    translate([-25, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=2);

    translate([-10, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=2);

    // Side buttons.
    translate([-39, -30, 0]) {
      // Power button.
      hull() {
        translate([0, 20 - 3, 0])
          sphere(r=3);

        translate([0, 8, 0])
          sphere(r=3);
      }

      // Volume buttons.
      hull() {
        translate([0, 1, 0])
          sphere(r=3);

        translate([0, -20 + 3, 0])
          sphere(r=3);
      }
    }

    camera_cut(1);

    for (position = latch_positions)
      translate(position)
        latch_cut();

    translate([-45.1, -8.5, 0])
      rotate([90, 0, 0])
        cylinder(h=43, r=7);
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
  translate([-phone_half_width * 2 - 10, 0, 0]) {
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
    phone_opening_profile();
}

// ── Print layout ─────────────────────────────────────────────────────────────

module print_layout() {
  // Main flat cover with camera and case clearance cuts.
  difference() {
    cover();

    camera_cut();

    translate([-5, 0, 10 + strip_thickness])
      cube([2, 500, 20], center=true);

    translate([0, 0, 8])
      outer_case_body(offset=-2, thickness_offset=1, edge_radius=2);
  }

  difference() {
    translate([0, 0, 2 / 2])
      camera_cut(hight=1.5, offset=1 - 0.1);
    camera_cut(hight=20);
  }
  // Matching latch caps.
  for (position = latch_positions)
    translate(position)
      latch_cap();

  // Top cover with a magnet pocket.
  translate([cover_layout_x_offset, 0, 0]) {
    difference() {
      union() {
        cover(thickness=1.5);
        linear_extrude(2.5)
          phone_opening_profile(2);
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

  magnetic_latch();

  // Thin connector strip used to keep the parts together while printing.
  translate([55, 0])
    linear_extrude(strip_thickness)
      square([100, phone_half_length * 2], center=true);
}

module phone_solid() {
  // Main flat cover with camera and case clearance cuts.
  difference() {
    cover();

    camera_cut();
  }

  translate([0, 0, 8]) {
    phone_case();
  }

  // Top cover with a magnet pocket.
  translate([cover_layout_x_offset, 0, 0]) {
    difference() {
      union() {
        cover(thickness=1.5);
        linear_extrude(2.5)
          phone_opening_profile(2);
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

  magnetic_latch();

  // Thin connector strip used to keep the parts together while printing.
  translate([55, 0])
    linear_extrude(strip_thickness)
      square([100, phone_half_length * 2], center=true);
}

translate([0, 0, 8 + 50]) {
  phone_case();
}

print_layout();

translate([0, 0, 8 - 100]) {
  phone_solid();
}
