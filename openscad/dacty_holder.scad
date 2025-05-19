$fn = 50;

difference() {
    
  union() {  
  translate([0,0,-2.5])
    cube([38, 10, 20], center=true);

  translate([10, 3, 5]) 
    cube([13, 16, 5], center=true);
  }

translate([-74, -30, 0])
  rotate([0,0,65])
    cube([100, 100, 100], center=true);

translate([-69, -10, 0])
  rotate([0,0,35])
    cube([100, 100, 100], center=true);
  
translate([0, 50, -30])
  rotate([45,0,0])
    cube([100, 100, 100], center=true);

translate([-11, -1, 4])
  cube([8.5, 8.5, 10], center= true);

translate([17, 0, 6.1])
  topcuts();

translate([-3,-2.5,4])
  button();

translate([10.3,0, 5])
    usbc();

translate([-3, -3, -6]) 
  switcher();
    
}



//translate([17, 0, 6.5])
//  topcuts();

//translate([9.5,0, 40])
//    button();

module topcuts() {

  translate([2, 0, 0])
    cube([2.5, 30, 3], center = true);
    
  translate([-15.5, 0, 0])
    cube([3.5, 30, 3, ], center = true);

  translate([-24, 0, 0])
    cube([2.5, 30, 3, ], center = true);
}


module button() {
    
    cube([6.0, 5.5, 6], center=true);
    
    translate([0,3,4])
    cube([5.8, 15.5, 5.5], center=true);
    
}

module usbc() {
    
    rotate([90,0,0])
    union() {
    translate([4.0, 0, 0])
      cylinder(r=1.8, h=14, center=true);

    translate([-4.0, 0, 0])
      cylinder(r=1.8, h=14, center=true);

    cube([7, 3.8, 14], center=true);
    }   
    
    translate([0,10,0])
      cube([8,10,2], center=true);
     
    translate([0,0,3])
      cube([5,40,5], center=true);
    
}


module switcher() {
    
    cube([9.5, 5, 5], center=true);
    
    translate([0, -0.5, -4.4]) 
      cube([8.5, 3.5, 4.5], center=true);
    
}



    




