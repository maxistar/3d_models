width = 40;
height = 40;
full_depth = 10;

difference() {
  linear_extrude(height=full_depth, center=true, scale=0)
    translate([0, 15])
      square([width, height], center=true);

  translate([0, 0, 8])
    cube([width * 2, height * 2, 10], center=true);

  translate([0, height + 4, -1.0])
    cube([width * 2, height * 2, 4], center=true);

  translate([0, height - 10, 3])
    cube([width * 2, height, 10], center=true);
}
