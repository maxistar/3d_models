$fn = 150;


thickness = 2;

holderHeight = 8;

linseThickness = 2;
linseRadius = 59.75/2;
holderRadius = linseRadius - 0.24;


connectorBallRadius = 4;
connectorCylinderRadius = 3;
smallConnectorCylinderRadius = 2.0;

    connectorLength = 12;
    wallThickness = 2.0;
    cuttingCubeSide = connectorBallRadius*3;
    outerConnectorBallRadius = connectorBallRadius+wallThickness;
    smallCutOffset = 0.5;
    bigCutOffset = 3.2;
    
    cutStarRadius = 0.5;
    cutWidth = 0.4;
    tentionOffset = 0.01;
cutsOffset = 1.2;




module lense_holder_outline() {

translate([holderRadius + thickness + connectorBallRadius + connectorCylinderRadius, 0, 0])
  sphere(r=connectorBallRadius+wallThickness);
  

difference() {
  union() {
    cylinder(r=holderRadius + thickness, h=holderHeight, center=true);
    translate([(holderRadius + thickness + connectorBallRadius + connectorCylinderRadius)/2, 0, 0])
      rotate([0, 90, 0])
        cylinder(r=connectorCylinderRadius, h=holderRadius + thickness + connectorBallRadius + connectorCylinderRadius, center=true);
  }
  
  // the inner holder ouline
  cylinder(r=holderRadius, h=holderHeight*2, center=true);
  
  //lince outline
  cylinder(r=linseRadius, h=linseThickness, center=true);
  
  
  //cone 
  cylinder(h=holderHeight+0.5,r1=holderRadius-0.4, r2=holderRadius+1, center=true);
}

}

module lense_holder() {
    difference() {
        lense_holder_outline();
    
        translate([holderRadius + thickness + connectorBallRadius + connectorCylinderRadius, 0, 0]) {
  sphere(r=connectorBallRadius);
        
            
            translate([outerConnectorBallRadius/2, 0, 0]) {
        rotate([0,-90,0]) {
          cylinder(r1=connectorBallRadius+0.9,r2=connectorBallRadius-0.5, h=outerConnectorBallRadius, center=true);
        }
      }    
        
  translate([-cutsOffset,0,0]) {    
      scale([-1,1,1])
          cuts();
  }
            }
            
    
          
            
    translate([cuttingCubeSide/2+holderRadius + (thickness+connectorBallRadius)*2 + connectorCylinderRadius-bigCutOffset,0,0])
          cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
        }
        

}



    module outer_outline_cutted() {
      // outer outline cutted
      difference() {
        // outer outline  
        union() {
          translate([connectorLength/2, 0, 0]) {
            rotate([0,90,0]) {
              cylinder(r=connectorCylinderRadius, h=connectorLength, center=true);
            }
          }
        
          sphere(r=outerConnectorBallRadius);
    
          translate([connectorLength, 0, 0]) {
            sphere(r=connectorBallRadius+tentionOffset);
          }
        }
      
        translate([-cuttingCubeSide/2-outerConnectorBallRadius+bigCutOffset,0,0])
          cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
    
        translate([cuttingCubeSide/2+connectorBallRadius+connectorLength-smallCutOffset,0,0])
          cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
      }
        
    }
    
    
module terminal_connector_outline() {
      // outer outline cutted
      difference() {
        // outer outline  
        union() {
          translate([connectorLength/2, 0, 0]) {
            rotate([0,90,0]) {
              cylinder(r=smallConnectorCylinderRadius, h=connectorLength, center=true);
            }
          }
          
          translate([connectorCylinderRadius+connectorLength, 0, 0]) {
            rotate([0,90,0]) {
              difference() {
                 cylinder(r=connectorCylinderRadius, h=connectorLength*0.7, center=true);
                 cylinder(r=connectorCylinderRadius/2, h=connectorLength*3, center=true);
              }
            }
          }
              
          sphere(r=outerConnectorBallRadius);
    

        }
      
        translate([-cuttingCubeSide/2-outerConnectorBallRadius+bigCutOffset,0,0])
          cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
    
      }
        
    }
    
    
    module cuts() {
      // round cuts
      cylinder(r=cutStarRadius,h=outerConnectorBallRadius*4, center=true);
    
      rotate([90,0,0])
      cylinder(r=cutStarRadius,h=outerConnectorBallRadius*4, center=true);
    
      // long cuts
      translate([-outerConnectorBallRadius*3/2,0,0])
        cube([outerConnectorBallRadius*3,cutWidth, outerConnectorBallRadius*3], center=true);
    
      rotate([90,0,0]) {
          translate([-outerConnectorBallRadius*3/2,0,0]) {
        cube([outerConnectorBallRadius*3,cutWidth, outerConnectorBallRadius*3], center=true);
        }
      }
        
    }


module connector_element() {
    
    difference() {
      outer_outline_cutted();
      sphere(r=connectorBallRadius);
        
      // enter cone  
      translate([-outerConnectorBallRadius/2, 0, 0]) {
        rotate([0,90,0]) {
          cylinder(r1=connectorBallRadius+0.9,r2=connectorBallRadius-0.5, h=outerConnectorBallRadius, center=true);
        }
      }     

      //translate([cutsOffset,0,0]) {
      //cuts();
      //}

    }

}


module terminal_connector() {
    
