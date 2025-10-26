
$fn = 50;

//diameter =  (12.2)*sqrt(5);
radius = 13.6;
diameter = radius * 2;

module imported_model() {

  difference() {
    intersection() {
      cube([100, 150, 150], center=true);

      translate([-1.5, -4.8, 0])
        import("wall-honeycomb-part.stl");
    }

    translate([-0.9 + radius, diameter / 2, 3]) {
      clipse_inverse(0.1);
    }

    translate([-0.9 + radius, diameter * 2, 3]) {
      clipse_inverse(0.1);
    }
  }

  translate([-0.9, diameter + radius / 2, 3]) {
    clipse();
  }
}

//imported_model();

module clipse(offset = 0) {
  rotate([90, 0, 90])
    union() {
      cylinder(r=0.7 + offset, h=5 + offset * 2, center=true);
      translate([0.8, 0, 0])
        cube([0.8, 1 + offset * 2, 5 + offset * 2], center=true);
    }
}

module clipse_inverse(offset = 0) {
  scale([-1, 1, 1])
    clipse(offset);
}

h_inner = 10;
r_inner = h_inner * 2 / sqrt(3);

h_outer = 10 + 1.8;
r_outer = h_outer * 2 / sqrt(3);

h_thin = 10 + 1;
r_thin = h_thin * 2 / sqrt(3);

total_height = 8;

small_value = 0.1;

module model_new() {

  difference() {
    linear_extrude(8, center=true)
      polygon([[-r_outer / 2, -h_outer], [-r_outer, 0], [-r_outer / 2, h_outer], [r_outer / 2, h_outer], [r_outer, 0], [r_outer / 2, -h_outer]]);

    linear_extrude(8 + small_value, center=true)
      polygon([[-r_thin / 2, -h_thin], [-r_thin, 0], [-r_thin / 2, h_thin], [r_thin / 2, h_thin], [r_thin, 0], [r_thin / 2, -h_thin]]);
  }

  difference() {
    linear_extrude(5, center=true)
      polygon([[-r_outer / 2, -h_outer], [-r_outer, 0], [-r_outer / 2, h_outer], [r_outer / 2, h_outer], [r_outer, 0], [r_outer / 2, -h_outer]]);

    linear_extrude(5 + small_value, center=true)
      polygon([[-r_inner / 2, -h_inner], [-r_inner, 0], [-r_inner / 2, h_inner], [r_inner / 2, h_inner], [r_inner, 0], [r_inner / 2, -h_inner]]);
  }
}

module model_rotate() {
  rotate_extrude($fn=6) {
    polygon(
      [
        [r_outer, total_height],
        [r_outer, 0],
        [r_inner + 0.5, 0],
        [r_inner, 0.5],
        [r_inner, total_height - 3],
        [r_inner + 1, total_height - 2],
        [r_inner + 1, total_height],
      ]
    );
  }
}

//model_new();

translate([0, -h_outer - 0.7, 3])
  clipse();

rotate([0, 0, 60])
  translate([0, -h_outer - 0.7, 3])
    clipse();

rotate([0, 0, -60])
  translate([0, -h_outer - 0.7, 3])
    clipse();

difference() {
  model_rotate();

  translate([0, h_outer - 0.7, 3])
    clipse_inverse(0.25);

  rotate([0, 0, 60])
    translate([0, h_outer - 0.7, 3])
      clipse_inverse(0.25);

  rotate([0, 0, -60])
    translate([0, h_outer - 0.7, 3])
      clipse_inverse(0.25);
}

//translate([0, h_outer*2, 0])
//  model_rotate();

//translate([r_outer*1.5, h_outer, 0])
//  model_rotate();

//clipse(0.1);

//translate([-0.9, diameter + radius/2, 3]) {
//}

//translate([0, 34.1, 0])
//cube([4, 13.6, 1], center=true);
