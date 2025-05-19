
$fn = 50;
intersection() {
cube([150, 150, 150], center=true);

translate([-1.5, -4.8, 0])
import("wall-honeycomb-part.stl");
    
}


module klipse () {
  rotate([90, 0, 0])
  union() {
  cylinder(r=0.8, h=5, center=true);
  translate([0.8, 0, 0])
    cube([0.8, 0.8, 5], center=true);
  }
}

translate([-0.9, 26.3856, 4]) {
  klipse();
}