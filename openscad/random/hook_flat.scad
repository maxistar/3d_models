$fn = 50;
hook_width = 40;
hook_height = 40;
base_height = 2; 

//intersection() {
union() {
minkowski() {
    cylinder(r=3, h=base_height, center=true);    
    cube([hook_width, hook_height, base_height], center=true);
}


translate([-20,0, -2]) {
rotate([90, 90, 0]) {
linear_extrude(40+3*2, center=true) {
  polygon([[0, 0], [6, 25], [0, 20]]);
}
}
}

}

//translate([-100/2-40,0, -10/2-3]) {
//  cylinder(r2=80, r1=80, h=10, center=true);
//}

//}