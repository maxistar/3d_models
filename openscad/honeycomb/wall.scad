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

module right_perimeter() {  
  include <right_perimeter.scad>;    
}

module left_perimeter() {  
  include <left_perimeter.scad>;    
}


module perimeter_top_double() {
  include <perimeter_top_double.scad>
}

module perimeter_top_single() {
  include <perimeter_top_single.scad>
}

module perimeter_bottom_double() {
  include <perimeter_bottom_double.scad>
}

module perimeter_bottom_single() {
  include <perimeter_bottom_single.scad>
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


rotate ([180,-90,180]) {
    
    for (i = [0:2]) {
  for (j = [0:1]) {
      if (i%2==0) {
        translate([-x_offset-i*x_offset,j*y_offset,0])
          panel_9x9(); 
      } else {
        translate([-x_offset-i*x_offset,j*y_offset+h_outer,0])
          panel_9x9();           
          }
  }
}
}

    
 
rotate ([0,270,0]) {
   translate([0, y_offset, 0]) {
     corner_7();
   }

   translate([0, 2*y_offset, 0]) {
     corner_7();
   }
}

left_perimeter();
right_perimeter();
perimeter_top_double();
perimeter_top_single();
perimeter_bottom_double();
perimeter_bottom_single();
 