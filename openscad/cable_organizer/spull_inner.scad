innerDiametor = 29;
outerDiametor = 33;
spoolHeight = 16;
maxDiametor = 35;
angleHeight = 2;
borderHeight = 1;

wireDiametor = 3;
wireOffset = 0.25;
channelWidth = outerDiametor - innerDiametor;

extraRingWidth = 1;
extraRingHeight = 2;

wireVerticalOffset = 3;

bodyDiametor = 60;
bodySphereScale = 0.7;
bodyThikness = 2;
bodyOffset = 0.3;
bodyInset = 2;
innerRingWidth = 1.8;
innerRingHeight = 0.5;

hookHeight = 1.5;
hookMaxWidth = 0.3;
hookLength = 6.5;
hookWidth = 20;
hookOffset = 0.5;
hookMinWidth = 1.5;
holeSmallOffset = -0.1;

bigHoleDiametor = 200;
bigHoleOffset = 19;

hooksAngle = 25;
hookAngle = 10;
angleOffset = 0.2;
holeOffset = 1;

$fn=250;


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
    difference() {
        union() {
            translate([0,0,-hookLength/2+hookHeight/2]) 
                cylinder(h=hookHeight, r1=bodyDiametor/2-bodyThikness-hookMinWidth/2, r2=bodyDiametor/2-bodyThikness+hookMaxWidth, center=true);

            cylinder(h=hookLength, r1=bodyDiametor/2-bodyThikness-hookMinWidth/2, r2=bodyDiametor/2-bodyThikness+bodyOffset, center=true);
        };

        cylinder(h=(hookLength)*2, r1=bodyDiametor/2-bodyThikness-hookMinWidth, r2=bodyDiametor/2-bodyThikness-hookMinWidth, center=true);

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

//module holeSectors() {
//    holeSector(180);
//    holeSector(-hooksAngle);
//    holeSector(+hooksAngle);    
//}

module holeRing() {
    translate([0,0,hookLength/2-hookHeight/2]) 
        cylinder(h=hookHeight+hookOffset, r1=bodyDiametor/2-bodyThikness+hookMaxWidth, r2=bodyDiametor/2-bodyThikness+hookMaxWidth, center=true);

    translate([0,0,-hookLength/2+hookLength/2-hookHeight/2]) 
        cylinder(h=hookLength, r1=bodyDiametor/2-bodyThikness-holeSmallOffset, r2=bodyDiametor/2-bodyThikness-holeSmallOffset, center=true);
}

//holeRing();

module hookHole(angle) {   
    intersection() {   
        linear_extrude(height=hookLength*2, center=true) {
            holeTheSector(angle);            
        };
        holeRing();
    }
}

module bodyComplete() {
difference() {
union() {
    difference() {
        bodyStageOne();
        hookHole(180);
        hookHole(-hooksAngle);
        hookHole(+hooksAngle);
        
//        translate([bodyDiametor/2,9,4])
//rotate([-90, 0, 90]) {   
//    linear_extrude(height=hookLength*2, center=true)
//        innerWireChannelDivision(wireDiametor+wireOffset*3);
//}

    };
    hookSector(0);
    hookSector(180-hooksAngle);
    hookSector(180+hooksAngle);
    translate([0,0,spoolHeight/2-bodyThikness/2]) {
      extraRing();
    }  
};
translate([0, bigHoleDiametor/2+bigHoleOffset,0])
    cylinder(h=(spoolHeight)*2, d=bigHoleDiametor, center=true);
translate([0, -bigHoleDiametor/2-bigHoleOffset,0])
    cylinder(h=(spoolHeight)*2, d=bigHoleDiametor, center=true);
};    
}

module extraRing() {
    difference() {
        cylinder(h=extraRingHeight, r1=maxDiametor/2+bodyOffset+extraRingWidth, r2=maxDiametor/2+bodyOffset+extraRingWidth, center=true);

        cylinder(h=spoolHeight, r1=maxDiametor/2+bodyOffset, r2=maxDiametor/2+bodyOffset, center=true);
    }
}

//translate([0,0, -20]) 
//  rotate([180,0,180])
//    bodyComplete();



spoolInnerComplete();

//translate([0,0, 20]) {
//  bodyComplete();
//}
