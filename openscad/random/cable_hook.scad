$fn = 100;

difference() {
union() {
cube([50, 25, 3], center=true);


translate([25, 25/2, 0])
cylinder(r=5, h=3, center=true);

translate([-25, 25/2, 0])
cylinder(r=5, h=3, center=true);

translate([-25, -25/2, 0])
cylinder(r=5, h=3, center=true);

translate([25, -25/2, 0])
cylinder(r=5, h=3, center=true);
}



union() {
    
    
    cylinder(r=3, h=30, center=true);
    
    
translate([15, 0, 0]) {
cylinder(r=3, h=30, center=true);
    
}


translate([-15, 0, 0]) {
cylinder(r=3, h=30, center=true);
}

translate([15, 10, 0])
cube([2.5, 20, 30], center=true);

translate([-15, -10, 0])
cube([2.5, 20, 30], center=true);
}
}