$fn = 50;

bloknote_width = 105;
bloknote_length = 145;
cover_thickness=0.35;
ruler_thickness=0.3;

liner_width=15;
dot_distance = 9-9/19;
hole_radius=2.5;


module holes()
for(i=[0:16]) {
  translate([0, i*dot_distance,0])
    cylinder(r=hole_radius,h=2, center=true);
}


module slotes()
for(i=[0:16]) {
  translate([0, i*dot_distance,0]) {
    //cylinder(r=2,h=2, center=true);
    linear_extrude(hole_radius, center=true)
      circle(r=2);
    linear_extrude(2, center=true)
      polygon([[0,0.5],[3,2], [3,-2], [0,-0.5]]);
  }
}



module cover() {
difference() {
minkowski() {
  cube([bloknote_width, bloknote_length,cover_thickness], center=true);
  cylinder(r=5,h=cover_thickness, center=true);
}
translate([bloknote_width/2+1, -bloknote_length/2+4.5, 0])
holes();

}

}

module liner() {
difference() {
minkowski() {
  cube([liner_width, bloknote_length+3,ruler_thickness], center=true);
  cylinder(r=3,h=cover_thickness, center=true);
}
translate([liner_width/2+1, -bloknote_length/2+4.5, 0])
slotes();

}

}


//liner();

scale([-1,1,1]) {
  cover();
}