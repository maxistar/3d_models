$fn = 50;

radius = 13.6;
diameter =  radius * 2;

h_inner = 10;
r_inner = h_inner * 2/sqrt(3);

h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);


h_thin = 10+1;
r_thin = h_thin * 2/sqrt(3);

total_height = 8;

small_value = 0.1;


clips_height = 5;
clips_offset = 0.5;
clips_side_offset = 0.00;


module basic_polygon() {
  polygon([[r_outer, total_height], [r_outer, 0], [r_inner+0.5, 0], [r_inner, 0.5], 
        [r_inner, total_height-3], [r_inner+1, total_height-2], [r_inner+1,total_height]]);    
}

module basic_model() {
  rotate_extrude($fn=6) {
      basic_polygon();
  }
}


module panel_with_clips(pin_1=false, pin_2=false, pin_3=false, pin_4=false, pin_5=false, pin_6=false, slot_1=false, slot_2=false, slot_3=false, slot_4=false, slot_5=false, slot_6=false) {

  difference() {
    basic_model();

    if (slot_1) {
      rotate([0, 0, 0])
        translate([0, -h_outer*2, total_height - (clips_height+clips_offset)/2])
          linear_extrude(height=clips_height+clips_offset, center=true)
            polygon([[clips_side_offset, h_outer/2], [-clips_side_offset, h_outer/2], [-r_outer/2-clips_side_offset, h_outer*1.5], [r_outer/2+clips_side_offset, h_outer*1.5]]);
    }

    if (slot_2) {
      rotate([0, 0, 60])
        translate([0, -h_outer*2, total_height - (clips_height+clips_offset)/2])
          linear_extrude(height=clips_height+clips_offset, center=true)
            polygon([[clips_side_offset, h_outer/2], [-clips_side_offset, h_outer/2], [-r_outer/2-clips_side_offset, h_outer*1.5], [r_outer/2+clips_side_offset, h_outer*1.5]]);
    }



    if (slot_3) {
      rotate([0, 0, 120])
        translate([0, -h_outer*2, total_height - (clips_height+clips_offset)/2])
          linear_extrude(height=clips_height+clips_offset, center=true)
            polygon([[clips_side_offset, h_outer/2], [-clips_side_offset, h_outer/2], [-r_outer/2-clips_side_offset, h_outer*1.5], [r_outer/2+clips_side_offset, h_outer*1.5]]);
    }

    if (slot_4) {
      rotate([0, 0, 180])
        translate([0, -h_outer*2, total_height - (clips_height+clips_offset)/2])
          linear_extrude(height=clips_height+clips_offset, center=true)
            polygon([[clips_side_offset, h_outer/2], [-clips_side_offset, h_outer/2], [-r_outer/2-clips_side_offset, h_outer*1.5], [r_outer/2+clips_side_offset, h_outer*1.5]]);
    }

    if (slot_5) {
      rotate([0, 0, 240])
        translate([0, -h_outer*2, total_height - (clips_height+clips_offset)/2])
          linear_extrude(height=clips_height+clips_offset, center=true)
            polygon([[clips_side_offset, h_outer/2], [-clips_side_offset, h_outer/2], [-r_outer/2-clips_side_offset, h_outer*1.5], [r_outer/2+clips_side_offset, h_outer*1.5]]);
    }

    if (slot_6) {
      rotate([0, 0, 300])
        translate([0, -h_outer*2, total_height - (clips_height+clips_offset)/2])
          linear_extrude(height=clips_height+clips_offset, center=true)
            polygon([[clips_side_offset, h_outer/2], [-clips_side_offset, h_outer/2], [-r_outer/2-clips_side_offset, h_outer*1.5], [r_outer/2+clips_side_offset, h_outer*1.5]]);
    }
  }


  if (pin_1) {
    intersection() {
      translate([0,-h_outer*2, 0])
        basic_model();
      translate([0, 0, total_height - clips_height/2]) {
        rotate([0, 0, -180])  
          linear_extrude(height=clips_height, center=true)
            polygon([[0, h_outer/2], [-r_outer/2, h_outer*1.5], [r_outer/2, h_outer*1.5]]);  
      }
    }
  }

  if (pin_2) {
    intersection() {
      translate([r_outer*1.5,-h_outer, 0])
        basic_model();
      translate([0, 0, total_height - clips_height/2]) {
        rotate([0, 0, -120])  
          linear_extrude(height=clips_height, center=true)
            polygon([[0, h_outer/2], [-r_outer/2, h_outer*1.5], [r_outer/2, h_outer*1.5]]);  
      }
    }
  }


  if (pin_3) {
    intersection() {
      translate([r_outer*1.5,h_outer, 0])
        basic_model();
      translate([0, 0, total_height - clips_height/2]) {
        rotate([0, 0, -60])  
          linear_extrude(height=clips_height, center=true)
            polygon([[0, h_outer/2], [-r_outer/2, h_outer*1.5], [r_outer/2, h_outer*1.5]]);  
      }
    }
  }

  if (pin_4) {
    intersection() {
      translate([0, h_outer*2, 0])
        basic_model();

      translate([0, 0, total_height - clips_height/2]) {
        linear_extrude(height=clips_height, center=true)
          polygon([[0, h_outer/2], [-r_outer/2, h_outer*1.5], [r_outer/2, h_outer*1.5]]);
      }  
    }
  }

  if (pin_5) {
    intersection() {
      translate([-r_outer*1.5,h_outer, 0])
        basic_model();
      translate([0, 0, total_height - clips_height/2]) {
        rotate([0, 0, 60])  
          linear_extrude(height=clips_height, center=true)
            polygon([[0, h_outer/2], [-r_outer/2, h_outer*1.5], [r_outer/2, h_outer*1.5]]);  
      }
    }
  }
  
  if (pin_6) {
    intersection() {
      translate([-r_outer*1.5, -h_outer, 0])
        basic_model();

      translate([0, 0, total_height - clips_height/2]) {
        rotate([0, 0, 120])  
          linear_extrude(height=clips_height, center=true)
            polygon([[0, h_outer/2], [-r_outer/2, h_outer*1.5], [r_outer/2, h_outer*1.5]]);  
      }
    }
  }
}

// end honeycomb_element.scad

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

panel_9x9();