translate([-103,1,-79])
rotate([90,30,0])
import("insert-empty.stl");

difference() {


linear_extrude(height = 15, center=true) 
polygon([[0,0],[30,0],[30,90]]);

translate([35,14,0]) {
  cube([40,19,40], center=true);
}


translate([20,102,0]) {
  cube([40,150,40], center=true);
}
}