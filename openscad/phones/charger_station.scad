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

linear_extrude(height = box_height, center = true)
    rounded_rectangle(box_width, box_length, corner_radius);
