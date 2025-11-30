$fn = 180;

monitor_width = 500;
monitor_height = 300;
monitor_depth = 25;

thing_width = 85;
thing_height = 155;
thing_depth = 55;

thing_y_offset = 8;

side_thinkness = 3;

module monitor() {
  roundness = 2;
  minkowski() 
  {
    cube([monitor_width-roundness*2, monitor_depth-roundness*2, monitor_height-roundness*2], center=true);
    sphere(roundness);
  }
}

module outline(width = 35, height = 55, depth = 45, roundness = 5) {
  minkowski() {
    sphere(roundness);
    cube([width - roundness * 2, depth - roundness * 2, height - roundness * 2], center=true);
  }
}

module main_module() {

  difference() {
    translate([0, monitor_depth / 2 + thing_y_offset, monitor_height / 2]) {
      difference() {
        outline(width=thing_width, height=thing_height, depth=thing_depth);
        outline(width=thing_width - side_thinkness, height=thing_height - side_thinkness, depth=thing_depth - side_thinkness);
      }
    }

    // top cut
    translate([0, 0, monitor_height / 2 + side_thinkness + thing_height / 2])
      cube([monitor_width, monitor_depth * 10, thing_height], center=true);
  }

  difference() {
    translate([0, monitor_depth / 2, monitor_height / 2])
      outline(width=thing_width, height=20, depth=thing_depth);
    // top cut
    translate([0, 0, monitor_height / 2 + side_thinkness + thing_height / 2])
      cube([monitor_width, monitor_depth * 10, thing_height], center=true);
    translate([0, monitor_depth + 17, 0])
      cube([monitor_width, 50, monitor_height + 40], center=true);
  }
}

module internal_wall() {
  wall_width = 2;

  intersection() {
    translate([0, monitor_depth / 2 + thing_y_offset, monitor_height / 2]) {
      outline(width=thing_width, height=thing_height, depth=thing_depth);
    }

  translate([0,monitor_depth/2+wall_width/2,side_thinkness]) { 
    cube([monitor_width, wall_width, monitor_height], center=true);
  }
  }
}

union() {
  difference() {
    main_module();
    monitor();
  }
  internal_wall();
}

/*
difference() {
  difference()
   outline(width=thing_width, height = thing_height, depth = thing_depth);
   outline(width=thing_width-side_thinkness*2, height = thing_height-side_thinkness*2, depth = thing_depth-side_thinkness*2);
  cube(100, 100, 100);
}
*/


