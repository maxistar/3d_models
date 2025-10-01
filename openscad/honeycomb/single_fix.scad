$fn = 50;

h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);


use <honeycomb_element.scad>;

module perimeter_top_item(left_slot=false, inner_slot=false, middle_slot=false) {

  
  translate([r_outer*1.5, 0, 0])
     panel_with_clips(slot_1=false); 
  
  translate([r_outer*1.5, -2*h_outer, 0])
     panel_with_clips(slot_1=true, slot_2=true,  slot_6=true); 
    
    
  translate([1.5 * r_outer, h_outer-r_outer, 0])
      rotate([90, 0, 90])
        linear_extrude(height = r_outer, center=true)
          basic_polygon();
    
}




module perimeter_bottom() {
    
    perimeter_top_item();
    


}

perimeter_bottom();
