$fn = 50;

h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);

use <honeycomb_element.scad>;

module perimeter_top_item(left_slot=true, left_pin=false) {
  intersection() {
    translate([0, h_outer, 0])
        panel_with_clips(pin_4=true);  
    
    translate([0, 50+h_outer, 0])
        cube([100, 100, 100], center = true);
  }
  
  translate([r_outer*1.5, 2*h_outer, 0])
     panel_with_clips(slot_2=true, slot_3=left_slot, pin_3=left_pin, pin_4=true, pin_5=true); 
  
    
  translate([0, -(h_outer-r_outer)+2*h_outer, 0])
      rotate([90, 0, -90])
        linear_extrude(height = r_outer * 2, center=true)
          basic_polygon();
    
}




module perimeter_bottom() {
    perimeter_top_item();
    
    translate([-3*r_outer, 0, 0])
      perimeter_top_item(left_slot=false, left_pin=true);

    translate([-6*r_outer, 0, 0])
      perimeter_top_item(left_slot=false, left_pin=true);    
    
    translate([-9*r_outer, 0, 0])
      perimeter_top_item(left_slot=false, left_pin=true);    
    
}



module perimeter_corner() {
    
    perimeter_bottom();
    
    //perimeter_left();


}



module wall_corner_perimeter() {
    
}


//wall_corner();
perimeter_corner();
//perimeter_corner();
//
//wall_corner_side_element();

