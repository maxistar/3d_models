$fn = 150;

thickness = 1;
radius = 90/2;
height=228;

difference() {
    cylinder(r=radius, h=height, center=true);    
    cylinder(r=radius-thickness, h=height+1, center=true);
    translate([0,0,height/2-5]) {
minkowski() {
cylinder(r=radius-1.5, h=0.1, center=true);
sphere(1);
}
}
}

translate([0,0,-height/2])
  cylinder(r=radius, h=thickness, center=true);


