$fn = 50;


h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);

use <honeycomb_element.scad>; 

module perimeter_right_item(slot_5=true, slot_6=true) {
  difference() {
      translate([r_outer * 1.5, 0, 0])
        panel_with_clips(slot_6=slot_6, slot_5=slot_5);
      translate([50+r_outer * 1.5-r_outer/2 + (r_outer-h_outer), 0, 0])
        cube([100, 100, 100], center = true);
  }
  translate([0 + r_outer-h_outer, 0, 0])
    rotate([90, 0, 0])
      linear_extrude(height = h_outer * 2, center=true)
        basic_polygon();
}



module perimeter_right() {  
    
    for (i = [0:3]) {    
      translate([0, -h_outer*2*i, 0])
        perimeter_right_item();   
    }
}



perimeter_right();


