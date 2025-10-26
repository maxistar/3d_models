box_side = 180;
box_height = 40;
pot_radius = 70;
hole_radius = 40;
pot_depression = 5;
$fn = 150;

thickness = 2;
tube_hole_radius = 3;

difference() {
  cube([box_side, box_side, box_height], center=true);

  translate([0, 0, box_height / 2])
    cylinder(r=pot_radius, h=pot_depression * 2, center=true);

  difference() {
    cube([box_side - 2 * thickness, box_side - 2 * thickness, box_height - 2 * thickness], center=true);

    translate([0, 0, box_height / 2 - thickness])
      cylinder(r=pot_radius + thickness, h=pot_depression * 2, center=true);
  }

  translate([0, 0, box_height / 2])
    cylinder(r=hole_radius, h=pot_depression * 5, center=true);

  translate([0, pot_radius - 5, box_height / 2])
    cylinder(r=tube_hole_radius, h=pot_depression * 5, center=true);
}
