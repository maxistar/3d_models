length_inner = 9;
length_outer = 5;
length_center = 18;
length_total = length_center+length_outer+length_inner;
inner_diametr = 15.4;

deep_offset = -3;

difference() {
translate([0,0,length_total/2]) {
    rotate([0,0,30]) {
  cylinder(r=inner_diametr/2, h=length_total, center=true, $fn=6);
    }
}


translate([40/2,40/2,length_center/2+length_inner]) {
  cube([40, 40, length_center], center=true);
}


}