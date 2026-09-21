
$fn = 100;
phone_width = 26;
phone_height = 68;
round_padius = 10;
z_scale = 0.8;

magnet_radius = 4 / 2 + 0.1;
magnet_width = 2.1;

origin_width = 75;
origin_height = 155;
origin_thickness = 8;

module outline(offset = 0) {
  hull() {
    translate([phone_width, phone_height, 0])
      scale([1, 1, z_scale]) {
        sphere(round_padius - offset);
      }

    translate([-phone_width, phone_height, 0])
      scale([1, 1, z_scale]) {
        sphere(round_padius - offset);
      }

    translate([phone_width, -phone_height, 0])
      scale([1, 1, z_scale]) {
        sphere(round_padius - offset);
      }

    translate([-phone_width, -phone_height, 0])
      scale([1, 1, z_scale]) {
        sphere(round_padius - offset);
      }
  }
}

module enteranse(offset = 0) {
  hull() {
    translate([phone_width, phone_height])
      circle(round_padius - offset);

    translate([phone_width, -phone_height])
      circle(round_padius - offset);

    translate([-phone_width, phone_height])
      circle(round_padius - offset);

    translate([-phone_width, -phone_height])
      circle(round_padius - offset);
  }
}

module phone_cover() {
  difference() {
    outline();

    outline(2);

    linear_extrude(10)
      enteranse(2);
  }
}

//translate([0,0,10])
//  phone_cover();

module cover() {
  linear_extrude(2)
    enteranse(-5);
}

difference() {

  cover();

  translate([-25, -70, 0]) {
    hull() {
      cylinder(h=20, r=6, center=true);

      translate([0, 30, 0])
        cylinder(h=20, r=6, center=true);
    }
  }

  translate([-5, 0, 10 + 0.2])
    cube([2, 500, 20], center=true);
}

translate([phone_width * 2 + 50, 0, 0]) {
  difference() {
    cover();

    translate([25, 0, 0.2]) {
      cylinder(h=10, r=magnet_radius);
    }
  }
}

module locker() {
  translate([-phone_width * 2 - 25, 0, 0]) {
    cylinder(h=2, r=10);
  }

  hull() {

    translate([-phone_width, 0, 0]) {
    cylinder(h=0.5, r=10);
    }

    translate([-phone_width * 2 - 25, 0, 0]) {
      cylinder(h=0.3, r=10);
    }
  }
}

difference() {
  locker();

  translate([-phone_width * 2 - 25, 0, 0.2]) {
    cylinder(h=10, r=magnet_radius);
  }
}

translate([55, 0])
  linear_extrude(0.2)
    square([100, phone_height * 2], center=true);

/*
translate([0, 0, origin_thickness / 2])
  cube([origin_width, origin_height, origin_thickness], center=true);
*/
