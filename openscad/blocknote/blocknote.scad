$fn = 50;

bloknote_width = 105;
bloknote_length = 145;
cover_thickness=0.35;
ruler_thickness=0.4;

liner_width=20;
dot_distance = 9-9/19;
hole_radius=2.5;


module holes() {
  for(i=[0:16]) {
    translate([0, i*dot_distance,0])
    cylinder(r=hole_radius,h=2, center=true);
  }
}

module slotes() {
  for(i=[0:16]) {
      translate([0, i*dot_distance,0]) {
        linear_extrude(hole_radius, center=true)
        circle(r=2);
        linear_extrude(2, center=true)
          polygon([[0,0.5],[3,2], [3,-2], [0,-0.5]]);
    }
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
      cube([liner_width, bloknote_length+5,ruler_thickness], center=true);
      cylinder(r=3,h=cover_thickness, center=true);
    }
    translate([liner_width/2+1, -bloknote_length/2+4.5, 0])
    slotes();
  }
}


module liner_with_cuts() {
    difference() {
      liner(); 
       
      for(i=[0:16]) {
        translate([5, i*dot_distance - 146/2 +4,0]) {
          cube([5,3,5], center=true);    
        }
      } 
      
      for(i=[0:5]) {
        translate([-5, i*i*1.5 - 146/2,0]) {
          cube([2*i,2*i,5], center=true);    
        }
      } 
      
      for(i=[0:5]) {
        translate([-5, i*i*1.5 - 146/2 + 100,0]) {
          cylinder(r=i, h=4, center=true);    
        }
      } 
    }
}

module ruler() {
    difference() {
    cube([liner_width, 146,ruler_thickness], center=true);
    
      for(i=[0:16]) {
        translate([0, i*dot_distance - 146/2 +4,0]) {
          cube([5,3,5], center=true);    
        }
      }
    }
}

translate([0, 0, 40]) 
  ruler();

translate([0, 0, 30]) 
  liner_with_cuts();
    
translate([0, 0, 20]) 
  liner();

translate([0, 0, 10]) 
  cover();

rotate([0,0,180]) {
  scale([-1,1,1]) {
    cover();
  }
}