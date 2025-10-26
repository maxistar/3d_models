box_side = 170;
box_height = 40;
pot_radius = 60;
hole_radius = 40;
pot_depression = 5;
$fn = 250;

thickness = 2.5;
tube_hole_radius = 3;

electronics_box_width = 30;

//translate([0, box_side-2-electronics_box_width, 0]) 
//cube([box_side, box_side, box_side], center = true);

//module inner_body_outline () {

//}

difference() {
  cylinder(d=box_side, h=box_height, center=true);

  translate([0, 0, box_height / 2])
    cylinder(r=pot_radius, h=pot_depression * 2, center=true);

  difference() {
    cylinder(d=box_side - 2 * thickness, h=box_height - 2 * thickness, center=true);

    translate([0, 0, box_height / 2 - thickness])
      cylinder(r=pot_radius + thickness, h=pot_depression * 2, center=true);

    translate([0, box_side - electronics_box_width, 0])
      cube([box_side, box_side, box_side], center=true);
  }

  translate([0, 0, box_height / 2])
    cylinder(r=hole_radius, h=pot_depression * 5, center=true);

  // tube whole
  translate([0, pot_radius + 7, box_height / 2])
    cylinder(r=tube_hole_radius, h=pot_depression * 5, center=true);

  // electronics box
  difference() {
    translate([0, 0, -thickness])
      cylinder(d=box_side - 2 * thickness, h=box_height, center=true);

    translate([0, 0, box_height / 2 - thickness])
      cylinder(r=pot_radius + thickness, h=pot_depression * 2, center=true);

    translate([0, -electronics_box_width + thickness, 0])
      cube([box_side, box_side, box_side], center=true);
  }

  translate([40, 60, box_height / 2 - tube_hole_radius - thickness])
    rotate([0, 90, 90])
      cylinder(r=tube_hole_radius, h=pot_depression * 2, center=true);
}
