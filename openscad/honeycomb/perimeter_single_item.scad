$fn = 50;

h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);


use <honeycomb_element.scad>;

module perimeter_top_item(left_slot=false,top_slot=false) {
  translate([-r_outer*0, -h_outer, 0])
     panel_with_clips(slot_1=true, slot_2=true, pin_5=true, pin_4=true);   
  

    
}




module perimeter_bottom() {
    perimeter_top_item(left_slot=true,top_slot=true);

}



perimeter_bottom();

