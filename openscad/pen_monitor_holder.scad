    monitor_width=500;
    monitor_height=300;
    monitor_depth=20;


module monitor() {
    
    cube([monitor_width, monitor_depth, monitor_height], center=true);
}


module outline () {
    minkowski() {
     sphere(5, center = true);
     
     cube([30,20, 50], center=true);   
        
    }
}


translate([0, monitor_depth/2, monitor_height/2]) {
  outline();
}

monitor();