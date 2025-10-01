$fn = 50;

h_outer = 10+1.8;
r_outer = h_outer * 2/sqrt(3);



use <honeycomb_element.scad>;



module wall_corner_side_turned_element() {
    difference() {
    panel_with_clips(
        slot_2=true,
        slot_3=true,
        pin_5=true,
        pin_6=true
      );
    
    translate([-(r_outer+r_outer - (r_outer - h_outer)*5),0,0])
      cube([r_outer*2, r_outer*2, r_outer*2], center=true);
    }
    
}

module wall_corner_side_element() {
    difference() {
    panel_with_clips(
        slot_2=true,
        slot_3=true,
        pin_5=true,
        pin_6=true
      );
    
    translate([r_outer+r_outer - (r_outer - h_outer)*5,0,0])
      cube([r_outer*2, r_outer*2, r_outer*2], center=true);
    }
    
    translate([h_outer/2+1, h_outer-r_outer, 0])
      rotate([90, 0, 90])
        linear_extrude(height = r_outer * 2, center=true)
        basic_polygon();
    
    
    translate([h_outer/2+1, -(h_outer-r_outer), 0])
      rotate([90, 0, -90])
        linear_extrude(height = r_outer * 2, center=true)
        basic_polygon();

}

module wall_corner_side() {
    for (i = [0:3]) {    
      translate([0, -i*h_outer*2, 0])
        wall_corner_side_element();
    }
}

module wall_corner_side_turned() {
    for (i = [0:3]) {    
      translate([0, -i*h_outer*2, 0])
        wall_corner_side_turned_element();
    }
}

module wall_corner() {
    corner_radius = 3.5;
    
    intersection() {
      translate([-5.6, -7.5*r_outer*2/2+h_outer, -5.6])
        minkowski() {
            cube([r_outer*2-corner_radius*2, 8*r_outer*2-corner_radius*2, r_outer*2-corner_radius*2], center=true);
            sphere(r=corner_radius);
        }
      union() {
          wall_corner_side();
          rotate([0, 90, 0])
              wall_corner_side_turned();
      }
        
    }
}


wall_corner();