    difference() {
      terminal_connector_outline();
      sphere(r=connectorBallRadius);
        
      // enter cone  
      translate([-outerConnectorBallRadius/2, 0, 0]) {
        rotate([0,90,0]) {
          cylinder(r1=connectorBallRadius+0.9,r2=connectorBallRadius-0.5, h=outerConnectorBallRadius, center=true);
        }
      }     

      translate([cutsOffset,0,0]) {
      cuts();
      }

    }

}

module base_holder() {
    translate([connectorLength, 0, 0]) {
            rotate([0,90,0]) {
              cylinder(r=smallConnectorCylinderRadius, h=connectorLength*2, center=true);
            }
          }
          difference() {
          sphere(r=connectorBallRadius+tentionOffset);
          
          
          translate([-cuttingCubeSide/2-connectorBallRadius+smallCutOffset,0,0])
          cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
          }
}


//terminal_connector();

//base_holder();


//lense_holder();


helper_length = 50;
helper_width = 40;

helper_height=3.5;
botton_helper_height=9;
holding_panel_height=2;


small_offset=0.1;
bolt_radius = 2;
panel_offset=2.8;

bolt_offset=7;
bolt_y_offset=helper_length/2-bolt_offset;
bolt_z_offset=helper_width/2-bolt_offset;









module bolts() {
  translate([0, bolt_y_offset, bolt_z_offset])
  rotate([0,90,0])
    cylinder(r=bolt_radius, h=helper_height*10, center=true);

translate([0, -bolt_y_offset, bolt_z_offset])
  rotate([0,90,0])
    cylinder(r=bolt_radius, h=helper_height*10, center=true);

translate([0, -bolt_y_offset, -bolt_z_offset])
  rotate([0,90,0])
    cylinder(r=bolt_radius, h=helper_height*10, center=true);

translate([0, bolt_y_offset, -bolt_z_offset])
  rotate([0,90,0])
    cylinder(r=bolt_radius, h=helper_height*10, center=true);  
}


module top_panel() {
    small_visible_offset = 0.1;  
    
   //translate([0, bolt_y_offset, -bolt_z_offset])
  
    
   difference() {
    
   translate([-helper_height/2-small_offset-panel_offset,0,0])
       
     union() {
       
     cube([helper_height, helper_length, helper_width], center=true);   
       
       translate([2,0,0]) {
         rotate([0,90,0])
           cylinder(r1=connectorCylinderRadius+1.2, r2=connectorCylinderRadius+0.75, h=helper_height, center=true);
       }
           
     }
      
     //cilinder   
     rotate([0,90,0])
       cylinder(r=connectorCylinderRadius+small_visible_offset, h=helper_height*10, center=true);  
       
     //sphere
    translate([0, 0, 0]) {
            sphere(r=connectorBallRadius);
     }  
     
    
     bolts();
     
   }
   
   
   
   
}

module top_holoding_panel() {
    
    
    translate([-helper_height-holding_panel_height/2-small_offset*2-panel_offset,0,0]) {
      difference() {
      
        cube([holding_panel_height, helper_length, helper_width], center=true);
        
        
        rotate([0,90,0])
         cylinder(r=outerConnectorBallRadius+1, h=helper_height*10, center=true);  

      bolts();

        
      }
    }   
    
}


module bottom_holoding_panel() {
    
    
    translate([holding_panel_height/2+botton_helper_height+small_offset-panel_offset,0,0]) {
      difference() {
      
        cube([holding_panel_height, helper_length, helper_width], center=true);
        
        
        rotate([0,90,0])
         cylinder(r=outerConnectorBallRadius+1, h=helper_height*10, center=true);  



      bolts();

        
      }
    }   
    
}

module bottom_panel() {
  
  small_visible_offset = 0.15;  
  
  difference() {
    translate([botton_helper_height/2-panel_offset,0,0])
      cube([botton_helper_height, helper_length, helper_width], center=true);
    
    sphere(r=outerConnectorBallRadius+small_visible_offset);
      
      rotate([0,90,0])
       cylinder(r=connectorCylinderRadius+small_visible_offset, h=helper_height*10, center=true);  
      
    bolts();
  }
}

module two_panels() {
  difference() {
    union() {
        
      top_holoding_panel();
      top_panel();

      
      bottom_panel();
        bottom_holoding_panel();
    }
  
    bolts();
  }
}



/*
difference() {
  union() {
    connector_element();

    translate([-connectorLength,0,0])
      connector_element();
      
    two_panels();
  }

  translate([0,0,connectorLength*2])
    cube([connectorLength*6,connectorLength*6,connectorLength*4], center=true);
}
*/


//connector_element();
//top_holoding_panel();


module top_panel_left() {
  difference() {
  top_panel();
    translate([0,0,connectorLength*2])
      cube([connectorLength*6,connectorLength*6,connectorLength*4], center=true);
  }
}

module top_panel_right() {
  intersection() {
  top_panel();
    translate([0,0,connectorLength*2])
      cube([connectorLength*6,connectorLength*6,connectorLength*4], center=true);
  }
}


module bottom_panel_left() {
  difference() {
  bottom_panel();
    translate([0,connectorLength*3,0])
      cube([connectorLength*6,connectorLength*6,connectorLength*4], center=true);
  }
}

module bottom_panel_right() {
  intersection() {
  bottom_panel();
    translate([0,connectorLength*3,0])
      cube([connectorLength*6,connectorLength*6,connectorLength*4], center=true);
  }
}


//top_panel_left();
top_panel_right();


/*
difference() {
  connector_element();
    translate([0,-25,0]) {
      cube([50,50,50], center=true);
    }
}
*/

