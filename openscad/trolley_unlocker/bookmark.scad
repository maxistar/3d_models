$fn = 200;

module outline() {
linear_extrude(1) {
  hull() {
    circle(r=12);

    translate([0,-60,0])
      circle(r=12);
      
    translate([0,-67.5,0])
      rotate([0,0,45])
        square([13,13], center=true);
  }
}
}

module cut() { 


difference() {
linear_extrude(10, center=true) {
  hull() {
    circle(r=8);

    translate([0,-60,0])
      circle(r=8);
  }
}


linear_extrude(12, center=true) {
  hull() {
    circle(r=6);

    translate([0,-60,0])
      circle(r=6);
  }
}

translate([0,5,0]) {
cube([22,22,22], center=true);
}

}



}
  
  



module simple_text() {
    translate([-8, 2.5, 0.8]) {
      linear_extrude(0.4)
        text("Neu", size=5.5);

      translate([-1, -6.5, 0])
        linear_extrude(0.4)
          text("Conf", size=6.5);
    }
}

difference() {
outline();

cut();
}

simple_text();