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

module perimeter_top_double_short() {
  include <perimeter_top_double_short.scad> 
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
        translate([x_min_offset+i*x_offset,j*y_offset,0])
          panel_9x9(); 
      } else {
        translate([x_min_offset+i*x_offset,j*y_offset+h_outer,0])
          panel_9x9();           
          }
  }
}


rotate ([180,-90,180]) {  
  for (i = [0:2]) {
    for (j = [0:1]) {
      if (i%2==0) {
        translate([-x_offset-i*x_offset,j*y_offset+h_outer,0])
          panel_9x9(); 
      } else {
        translate([-x_offset-i*x_offset,j*y_offset,0])
          panel_9x9();           
      }
    }
  }
  
  translate([-3 * x_offset-20, -20, 0]) {
    rotate([0, 0, 180]) {
      right_perimeter();
    }
  }
  
  translate([-3 * x_offset-20, y_offset-80, 0]) {
    rotate([0, 0, 180]) {
      right_perimeter();
    }
  }
  
  translate([-3 * x_offset-20, 2*y_offset-140, 0]) {
    rotate([0, 0, 180]) {
      right_perimeter();
    }
  }
  
  translate([-2*x_offset - 35, -50, 0]) {
    perimeter_top_double();
  }

  translate([-1*x_offset - 58, -50, 0]) {
    perimeter_top_single();
  }
  
  translate([ - 75, -50, 0]) {
    perimeter_top_double_short();
  }

  translate([-2*x_offset-30, 2*y_offset-5, 0]) {
    perimeter_bottom_single();
  }

  //use mirrored double
  translate([-1*x_offset-10, 2*y_offset-5, 0]) {
    perimeter_bottom_double();
  }
  
  translate([0*x_offset-30, 2*y_offset-5, 0]) {
    perimeter_bottom_single();
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


translate([3*x_offset+20, 2.5*h_inner*7-50, 0]) {
  left_perimeter();
}

translate([3*x_offset+20, 2.5*h_inner*14-50, 0]) {
  left_perimeter();
}

translate([3*x_offset+20, 2.5*h_inner*21-50, 0]) {
  left_perimeter();
}



translate([3*x_offset - 18, -50, 0]) {
    perimeter_top_single();
}

translate([2*x_offset, -50, 0]) {
    perimeter_top_double();
}

translate([x_offset - 18, -50, 0]) {
    perimeter_top_single();
}




translate([x_offset+25, 2*y_offset-15, 0]) {
    perimeter_bottom_double();
}

translate([2*x_offset+2, 2*y_offset-15, 0]) {
    perimeter_bottom_single();
}

// mirrow this
translate([3*x_offset+25, 2*y_offset-15, 0]) {
    perimeter_bottom_double();
}


