$fn = 50;

h_outer = 10 + 1.8;
r_outer = h_outer * 2 / sqrt(3);

use <honeycomb_element.scad>;

module panel_9x9() {
  for (i = [0:8]) {
    for (j = [0:7]) {
      if (j % 2 == 0) {
        translate([r_outer * 1.5 * j, h_outer + h_outer * 2 * i, 0])
          panel_with_clips(
            slot_1=i == 0,
            slot_2=j == 7,
            slot_3=j == 7,
            pin_3=i == 8 && j != 7,
            pin_4=i == 8,
            pin_5=i == 8 || j == 0,
            pin_6=j == 0
          );
      } else {
        translate([r_outer * 1.5 * j, h_outer * 2 * i, 0])
          panel_with_clips(
            slot_1=i == 0,
            slot_2=j == 7,
            slot_3=j == 7,
            pin_4=i == 8,
            slot_6=i == 0
          );
      }
    }
  }
}

panel_9x9();
