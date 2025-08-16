module cableWinder (

innerDiametor = 29,
outerDiametor = 33,
spoolHeight = 16,
maxDiametor = 35,
angleHeight = 2,
borderHeight = 1,

wireDiametor = 3,
wireOffset = 0.25,


extraRingWidth = 1,
extraRingHeight = 2,

wireVerticalOffset = 3,

bodyDiametor = 60,
bodySphereScale = 0.7,
bodyThikness = 2,
bodyOffset = 0.3,
bodyInset = 2,
innerRingWidth = 1.8,
innerRingHeight = 0.5,

hookHeight = 2,
hookMaxWidth = 0.35,
hookLength = 8.5,
hookOffset = 0.5,
hookMinWidth = 1.5,
holeSmallOffset = -0.1,

bigHoleDiametor = 200,
bigHoleOffset = 19,

hooksAngle = 20,
hookAngle = 8,
angleOffset = 0.1,
holeOffset = 1,

$fn=50,

showTopPart = true,
showCenter = true,
showBottomPart = true,

)
{

channelWidth = outerDiametor - innerDiametor;


module innerWireChannelDivision(diametor) {
    union() {
        circle(d=diametor);
        translate([0, (diametor)*5, 0])
            square(size=[diametor, (diametor)*10], center=true);
    }
}


module halfWireChannel(diametor, spoolDiametor) {
  difference() {
    rotate_extrude(convexity = 10) {
      translate([spoolDiametor/4+(diametor)/4, 0, 0])
        innerWireChannelDivision(diametor);
    };
    translate([0,(spoolDiametor+(diametor)*2)/2,(diametor)*5])
      cube([spoolDiametor+diametor*2, spoolDiametor+diametor*2, (diametor)*11], center=true);
  }
}


module wireChannel(diametor, spoolDiametor) {
  translate([-spoolDiametor/4-(diametor)/4, 0, 0]) 
    halfWireChannel(diametor, spoolDiametor);


  translate([spoolDiametor/4+(diametor)/4, 0, 0]) 
    rotate([0, 0, 180])
        halfWireChannel(diametor, spoolDiametor);
}

module spoolSolid() {
    union() {
       cylinder(h=spoolHeight, d1=outerDiametor, d2=outerDiametor, center=true);
       translate([0,0,spoolHeight/2-borderHeight-angleHeight/2])
            cylinder(h=angleHeight, d1=outerDiametor, d2=maxDiametor, center=true);
       translate([0,0,spoolHeight/2-borderHeight/2])
            cylinder(h=borderHeight, d1=maxDiametor, d2=maxDiametor, center=true);
       translate([0,0,-spoolHeight/2+borderHeight+angleHeight/2])
            cylinder(h=angleHeight, d1=maxDiametor, d2=outerDiametor, center=true);
       translate([0,0,-spoolHeight/2+borderHeight/2])
            cylinder(h=borderHeight, d1=maxDiametor, d2=maxDiametor, center=true);
    }
}

module spoolOutline() {
  union() {
    difference() {
      spoolSolid();

      cylinder(h=spoolHeight*2, d1=innerDiametor, d2=innerDiametor, center=true);

    };
    intersection() {
      cylinder(h=spoolHeight, d1=outerDiametor, d2=outerDiametor, center=true);
      translate([0, 0, -wireVerticalOffset]) 
        wireChannel(wireDiametor+wireOffset+channelWidth, outerDiametor-(wireDiametor+wireOffset));
    };
  }  
}

module spoolInnerComplete() {
    difference() {
        spoolOutline();
        translate([0, 0, -wireVerticalOffset]) 
            wireChannel(wireDiametor+wireOffset,     outerDiametor);
    }
}

module bodyOutline(diametor, height, innerOffset) {
    difference() {   
        resize(newsize=[diametor,diametor,diametor*bodySphereScale])
            sphere(d=diametor, $fa = 12);
        translate([0,0,diametor/2+height])
            cylinder(h=diametor, r1=diametor/2, r2=diametor/2, center=true);
        translate([0,0,-diametor/2-innerOffset])
            cylinder(h=diametor, r1=diametor, r2=diametor, center=true);
    }
}

module bodyStageOne() {
  difference() {
    bodyOutline(bodyDiametor,spoolHeight/2+bodyThikness/2,0);
    bodyOutline(bodyDiametor-bodyThikness*2,spoolHeight/2-bodyThikness/2,1);
    cylinder(h=bodyDiametor, r1=maxDiametor/2-bodyInset, r2=maxDiametor/2-bodyInset, center=true);
    cylinder(h=spoolHeight+bodyOffset, r1=maxDiametor/2+bodyOffset, r2=maxDiametor/2+bodyOffset, center=true);
  }
}

module hookRing() {
    
    moveHook = 2;
    
    difference() {
        union() {
            translate([0,0,-hookLength/2+hookHeight/2]) { 
                translate([0,0,0.5/2]) 
                  cylinder(h=hookHeight-0.5, r=bodyDiametor/2-bodyThikness+hookMaxWidth*0.5, center=true);
                translate([0,0,(-hookHeight+0.5)/2]) 
                  cylinder(h=0.5, r1=bodyDiametor/2-bodyThikness+hookMaxWidth*0.0, r2=bodyDiametor/2-bodyThikness+hookMaxWidth*0.5, center=true);
            }
            
            translate([0, 0, moveHook/2])
            cylinder(h=hookLength+moveHook, r=bodyDiametor/2-bodyThikness-hookMinWidth/4, center=true);
        };

        cylinder(h=(hookLength)*2, r=bodyDiametor/2-bodyThikness-hookMinWidth, center=true);

    }    
}



module hookSector(angle) {
    intersection() {
        linear_extrude(height=hookLength*2, center=true) {
            hookTheSector(angle);    
        };
        hookRing();    
    }    
}



module hookTheSector(angle) {
    vectorLength = bodyDiametor;
    polygon( points=[[0,0],[vectorLength*cos(angle-hookAngle),vectorLength*sin(angle-hookAngle)],[vectorLength*cos(angle+hookAngle),vectorLength*sin(angle+hookAngle)]]);    
}

module holeTheSector(angle) {
    vectorLength = bodyDiametor;
    
    angle1 = angle-hookAngle-angleOffset;
    if (angle1<0) {
        angle1 = 360+angle1;
    }
    angle2 = angle+hookAngle+angleOffset;
    
    polygon( points=[[0,0],[vectorLength*cos(angle1),vectorLength*sin(angle1)],[vectorLength*cos(angle2),vectorLength*sin(angle2)]]);    
}


module holeRing() {
    
    cylinder(h=hookHeight, r2=bodyDiametor/2-bodyThikness/2-hookMinWidth/1.5, r1=bodyDiametor/2-bodyThikness/2+hookMaxWidth, center=true);

    
    translate([0,0,hookLength/2-hookHeight/2]) 
        cylinder(h=hookHeight+hookOffset, r1=bodyDiametor/2-bodyThikness+hookMaxWidth, r2=bodyDiametor/2-bodyThikness+hookMaxWidth, center=true);

    translate([0,0,-hookLength/2+hookLength/2-hookHeight/2]) 
        cylinder(h=hookLength, r=bodyDiametor/2-bodyThikness+holeSmallOffset, center=true);
}

/*
difference() {
 union() {
  bodyStageOne();
  hookRing();
  rotate([180,0,180])
    difference() {
      bodyStageOne();
      holeRing();
    }
 }
 translate([0,-50,0])
  cube([100,100, 100], center=true);
}
*/


module hookHole(angle) {   
    intersection() {   
        linear_extrude(height=hookLength*2, center=true) {
            holeTheSector(angle);            
        };
        holeRing();
    }
}

module bodyComplete(bottom=false) {
  difference() {
    union() {
      difference() {
        bodyStageOne();
        hookHole(180);
        hookHole(-hooksAngle);
        hookHole(180-hooksAngle*2);
        hookHole(+hooksAngle);
        hookHole(180+hooksAngle*2);
        
      };
      hookSector(0);
      hookSector(180-hooksAngle);
      hookSector(0+hooksAngle*2);
      hookSector(0-hooksAngle*2);
      hookSector(180+hooksAngle);
      
      
      translate([0,0,spoolHeight/2-bodyThikness/2]) {
        extraRing();
      }  
    };
    if (!bottom) {
      scale([1, -1, 1])
        bigcuts();
    } else {
      bigcuts();
    }
    //translate([0, bigHoleDiametor/2+bigHoleOffset,0])
      //cylinder(h=(spoolHeight)*2, d=bigHoleDiametor, center=true);
      //bigcut();
    //translate([0, -bigHoleDiametor/2-bigHoleOffset,0])
    //  cylinder(h=(spoolHeight)*2, d=bigHoleDiametor, center=true);
  };    
}


module bigcut() {
  cutradius = 10;
  rotate([0, 0, 10]) 
  linear_extrude(height=(spoolHeight)*2, center=true)
  union() {
    translate([0, -cutradius * 3])
      circle(r=cutradius);

    difference () {
      circle(r=cutradius * 4);
      union() {
        translate([cutradius * 4, 0])
          square(cutradius * 8, center=true);
        translate([0, cutradius * 4])
          square(cutradius * 8, center=true);
      }
    }
  }
}

module bigcuts() {
translate([-0, 59,0])
  bigcut();

translate([0, -59,0])
  scale([-1, -1, 1])
    bigcut();
}

//bigcuts();

//translate([0, bigHoleDiametor/2+bigHoleOffset,0])
//      cylinder(h=(spoolHeight)*2, d=bigHoleDiametor, center=true);
//    translate([0, -bigHoleDiametor/2-bigHoleOffset,0])
//      cylinder(h=(spoolHeight)*2, d=bigHoleDiametor, center=true);

module extraRing() {
    difference() {
        cylinder(h=extraRingHeight, r1=maxDiametor/2+bodyOffset+extraRingWidth, r2=maxDiametor/2+bodyOffset+extraRingWidth, center=true);

        cylinder(h=spoolHeight, r1=maxDiametor/2+bodyOffset, r2=maxDiametor/2+bodyOffset, center=true);
    }
}


if (showTopPart) {
  translate([0,0, -20]) 
    rotate([180,0,180])
      bodyComplete();
}

if (showCenter) {
  spoolInnerComplete();
}


if (showBottomPart) {
  translate([0,0, 20]) 
    bodyComplete(bottom=true);
}

}

cableWinder(
  $fn=250,
  showTopPart = true,
  showCenter = false,
  showBottomPart = false
);
