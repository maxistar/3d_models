module cable_hook(
  facets = 100,
  hook_height = 70,
  hook_width = 25,
  hook_thickness = 4,
  corner_radius = 6,
  hole_radius = 6,
  slot_offset_x = 15,
  slot_opening_length = 20,
  cutter_height = 30,
  open_right_slot = true,
  open_left_slot = true,
  open_corner_slots = false,
  add_central_hole = false
) {
  $fn = facets;

  difference() {
    union() {
      cube([hook_height, hook_width, hook_thickness], center=true);

      translate([hook_height / 2, hook_width / 2, 0])
        cylinder(r=corner_radius, h=hook_thickness, center=true);

      translate([-hook_height / 2, hook_width / 2, 0])
        cylinder(r=corner_radius, h=hook_thickness, center=true);

      translate([-hook_height / 2, -hook_width / 2, 0])
        cylinder(r=corner_radius, h=hook_thickness, center=true);

      translate([hook_height / 2, -hook_width / 2, 0])
        cylinder(r=corner_radius, h=hook_thickness, center=true);
    }

    union() {

      if (add_central_hole)
        cylinder(r=hole_radius, h=cutter_height, center=true);

      translate([slot_offset_x, 0, 0]) {
        cylinder(r=hole_radius, h=cutter_height, center=true);
      }

      translate([-slot_offset_x, 0, 0]) {
        cylinder(r=hole_radius, h=cutter_height, center=true);
      }

      if (open_right_slot)
        translate([slot_offset_x, slot_opening_length / 2, 0])
          cube([hole_radius, slot_opening_length, cutter_height], center=true);

      if (open_left_slot)
        translate([-slot_offset_x, -slot_opening_length / 2, 0])
          cube([hole_radius, slot_opening_length, cutter_height], center=true);

      if (open_corner_slots) {
        translate([hook_height / 2, hook_width / 2, 0])
          cylinder(r=hole_radius, h=cutter_height, center=true);
        translate([-hook_height / 2, hook_width / 2, 0])
          cylinder(r=hole_radius, h=cutter_height, center=true);
        translate([-hook_height / 2, -hook_width / 2, 0])
          cylinder(r=hole_radius, h=cutter_height, center=true);
        translate([hook_height / 2, -hook_width / 2, 0])
          cylinder(r=hole_radius, h=cutter_height, center=true);

        translate([hook_height / 2, hook_width / 2 + slot_opening_length / 2, 0])
          cube([hole_radius, slot_opening_length, cutter_height], center=true);
        translate([-hook_height / 2, hook_width / 2 + slot_opening_length / 2, 0])
          cube([hole_radius, slot_opening_length, cutter_height], center=true);
        translate([-hook_height / 2, -hook_width / 2 - slot_opening_length / 2, 0])
          cube([hole_radius, slot_opening_length, cutter_height], center=true);
        translate([hook_height / 2, -hook_width / 2 - slot_opening_length / 2, 0])
          cube([hole_radius, slot_opening_length, cutter_height], center=true);
      }
    }
  }
}

cable_hook();
