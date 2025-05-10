// spinning top
//rotate_extrude(convexity = 10) {
//  rotate([0, 90, 0])
//  import(file="spinning_top.svg", center=true);
//}

//circle(20);

$fn = 150;

module outer_body() {
  difference() {
  scale(0.37)
    rotate_extrude(convexity = 100)
      translate([27,24,0])
        import(file="spinning_top.svg", center=true);
  
     core(offset=0.2); 
      magnets();
      }
}

module core(offset=0) {
  translate([0, 0, -5-offset]) {
    cylinder(r=4+offset, $fn=8, h=10+offset*2);
  }
}

module top_part() {
  intersection() {
    outer_body();
    translate([0, 0, 0.0])
    cylinder(r=50, h=40);
  }
}

module bottom_part() {
  difference() {
  outer_body();
    cylinder(r=50, h=40);
  }
}

module magnet() {
    translate([10, 0, -0.9])
cylinder(h=2.1, r=3.1, center=true);

}

module magnets() {
    magnet();

rotate([0, 0, 120])
magnet();

rotate([0, 0, -120])
magnet();
}


//top_part();

//core();

translate([0, 0, -20])
  bottom_part();



    

//rotate_extrude(convexity = 10)
//    translate([2, 0, 0])
//        circle(r = 1, $fn = 100);
