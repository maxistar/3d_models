$fn = 50;

h_outer = 10 + 1.8;
r_outer = h_outer * 2 / sqrt(3);

use <honeycomb_element.scad>;

module perimeter_top_item(left_slot = false, top_slot = false) {
  difference() {
    translate([0, h_outer, 0])
      panel_with_clips(slot_1=top_slot, slot_2=left_slot);

    translate([0, 50 + h_outer, 0])
      cube([100, 100, 100], center=true);
  }

  translate([-r_outer * 1.5, 0, 0])
    panel_with_clips(slot_1=true, slot_2=true, pin_5=true);

  translate([-r_outer * 3, -h_outer, 0])
    panel_with_clips(slot_1=true, slot_2=true, slot_6=true, pin_5=true);

  translate([0, h_outer - r_outer, 0])
    rotate([90, 0, 90])
      linear_extrude(height=r_outer * 2, center=true)
        basic_polygon();
}

module perimeter_bottom() {
  perimeter_top_item(left_slot=true, top_slot=true);

  translate([-3 * r_outer, 0, 0])
    perimeter_top_item();

  translate([-6 * r_outer, 0, 0])
    perimeter_top_item();

  translate([-9 * r_outer, 0, 0])
    perimeter_top_item();
}

perimeter_bottom();
