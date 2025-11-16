
wall_width = 195;
wall_height = 330;

$fn = 50;

h_outer = 10 + 1.8;
r_outer = h_outer * 2 / sqrt(3);





use <honeycomb_element.scad>;


module panel_9x9() {
  for (i = [0:13]) {
    for (j = [0:9]) {
      if (j % 2 == 0) {
        translate([r_outer * 1.5 * j, h_outer + h_outer * 2 * i, 0])
          panel_with_clips(
            //slot_1=i == 0,
            //slot_2=j == 7,
            //slot_3=j == 7,
            //pin_3=i == 8 && j != 7,
            //pin_4=i == 8,
            //pin_5=i == 8 || j == 0,
            //pin_6=j == 0
          );
      } else {
        translate([r_outer * 1.5 * j, h_outer * 2 * i, 0])
          panel_with_clips(
            //slot_1=i == 0,
            //slot_2=j == 7,
            //slot_3=j == 7,
            //pin_4=i == 8,
            //slot_6=i == 0
          );
      }
    }
  }
}

x_offset = -6;
y_offset = -6;

intersection() {
  translate([x_offset,y_offset,-10])
    cube([wall_width, wall_height, 40]);
  panel_9x9();
}

  //translate([x_offset,y_offset,-10])
  //  cube([wall_width, wall_height, 40]);

translate([0 + wall_width-r_outer+x_offset, wall_height/2+y_offset, 0])
  rotate([90, 0, 0])
    linear_extrude(height=wall_height, center=true)
      basic_polygon();

translate([0 +r_outer+x_offset, wall_height/2+y_offset, 0])
  rotate([90, 0, 180])
    linear_extrude(height=wall_height, center=true)
      basic_polygon();

translate([wall_width/2+x_offset, wall_height-h_outer+y_offset-1.8, 0])
  rotate([90, 0, 90])
    linear_extrude(height=wall_width, center=true)
      basic_polygon();

translate([wall_width/2+x_offset, h_outer+y_offset+1.8, 0])
  rotate([90, 0, -90])
    linear_extrude(height=wall_width, center=true)
      basic_polygon();