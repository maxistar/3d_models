$fn = 100;

hook_height = 60;
hook_width = 20;
hook_thickness = 4;
hook_round_circle = 7;


hole_radius = 4;




difference() {
  union() {
    cube([hook_height, hook_width, hook_thickness], center=true);

    translate([hook_height / 2, hook_width / 2, 0])
      cylinder(r=hook_round_circle, h=hook_thickness, center=true);

    translate([-hook_height / 2, hook_width / 2, 0])
      cylinder(r=hook_round_circle, h=hook_thickness, center=true);

    translate([-hook_height / 2, -hook_width / 2, 0])
      cylinder(r=hook_round_circle, h=hook_thickness, center=true);

    translate([hook_height / 2, -hook_width / 2, 0])
      cylinder(r=hook_round_circle, h=hook_thickness, center=true);
  }

  union() {

    cylinder(r=hole_radius, h=30, center=true);

    translate([15, 0, 0]) {
      cylinder(r=hole_radius, h=30, center=true);
    }

    translate([-15, 0, 0]) {
      cylinder(r=hole_radius, h=30, center=true);
    }

    translate([15, 10, 0])
      cube([hole_radius, 20, 30], center=true);

    translate([-15, -10, 0])
      cube([hole_radius, 20, 30], center=true);



          translate([hook_height / 2, hook_width / 2, 0])
      cylinder(r=hole_radius, h=30, center=true);

    translate([-hook_height / 2, hook_width / 2, 0])
      cylinder(r=hole_radius, h=30, center=true);

    translate([-hook_height / 2, -hook_width / 2, 0])
      cylinder(r=hole_radius, h=30, center=true);

    translate([hook_height / 2, -hook_width / 2, 0])
      cylinder(r=hole_radius, h=30, center=true);


translate([0,hook_width / 2 + hole_radius / 4,0])
  cube([hook_height, hole_radius, 30], center=true);

translate([0,-hook_width / 2 - hole_radius / 4,0])
  cube([hook_height, hole_radius, 30], center=true);        
  }
}

