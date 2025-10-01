$fn = 50;


h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);




use <honeycomb_element.scad>;


module panel_9x9() {
    for (i = [0:9]) {
               translate([0, h_outer+h_outer*2*i, 0])
                  panel_with_clips(
                    
                    slot_2 = true,
                    slot_3 = true,    
                    
                    pin_5 = true,
                    pin_6 = true           
                  );
    }
}

panel_9x9();