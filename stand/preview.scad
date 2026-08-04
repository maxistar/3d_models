

import("vert.stl");

translate([0,-22,0]) {
  difference() {
    import("vert.stl");

    translate([-100,14,-100])
    cube([200,200,200]);
  }
}
  
  
translate([0,29,0]) {  
  difference() {
    import("vert.stl");

    translate([-100,-14-200,-100])
    cube([200,200,200]);
  }
}

translate([44,-28,20]) {
  cube([5, 20, 40], center = true);
}

translate([-44,-28,20]) {
  cube([5, 20, 40], center = true);
}

translate([44,30,20]) {
  cube([5, 30, 40], center = true);
}

translate([-44,30,20]) {
  cube([5, 30, 40], center = true);
}

/*

translate([0,-28,65]) {
  cube([80, 16, 115], center = true);
}

translate([0,32,65]) {
  cube([80, 22, 115], center = true);
}

*/

