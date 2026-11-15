$fn = 50;

box_width = 200;
box_length = 100;
box_height = 50;
corner_radius = 10;

module rounded_rectangle(width, length, radius) {
    hull() {
        for (x = [-width / 2 + radius, width / 2 - radius])
            for (y = [-length / 2 + radius, length / 2 - radius])
                translate([x, y]) circle(r = radius);
    }
}

module outer_outline() {
    linear_extrude(height = box_height, center = true)
        rounded_rectangle(box_width, box_length, corner_radius);
}

module upper_part() {
    intersection() {
        outer_outline();
        translate([-box_width / 2, -box_length / 2, 0])
            cube([box_width, box_length, box_height / 2]);
    }
}

module bottom_part() {
    intersection() {
        outer_outline();
        translate([-box_width / 2, -box_length / 2, -box_height / 2])
            cube([box_width, box_length, box_height / 2]);
    }
}

translate([0, 0, 30])
  upper_part();
bottom_part();
