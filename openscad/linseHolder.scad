$fn = 200;


holderRadius = 24.8;
thickness = 1;

holderHeight = 8;

linseThickness = 2;
linseRadius = 25;

translate([holderRadius + thickness + 3 + 2, 0, 0])
  sphere(r=3);
  



difference() {
  union() {
    cylinder(r=holderRadius + thickness, h=holderHeight, center=true);
    translate([(holderRadius + thickness + 3 + 2)/2, 0, 0])
      rotate([0, 90, 0])
        cylinder(r=2, h=holderRadius + thickness + 3 + 2, center=true);
  }
  cylinder(r=holderRadius, h=holderHeight*2, center=true);
  cylinder(r=linseRadius, h=linseThickness, center=true);
}
