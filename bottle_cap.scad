$fn = 150;


bottle_diameter = 42 * 2;

cup_inner_diameter = bottle_diameter + 7;
cup_height = 80;
cup_rounding = 10;

module ring() {
    difference(){
      cylinder(d=bottle_diameter+2, h=3, center=true);
      cylinder(d=bottle_diameter-2, h=3.1, center=true);
    }    
}


module rings() {
    translate([0, 0, -cup_height/2 + 23])
    ring();


    translate([0, 0, -cup_height/2 + 23 + 15])
    ring();
    
    translate([0, 0, -cup_height/2 + 23 + 15 + 15])
    ring();
    
    translate([0, 0, -cup_height/2 + 23 + 15 + 15 + 15])
    ring();
}

module bottle() {
    
    difference() {
    
        cylinder(d=bottle_diameter, h=cup_height, center=true);
        rings();
    }
    
}

module outer_outline(offset = 0) {
  minkowski() {
    cylinder(d=cup_inner_diameter - cup_rounding*2, h=cup_height+cup_rounding, center=true);
    sphere(r = cup_rounding - offset);
  }
}


module cap_outline() {
difference() {
  outer_outline();
    
  translate([0, 0, 50+cup_height/2+cup_rounding/2])
cube([100, 100, 100], center=true);
    
    outer_outline(2);
}

}

module inner_hand() {
        translate([0, bottle_diameter/2, 0])
    cube([1.8, 5, cup_height*0.9], center= true);

}

module inner_hands() {
  inner_hand();
    
  rotate([0, 0, 60])
    inner_hand();
    
  rotate([0, 0, 120])
    inner_hand();

  rotate([0, 0, 180])
    inner_hand();
    
  rotate([0, 0, 240])
    inner_hand();
    
  rotate([0, 0, 300])
    inner_hand();

}

module holders() {

difference() {
inner_hands();
    bottle();
}
}

module leg() {
    translate([20, 0, -cup_height/2-15])

  difference() {
    cylinder(r=7, h=1, center=true);
    cylinder(r=5, h=5, center=true);
  }
}

module legs() {
    leg();
    
    rotate([0, 0, 120])
    leg();
    
    rotate([0, 0, -120])
    leg();
}


//bottle();

holders();
cap_outline();

legs();