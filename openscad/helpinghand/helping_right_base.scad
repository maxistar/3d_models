use <helping_hand.scad>;

module base_holder_short_rotated() {
  rotate([0, 90, 0]) {
    base_holder_short();
  }
}

module left_plate() {
  x_offset = 65;  
  y_offset = 25;
  translate([x_offset, y_offset, 7]) {
    base_holder_short_rotated();
  }

  translate([x_offset, -y_offset, 7]) {
    base_holder_short_rotated();
  }

  translate([-x_offset, -y_offset, 7]) {
    base_holder_short_rotated();
  }

  translate([-x_offset, y_offset, 7]) {
    base_holder_short_rotated();
  }

  cube([150, 70, 2], center=true);
}

//left_plate();

module right_plate() {
  x_offset = 55;  
  y_offset = 25;
  translate([x_offset, y_offset, 7]) {
    base_holder_short_rotated();
  }

  translate([x_offset, -y_offset, 7]) {
    base_holder_short_rotated();
  }

  translate([-x_offset, -y_offset, 7]) {
    base_holder_short_rotated();
  }

  translate([-x_offset, y_offset, 7]) {
    base_holder_short_rotated();
  }

  cube([150, 70, 2], center=true);
}

right_plate();