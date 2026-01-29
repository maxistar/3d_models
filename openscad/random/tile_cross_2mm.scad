$fn = 50;


module cross() {
hull() {
  translate([10,0,0])
    cylinder(r=1,h=2, center=true);
  
  translate([-10,0,0])
    cylinder(r=1,h=2, center=true);
}

hull() {
  translate([0,10,0])
    cylinder(r=1,h=2, center=true);
  
  translate([0,-10,0])
    cylinder(r=1,h=2, center=true);
}
}


for(j=[0:10]) {
  for(i=[0:10]) {
    translate([2.5*i+j*(10+2),(10+2)*i-2.5*j,0]) {
      cross();
    }
  }
}
