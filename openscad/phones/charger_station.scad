$fn = 50;

box_width = 200;
box_length = 100;
box_height = 50;
corner_radius = 10;
wall_thickness = 2;

module rounded_rectangle(width, length, radius) {
  hull() {
    for (x = [-width / 2 + radius, width / 2 - radius])
      for (y = [-length / 2 + radius, length / 2 - radius])
        translate([x, y]) circle(r=radius);
  }
}

module outer_outline(offset = 0) {
  linear_extrude(height=box_height - offset, center=true)
    rounded_rectangle(box_width - offset, box_length - offset, corner_radius);
}

module upper_part() {
  difference() {
    outer_outline();
    translate([-box_width, -box_length, -box_height + 3])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness * 2);
  }

  difference() {
    outer_outline();
    translate([-box_width, -box_length, -box_height])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness);
  }
}

module bottom_part() {
  difference() {
    outer_outline();
    translate([-box_width, -box_length, 0])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness * 2);
  }

  difference() {
    outer_outline(wall_thickness);
    translate([-box_width, -box_length, 3])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness * 2);
  }
}

translate([0, 0, 30])
  upper_part();
bottom_part();
