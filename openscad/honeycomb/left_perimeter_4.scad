$fn = 50;

h_outer = 10 + 1.8;
r_outer = h_outer * 2 / sqrt(3);

use <honeycomb_element.scad>;

module perimeter_left_item(pin_5 = true, pin_6 = true) {
  difference() {
    translate([r_outer * 1.5, 0, 0])
      panel_with_clips(pin_6=pin_6, pin_5=pin_5);
    translate([50 + r_outer * 1.5 - r_outer / 2 + (r_outer - h_outer), 0, 0])
      cube([100, 100, 100], center=true);
  }
  translate([0 + r_outer - h_outer, 0, 0])
    rotate([90, 0, 0])
      linear_extrude(height=h_outer * 2, center=true)
        basic_polygon();
}

module perimeter_left() {

  for (i = [0:3]) {
    translate([0, -h_outer * 2 * i, 0])
      perimeter_left_item();
  }
}

perimeter_left();
