$fn = 50;

box_width = 200;
box_length = 100;
box_height = 50;
corner_radius = 10;
wall_thickness = 2;
joint_height = 3;
joint_clearance = 0.1;
foot_width = 10;
foot_length = 10;
foot_radius = 2;
foot_recess_depth = 0.5;
foot_edge_distance = 10;
boolean_overlap = 0.1;

module rounded_rectangle(width, length, radius) {
  hull() {
    for (x = [-width / 2 + radius, width / 2 - radius])
      for (y = [-length / 2 + radius, length / 2 - radius])
        translate([x, y]) circle(r=radius);
  }
}

module outer_outline(offset = 0, side_clearance = 0) {
  linear_extrude(height=box_height - offset, center=true)
    rounded_rectangle(box_width - offset + 2 * side_clearance,
                      box_length - offset + 2 * side_clearance,
                      corner_radius);
}

module foot_recesses() {
  for (x = [-1, 1])
    for (y = [-1, 1])
      translate([
        x * (box_width / 2 - foot_edge_distance - foot_width / 2),
        y * (box_length / 2 - foot_edge_distance - foot_length / 2),
        -box_height / 2 - boolean_overlap
      ])
        linear_extrude(height=foot_recess_depth + boolean_overlap)
          rounded_rectangle(foot_width, foot_length, foot_radius);
}

module upper_part() {
  difference() {
    outer_outline();
    translate([-box_width, -box_length, -box_height + joint_height])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness * 2);
  }

  difference() {
    outer_outline();
    translate([-box_width, -box_length, -box_height])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness, joint_clearance);
  }
}

module bottom_part() {
  difference() {
    outer_outline();
    translate([-box_width, -box_length, 0])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness * 2);
    foot_recesses();
  }

  difference() {
    outer_outline(wall_thickness);
    translate([-box_width, -box_length, joint_height])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness * 2);
  }
}

translate([0, 0, 30])
  upper_part();
bottom_part();
