length_inner = 12;
length_outer = 5;
length_center = 22;
length_total = length_center+length_outer+length_inner;

deep_offset = 3;

difference() {
translate([0,0,length_total/2]) {
  cylinder(r=15.0/2, h=length_total, center=true, $fn=6);
}


translate([0,40/2-deep_offset,length_center/2+length_inner]) {
  cube([40, 40, length_center], center=true);
}


}