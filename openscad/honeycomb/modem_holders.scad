$fn = 50;


h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);




use <honeycomb_element.scad>;


module panel_9x9() {
    for (i = [0:8]) {
        for (j = [0:8]) {
            if (j%2==0) {
               translate([r_outer*1.5*j, h_outer+h_outer*2*i, 0])
                  panel_with_clips(
                    slot_1 = i == 0,
                    slot_2 = j == 8,               
                    slot_3 = j == 8,  
                    pin_3 = i == 8 && j != 8,    
                    pin_4 = i == 8,
                    pin_5 = i == 8 || j == 0,
                    pin_6 = j == 0
                    
                  );
            } else {
               translate([r_outer*1.5*j, h_outer*2*i, 0])
                  panel_with_clips(
                    slot_1 = i == 0,
                    slot_2 = i == 0,
                    pin_4 = i == 8,
                    slot_6 = i == 0
                  );
            }
        }
    }
}

//panel_9x9();



length_inner = 9;
length_outer = 5;
length_center = 18;
length_total = 40;
inner_diametr = 15.4;

deep_offset = -3;


module plug() {
    translate([0,0,length_total/2]) {
        cylinder(r=inner_diametr/2, h=length_total, center=true, $fn=6);
    }
} 

module rounter() {
   linear_extrude(27, center=true) {
       minkowski() {
          square([59-20, 100-20], center=true);
            circle(r=10);
       }
    }
}

difference() {

union() {
    /*
  translate([0*r_outer,h_outer,0]) {
    plug();
  }
    
  
  
  translate([0*r_outer,h_outer*9,0]) {
    plug();
  }
    
  
  
  translate([3*r_outer,h_outer,0]) {
    plug();
  }
    */
  
  translate([3*r_outer,h_outer*9,0]) {
    plug();
  }
  }

  translate([21,59,length_center/2+length_inner+5]) {
    //cube([59, 100, 27], center=true);
    rounter();  
  }
  
  translate([21,59,length_center/2+length_inner+5+30]) {
    rounter();  
  }
}