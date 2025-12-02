translate([-103,1,-79])
rotate([90,30,0])
import("insert-empty.stl");

difference() {


linear_extrude(height = 15, center=true) 
polygon([[0,0],[30,0],[30,30]]);

translate([40,9,0]) {
  cube([40,12,40], center=true);
}


translate([30,24,0]) {
  cube([40,12,40], center=true);
}
}