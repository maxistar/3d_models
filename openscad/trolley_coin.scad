$fn = 200;

difference() {
  cylinder(d=24.25,h=2.38, center=true);
  translate([0, -8, 0])
  cylinder(d=4, h=5, center=true);
    
    translate([-8, 2.5, 0.8]) {
  linear_extrude(4)
    text("Neu", size=5.5);

  translate([-1, -6.5, 0])
    linear_extrude(4)
      text("Conf", size=6.5);
}
}

