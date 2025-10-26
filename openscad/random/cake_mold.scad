thickness = 1;

difference() {
  sphere(r=80, $fn=200);
  sphere(r=80 - thickness, $fn=200);
  translate([0, 0, -170 / 2])
    cube([170, 170, 170], center=true);
}

difference() {

  cube([170, 170, 1], center=true);
  sphere(r=80 - thickness, $fn=200);

  translate([0, 0, -170 / 2])
    cube([170, 170, 170], center=true);
}
