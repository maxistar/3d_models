/**
 * ✓ audio jack
 * ✓ mic 1
 * ✓ mic 2
 * ✓ speaker1
 * ✓ speaker2
 * ✓ camera
 * ✓ usb-c
 * ✓ move camera
 * ✓ split power button and volume buttons
 * ✓ make out outline less round
 * ✓ make the case higher
 * ✓ design the locker
 * ✓ design the loker cover
 * ✓ design the cover place cut
 */

$fn = 150;
phone_width = 30;
phone_height = 70.8;
round_padius = 9;
z_scale = 0.8;

magnet_radius = 4 / 2 + 0.1;
magnet_width = 2.1;

phone1_width = 74.5;
phone1_length = 156;
phone1_thickness = 8.8;

camera_y_offset = -66;
camera_x_offset = -23.2;

locker_cut_1 = [-20, 50, 0];
locker_cut_2 = [20, 50, 0];
locker_cut_3 = [20, -50, 0];

top_cover_x_offset = phone_width * 2 + 35;

module outer_outline(phone_offset = 0, thicness_offset = 0, body_round_padius = 3) {

  minkowski() {
    hull() {
      translate([phone_width, phone_height, 0])
        cylinder(h=phone1_thickness + thicness_offset, r=round_padius + phone_offset, center=true);

      translate([-phone_width, phone_height, 0])
        cylinder(h=phone1_thickness + thicness_offset, r=round_padius + phone_offset, center=true);

      translate([phone_width, -phone_height, 0])
        cylinder(h=phone1_thickness + thicness_offset, r=round_padius + phone_offset, center=true);

      translate([-phone_width, -phone_height, 0])
        cylinder(h=phone1_thickness + thicness_offset, r=round_padius + phone_offset, center=true);
    }
    sphere(r=body_round_padius);
  }
}

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
  //outline();
  //outer_outline();
  // upper cutter

  zcutter_offset = 5 + 4.8;

  difference() {
    //outline();
    outer_outline(body_round_padius=2, thicness_offset=1, phone_offset=-2);

    outline(1.5);

    // phone entranse gap
    linear_extrude(10)
      enteranse(1.9);

    // upper cutter
    translate([0, 0, zcutter_offset])
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

    translate([22.5, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=3.3);

    translate([-25, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=2);

    translate([-10, -60, 0])
      rotate([90, 0, 0])
        cylinder(h=30, r=2);

    // power button
    translate([-39, -30, 0]) {
      hull() {
        translate([0, 20 - 3, 0])
          sphere(r=3);

        translate([0, 8, 0])
          sphere(r=3);
      }
    }

    //volume buttons
    translate([-39, -30, 0]) {
      hull() {
        translate([0, 1, 0])
          sphere(r=3);

        translate([0, -20 + 3, 0])
          sphere(r=3);
      }
    }

    // camera
    translate([camera_x_offset, camera_y_offset, 0]) {
      hull() {
        cylinder(h=20, r=6, center=true);

        translate([0, 28, 0])
          cylinder(h=20, r=6, center=true);
      }
    }

    translate(locker_cut_1) {
      locker_cut();
    }
    translate(locker_cut_2) {
      locker_cut();
    }
    translate(locker_cut_3) {
      locker_cut();
    }
  }

  //cube([15, 30, 3], center=true);
}

module locker_cut_cover() {
  // lodker
  locker_outer_h = 13;
  locker_inner_h = 2;
  locker_z_offset = 6;

  translate([0, 0, 1.1])
    cylinder(h=1, r1=4.5, r2=5.4);
  cylinder(h=locker_inner_h, r=5);
}

module locker_cut() {

  // lodker
  locker_outer_h = 13;
  locker_inner_h = 20;
  locker_z_offset = 6;

  cylinder(h=locker_inner_h, r=5, center=true);

  hull() {
    cylinder(h=locker_inner_h, r=5, center=true);

    translate([0, locker_z_offset, 0]) {
      cylinder(h=locker_inner_h, r=5, center=true);
    }
  }

  translate([0, locker_z_offset, 0]) {
    cylinder(h=locker_inner_h, r=5.5, center=true);
  }
  hull() {

    cylinder(h=locker_outer_h, r=5.5, center=true);

    translate([0, locker_z_offset, 0]) {
      cylinder(h=locker_outer_h, r=5.5, center=true);
    }
  }
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
          circle(r=2.5);

        translate([4, 0])
          circle(r=2.5);
      }
  }
}

module cover(thight = 2) {
  linear_extrude(thight)
    enteranse(-0);
}

module locker() {
  translate([-phone_width * 2 - 10, 0, 0]) {
    difference() {
      cylinder(h=2, r=10);
      cylinder(h=10, r=magnet_radius);
    }
  }

  hull() {

    translate([-phone_width, 0, 0]) {
      cylinder(h=0.2, r=10);
    }

    translate([-phone_width * 2 - 10, 0, 0]) {
      cylinder(h=0.2, r=10);
    }
  }
}

module double_cover() {

  difference() {

    cover();

    translate([camera_x_offset, camera_y_offset, 0]) {
      hull() {
        cylinder(h=20, r=6, center=true);

        translate([0, 28, 0])
          cylinder(h=20, r=6, center=true);
      }
    }

    translate([-5, 0, 10 + 0.2])
      cube([2, 500, 20], center=true);

    translate([0, 0, 8])
      outer_outline(body_round_padius=2, thicness_offset=1, phone_offset=-2);
  }

  translate(locker_cut_1) {
    locker_cut_cover();
  }
  translate(locker_cut_2) {
    locker_cut_cover();
  }
  translate(locker_cut_3) {
    locker_cut_cover();
  }

  translate([top_cover_x_offset, 0, 0]) {

    difference() {
      union() {
        cover(1.5);
        // phone entranse gap
        linear_extrude(2.5)
          enteranse(2);
      }

      translate([25, 0, 0.2]) {
        cylinder(h=10, r=magnet_radius);
      }
    }
  }

  //difference() {
  locker();
  //translate([-phone_width * 2 - 10, 0, 0.2]) {

  //}
  //}

  // connector
  translate([55, 0])
    linear_extrude(0.2)
      square([100, phone_height * 2], center=true);
}

module preview() {
  double_cover();

  //difference() {

  union() {

    //translate([0, 0, 9])
    //cube([phone1_width, phone1_length, phone1_thickness], center=true);

    translate([0, 0, 8])
      phone_cover();
  }
}

//intersection() {
//preview();
double_cover();

//translate([-49.5, 0, 0])
//  cube([(36 - 15), 30, 30], center=true);
//phone_cover();
//cube([80,50,100]);
//}

//translate([150, 0, 0])
//  cube([300, 300, 300], center=true);
//}
