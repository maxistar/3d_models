$fn = 50;

difference() {
cylinder(d=18, h=15, center = true);


translate([4, 1.5, 0])
cylinder(d=1.5, h=20, center = true);

translate([4, -1.5, 0])
cylinder(d=1.5, h=20, center = true);

translate([-4, 1.5, 0])
cylinder(d=1.5, h=20, center = true);

translate([-4, -1.5, 0])
cylinder(d=1.5, h=20, center = true);
}