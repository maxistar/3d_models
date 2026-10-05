/**
 * audio jack
 * mic 1
 * mic 2
 * speaker1
 * speaker2
 * camera
 * usb-c
 */

$fn = 100;
phone_width = 30;
phone_height = 70.8;
round_padius = 9;
z_scale = 0.8;

magnet_radius = 4 / 2 + 0.1;
magnet_width = 2.1;

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

    outline(1.5);

    linear_extrude(10)
      enteranse(2);

    translate([0, 0, 5 + 4])
      cube([200, 200, 10], center=true);

    translate([15, 83, 0]) {
      speaker_cut();
    }

    translate([0, 83, 0]) {
      usb_cut();
    }

    translate([-15, 83, 0]) {
      speaker_cut();
    }

    translate([22, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=3);

    translate([-25, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=2);

    translate([-10, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=2);

    translate([-39, -30, 0])
      hull() {
        translate([0, 20 - 3, 0])
          sphere(r=3);

        translate([0, -20 + 3, 0])
          sphere(r=3);
      }

    translate([-22, -63, 0]) {
      hull() {
        cylinder(h=20, r=6, center=true);

        translate([0, 30, 0])
          cylinder(h=20, r=6, center=true);
      }
    }
  }

  //cube([15, 30, 3], center=true);
}

module speaker_cut() {
  rotate([90, 0, 0]) {
    linear_extrude(height=10)
      hull() {
        translate([-6, 0])
          circle(r=1.5);

        translate([6, 0])
          circle(r=1.5);
      }
  }
}

module usb_cut() {
  rotate([90, 0, 0]) {
    linear_extrude(height=10)
      hull() {
        translate([-4, 0])
          circle(r=2);

        translate([4, 0])
          circle(r=2);
      }
  }
}

module cover() {
  linear_extrude(2)
    enteranse(-0);
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

module double_cover() {

  difference() {

    cover();

    translate([-22, -63, 0]) {
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

  difference() {
    locker();

    translate([-phone_width * 2 - 25, 0, 0.2]) {
      cylinder(h=10, r=magnet_radius);
    }
  }

  translate([55, 0])
    linear_extrude(0.2)
      square([100, phone_height * 2], center=true);
}

//double_cover();

phone1_width = 74.5;
phone1_length = 156;
phone1_thickness = 8.8;

//difference() {
union() {

  //translate([0, 0, 9])
  //cube([phone1_width, phone1_length, phone1_thickness], center=true);

  translate([0, 0, 10])
    phone_cover();
}

//translate([150, 0, 0])
//  cube([300, 300, 300], center=true);
//}
