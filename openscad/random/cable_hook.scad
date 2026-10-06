$fn = 100;

hook_height = 50;
hook_width = 15;
hook_thickness = 4;


difference() {
  union() {
    cube([hook_height, hook_width, hook_thickness], center=true);

    translate([hook_height / 2, hook_width / 2, 0])
      cylinder(r=5, h=hook_thickness, center=true);

    translate([-hook_height / 2, hook_width / 2, 0])
      cylinder(r=5, h=hook_thickness, center=true);

    translate([-hook_height / 2, -hook_width / 2, 0])
      cylinder(r=5, h=hook_thickness, center=true);

    translate([hook_height / 2, -hook_width / 2, 0])
      cylinder(r=5, h=hook_thickness, center=true);
  }

  union() {

    cylinder(r=4, h=30, center=true);

    translate([15, 0, 0]) {
      cylinder(r=4, h=30, center=true);
    }

    translate([-15, 0, 0]) {
      cylinder(r=4, h=30, center=true);
    }

    translate([15, 10, 0])
      cube([4, 20, 30], center=true);

    translate([-15, -10, 0])
      cube([4, 20, 30], center=true);
  }
}
