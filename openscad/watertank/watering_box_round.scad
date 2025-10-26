box_side = 170;
box_height = 40; 
pot_radius = 60;
hole_radius = 40;
pot_depression = 5;
$fn = 250;

thickness = 2.5;
tube_hole_radius = 3;



difference() {
cylinder(d=box_side, h=box_height, center=true);

translate([0,0,box_height/2])
  cylinder(r=pot_radius, h=pot_depression*2, center=true);

difference() {
  cylinder(d=box_side-2*thickness, h=box_height-2*thickness, center=true);

  translate([0,0,box_height/2-thickness])
    cylinder(r=pot_radius+thickness, h=pot_depression*2, center=true);
}

translate([0,0,box_height/2])
  cylinder(r=hole_radius, h=pot_depression*5, center=true);

translate([0,pot_radius+7,box_height/2])
  cylinder(r=tube_hole_radius, h = pot_depression*5, center=true);



}

module support () {
translate([hole_radius+(box_side/2-hole_radius)/2, 0, 0])
  cube([box_side/2-hole_radius, thickness, box_height], center=true);
}

module supports() {
  for (i=[0:8]) {
    rotate([0, 0, i*(360/8)-360/16]) {
      support();
    }
  }
}

//difference() {
//  supports();
//  translate([0,0,box_height/2])
//    cylinder(r=pot_radius, h=pot_depression*2, center=true);  
//}