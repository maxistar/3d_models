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


module pack_25() {
for(j=[0:5]) {
  for(i=[0:5]) {
    translate([j*((10+1)*2+4),((10+1)*2+4)*i,0]) {
      cross();
    }
  }
}
}

pack_25();

translate([10+2.5,2.5,0]) {
  pack_25();
}

translate([2.5,10+4.5,0]) {
  pack_25();
}
