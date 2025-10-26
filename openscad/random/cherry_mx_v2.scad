$fn = 200;
cap_size = 18; // внешний размер колпачка (квадрат)
cap_height = 10; // высота внешнего колпачка
roundness = 1;

inner_size = 15.4;

difference() {
  union() {
    difference() {
      scale([1.25, 1, 1])
        intersection() {
          linear_extrude(cap_height, center=true, scale=0.85)
            minkowski() {
              square(cap_size - roundness * 2, center=true);
              circle(roundness);
            }

          translate([0, 0, -cap_height / 2])
            scale([1, 1, 1.16])
              sphere(r=cap_size * sqrt(2) / 2 * 1.03);
        }

      translate([0, 0, -1 - 0.001])
        linear_extrude(cap_height - 2, center=true, scale=0.85)
          square([inner_size * 1.25, inner_size], center=true);
    }

    translate([0, 0, -3])
      difference() {
        cylinder(r=2.6, h=8);
        cube([4.3, 1.19, 8], center=true);
        cube([1.13, 4.3, 8], center=true);
      }
  }

  translate([0, 0, 104])
    sphere(r=100);
}
