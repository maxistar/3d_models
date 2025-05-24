$fn=180;

monitor_width=500;
monitor_height=300;
monitor_depth=20;

thing_width  = 35;
thing_height = 55;
thing_depth  = 45;

thing_y_offset = 5;

side_thinkness = 3;


module monitor() {
    
    cube([monitor_width, monitor_depth, monitor_height], center=true);
}




module outline (width=35, height=55, depth=45, roundness=5) {
    minkowski() {
     sphere(roundness);     
     cube([width-roundness*2,depth-roundness*2, height-roundness*2], center=true);   
    }
}


module main_module() {
  
  difference() {
    translate([0, monitor_depth/2 + thing_y_offset, monitor_height/2]) {
        difference() {
          outline(width=thing_width, height = thing_height, depth = thing_depth);
          outline(width=thing_width-side_thinkness*2, height = thing_height-side_thinkness*2, depth = thing_depth-side_thinkness*2);
        }
    }
    
    // top cut
    translate([0, 0, monitor_height/2+side_thinkness+thing_height/2])
      cube([monitor_width, monitor_depth*10, thing_height], center=true);
  }
  
  difference() {
  translate([0, monitor_depth/2, monitor_height/2]) 
  outline(width=thing_width, height = 20, depth = thing_depth);
          // top cut
    translate([0, 0, monitor_height/2+side_thinkness+thing_height/2])
      cube([monitor_width, monitor_depth*10, thing_height], center=true);
            translate([0, monitor_depth+17, 0])
  cube([monitor_width, 50, monitor_height+40], center=true);   

  }

 

  
}

main_module();

/*
difference() {
  difference()
   outline(width=thing_width, height = thing_height, depth = thing_depth);
   outline(width=thing_width-side_thinkness*2, height = thing_height-side_thinkness*2, depth = thing_depth-side_thinkness*2);
  cube(100, 100, 100);
}
*/

monitor();