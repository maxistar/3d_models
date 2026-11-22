/**
  * Charger station for two phones.
  *
  * @author Max Starikov
  * @license MIT




todo:
- make the upeer part tilted
- add crew connections

  */

$fn = 50;

box_width = 200;
box_length = 120;
box_height = 50;
split_level = -10;
corner_radius = 10;
wall_thickness = 2;
joint_height = 3;
joint_clearance = 0.1;
foot_width = 10;
foot_length = 10;
foot_radius = 2;
foot_recess_depth = 0.5;
foot_edge_distance = 10;
power_hole_diameter = 7;
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
    rounded_rectangle(
      box_width - offset + 2 * side_clearance,
      box_length - offset + 2 * side_clearance,
      corner_radius
    );
}

module foot_recesses() {
  for (x = [-1, 1])
    for (y = [-1, 1])
      translate(
        [
          x * (box_width / 2 - foot_edge_distance - foot_width / 2),
          y * (box_length / 2 - foot_edge_distance - foot_length / 2),
          -box_height / 2 - boolean_overlap,
        ]
      )
        linear_extrude(height=foot_recess_depth + boolean_overlap)
          rounded_rectangle(foot_width, foot_length, foot_radius);
}

module power_connector_hole() {
  translate([
    box_width / 2 - wall_thickness / 2,
    40,
    (-box_height / 2 + split_level) / 2
  ])
    rotate([0, 90, 0])
      cylinder(
        d=power_hole_diameter,
        h=wall_thickness + 2 * boolean_overlap,
        center=true
      );
}

module outer_outline_with_phones(wall_thickness = 0) {
  difference() {
    outer_outline(wall_thickness);
    phone_outlines(-wall_thickness);
  }
}


module upper_part() {

          //phone_outlines();


  difference() {

    outer_outline_with_phones();
    
    translate([-box_width, -box_length, split_level + joint_height - box_height])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline_with_phones(wall_thickness * 2);

  }

  difference() {
    outer_outline_with_phones();
    translate([-box_width, -box_length, split_level - box_height])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness, joint_clearance);
  }
}

module bottom_part() {
  difference() {
    outer_outline();
    translate([-box_width, -box_length, split_level])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness * 2);
    foot_recesses();
    power_connector_hole();
  }

  difference() {
    outer_outline(wall_thickness);
    translate([-box_width, -box_length, split_level + joint_height])
      cube([2 * box_width, 2 * box_length, box_height]);
    outer_outline(wall_thickness * 2);
    power_connector_hole();
  }
}

module phone_outlines(wall_thickness = 0) {
  translate([46, 26, 35])
    rotate([10, 0, 0])
      phone_outline(wall_thickness);

  translate([-46, 26, 35])
    rotate([10, 0, 0])
      phone_outline(wall_thickness);
}

module phone_outline(wall_thickness = 0) {
  cube([85 - 2 * wall_thickness, 150- 2 * wall_thickness, 30- 2 * wall_thickness], center=true);

  cube([35- 2 * wall_thickness, 200- 2 * wall_thickness, 30- 2 * wall_thickness ], center=true);
}

translate([0, 0, 30])
  upper_part();
bottom_part();
