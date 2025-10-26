$fn = 150;

thickness = 2;

holderHeight = 8;

linseThickness = 2;
linseRadius = 59.75 / 2;
holderRadius = linseRadius - 0.24;

connectorBallRadius = 4;
connectorCylinderRadius = 3;
smallConnectorCylinderRadius = 2.0;

connectorLength = 12;
wallThickness = 2.0;
cuttingCubeSide = connectorBallRadius * 3;
outerConnectorBallRadius = connectorBallRadius + wallThickness;
smallCutOffset = 1.5;
bigCutOffset = 3.2;

cutStarRadius = 0.5;
cutWidth = 0.4;
tentionOffset = 0.01;
cutsOffset = 1.2;

module lense_holder_outline() {

  translate([holderRadius + thickness + connectorBallRadius + connectorCylinderRadius, 0, 0])
    sphere(r=connectorBallRadius + wallThickness);

  difference() {
    union() {
      cylinder(r=holderRadius + thickness, h=holderHeight, center=true);
      translate([(holderRadius + thickness + connectorBallRadius + connectorCylinderRadius) / 2, 0, 0])
        rotate([0, 90, 0])
          cylinder(r=connectorCylinderRadius, h=holderRadius + thickness + connectorBallRadius + connectorCylinderRadius, center=true);
    }

    // the inner holder ouline
    cylinder(r=holderRadius, h=holderHeight * 2, center=true);

    //lince outline
    cylinder(r=linseRadius, h=linseThickness, center=true);

    //cone 
    cylinder(h=holderHeight + 0.5, r1=holderRadius - 0.4, r2=holderRadius + 1, center=true);
  }
}

module lense_holder() {
  difference() {
    lense_holder_outline();

    translate([holderRadius + thickness + connectorBallRadius + connectorCylinderRadius, 0, 0]) {
      sphere(r=connectorBallRadius);

      translate([outerConnectorBallRadius / 2, 0, 0]) {
        rotate([0, -90, 0]) {
          cylinder(r1=connectorBallRadius + 0.9, r2=connectorBallRadius - 0.5, h=outerConnectorBallRadius, center=true);
        }
      }

      translate([-cutsOffset, 0, 0]) {
        scale([-1, 1, 1])
          cuts();
      }
    }

    translate([cuttingCubeSide / 2 + holderRadius + (thickness + connectorBallRadius) * 2 + connectorCylinderRadius - bigCutOffset, 0, 0])
      cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
  }
}

module outer_outline_cutted() {
  // outer outline cutted
  difference() {
    // outer outline  
    union() {
      translate([connectorLength / 2, 0, 0]) {
        rotate([0, 90, 0]) {
          cylinder(r=connectorCylinderRadius, h=connectorLength, center=true);
        }
      }

      sphere(r=outerConnectorBallRadius);

      translate([connectorLength, 0, 0]) {
        sphere(r=connectorBallRadius + tentionOffset);
      }
    }

    translate([-cuttingCubeSide / 2 - outerConnectorBallRadius + bigCutOffset, 0, 0])
      cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);

    translate([cuttingCubeSide / 2 + connectorBallRadius + connectorLength - smallCutOffset, 0, 0])
      cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
  }
}

module terminal_connector_outline() {
  // outer outline cutted
  difference() {
    // outer outline  
    union() {
      translate([connectorLength / 2, 0, 0]) {
        rotate([0, 90, 0]) {
          cylinder(r=smallConnectorCylinderRadius, h=connectorLength, center=true);
        }
      }

      translate([connectorCylinderRadius + connectorLength, 0, 0]) {
        rotate([0, 90, 0]) {
          difference() {
            cylinder(r=connectorCylinderRadius, h=connectorLength * 0.7, center=true);
            cylinder(r=connectorCylinderRadius / 2, h=connectorLength * 3, center=true);
          }
        }
      }

      sphere(r=outerConnectorBallRadius);
    }

    translate([-cuttingCubeSide / 2 - outerConnectorBallRadius + bigCutOffset, 0, 0])
      cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
  }
}

module cuts() {
  // round cuts
  cylinder(r=cutStarRadius, h=outerConnectorBallRadius * 4, center=true);

  rotate([90, 0, 0])
    cylinder(r=cutStarRadius, h=outerConnectorBallRadius * 4, center=true);

  // long cuts
  translate([-outerConnectorBallRadius * 3 / 2, 0, 0])
    cube([outerConnectorBallRadius * 3, cutWidth, outerConnectorBallRadius * 3], center=true);

  rotate([90, 0, 0]) {
    translate([-outerConnectorBallRadius * 3 / 2, 0, 0]) {
      cube([outerConnectorBallRadius * 3, cutWidth, outerConnectorBallRadius * 3], center=true);
    }
  }
}

module connector_element() {

  difference() {
    outer_outline_cutted();
    sphere(r=connectorBallRadius);

    // enter cone  
    translate([-outerConnectorBallRadius / 2, 0, 0]) {
      rotate([0, 90, 0]) {
        cylinder(r1=connectorBallRadius + 0.9, r2=connectorBallRadius - 0.5, h=outerConnectorBallRadius, center=true);
      }
    }

    translate([cutsOffset, 0, 0]) {
      cuts();
    }
  }
}

module terminal_connector() {

  difference() {
    terminal_connector_outline();
    sphere(r=connectorBallRadius);

    // enter cone  
    translate([-outerConnectorBallRadius / 2, 0, 0]) {
      rotate([0, 90, 0]) {
        cylinder(r1=connectorBallRadius + 0.9, r2=connectorBallRadius - 0.5, h=outerConnectorBallRadius, center=true);
      }
    }

    translate([cutsOffset, 0, 0]) {
      cuts();
    }
  }
}

module base_holder() {
  translate([connectorLength, 0, 0]) {
    rotate([0, 90, 0]) {
      cylinder(r=smallConnectorCylinderRadius, h=connectorLength * 2, center=true);
    }
  }
  difference() {
    sphere(r=connectorBallRadius + tentionOffset);

    translate([-cuttingCubeSide / 2 - connectorBallRadius + smallCutOffset, 0, 0])
      cube([cuttingCubeSide, cuttingCubeSide, cuttingCubeSide], center=true);
  }
}

//terminal_connector();

rotate([0, 180, 0])
  base_holder();

//rotate([180,0,0])
//  lense_holder();

//connector_element();

difference() {
  union() {
    connector_element();
    translate([connectorLength, 0, 0])
      connector_element();
  }
  translate([0, -25, 0]) {
    cube([150, 50, 150], center=true);
  }
}
