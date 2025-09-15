$fn = 150;


thickness = 1;

holderHeight = 8;

linseThickness = 2;
linseRadius = 59.75/2;
holderRadius = linseRadius - 0.24;


connectorBallRadius = 4;
connectorCylinderRadius = 3;



module lense_holder() {

translate([holderRadius + thickness + connectorBallRadius + connectorCylinderRadius, 0, 0])
  sphere(r=connectorBallRadius);
  

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
  cylinder(h=holderHeight+0.5,r1=holderRadius-0.5, r2=holderRadius+0.5, center=true);
}

}

//lense_holder();


module connector_element() {
    
    connectorLength = 12;
    wallThickness = 2.0;
    cuttingCubeSide = connectorBallRadius*3;
    outerConnectorBallRadius = connectorBallRadius+wallThickness;
    smallCutOffset = 1.5;
    bigCutOffset = 2.2;
    
    cutStarRadius = 0.5;
    cutWidth = 0.4;
    tentionOffset = 0.05;



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
    
    
 
    
    difference() {
      outer_outline_cutted();
      sphere(r=connectorBallRadius);
        
      // enter cone  
      translate([-outerConnectorBallRadius/2, 0, 0]) {
        rotate([0,90,0]) {
          cylinder(r1=connectorBallRadius+0.9,r2=connectorBallRadius-0.5, h=outerConnectorBallRadius, center=true);
        }
      }     

      //translate([1.2,0,0]) {
      //cuts();
      //}

    }
    
    

    

}

connector_element();

/*
difference() {
  connector_element();
    translate([0,-25,0]) {
      cube([50,50,50], center=true);
    }
}
*/

