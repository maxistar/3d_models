$fn = 50;

radius = 13.6;
diameter = radius * 2;

h_inner = 10;
r_inner = h_inner * 2/sqrt(3);

h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);

x_offset = 200;
y_offset = 250;

x_min_offset=40;


module panel_9x9() {  
  include <panel_9x9.scad>;    
}

module corner_7() {  
  include <corner_7.scad>;    
}


for (i = [0:2]) {
  for (j = [0:1]) {
      if (i%2==0) {
        translate([x_min_offset+i*x_offset,j*y_offset+h_outer,0])
          panel_9x9(); 
      } else {
        translate([x_min_offset+i*x_offset,j*y_offset,0])
          panel_9x9();           
          }
  }
}

rotate ([0,-90,0]) {
    
    for (i = [0:2]) {
  for (j = [0:1]) {
      if (i%2==0) {
        translate([x_min_offset+i*x_offset,j*y_offset,0])
          panel_9x9(); 
      } else {
        translate([x_min_offset+i*x_offset,j*y_offset+h_outer,0])
          panel_9x9();           
          }
  }
}
    
    }
 rotate ([0,0,180]) {   
    corner_7();
 }