$fn = 200;


module simple() {
  difference() {
    cylinder(d=24.15,h=2.25, center=true);
    translate([0, -8, 0])
    cylinder(d=4, h=5, center=true);
    
    translate([-8, 2.5, 0.8]) {
      linear_extrude(4)
        text("Neu", size=5.5);

      translate([-1, -6.5, 0])
        linear_extrude(4)
          text("Conf", size=6.5);
    }
  }
}

module coin_with_handle() {
    
    difference() {
      hull() {
        cylinder(d=24.15,h=2.25, center=true);
    
        translate([40, 0, 0]) {
          cylinder(d=12,h=2.25, center=true);
        }
      }
  
    
      translate([8.5, 12, 0]) {
        rotate([0, 0, 3])  
          hull() {  
            cylinder(d=15,h=4, center=true);
    
            translate([40, 0, 0])
              cylinder(d=15,h=4, center=true);
          }
      }
      
      mirror([0, 1, 0])
      translate([8.5, 12, 0]) {
        rotate([0, 0, 3])  
          hull() {  
            cylinder(d=15,h=4, center=true);
    
            translate([40, 0, 0])
              cylinder(d=15,h=4, center=true);
          }
      }
    
    
      
    translate([40, 0, 0]) {
        cylinder(d=5,h=2.25*2, center=true);
      
    }
    
    
      
    }
    
    translate([3,-2.5,0.5]){
      linear_extrude(2, center=true)
        text("NeuConf", size=6);
    }  
    
}


//simple();
coin_with_handle();