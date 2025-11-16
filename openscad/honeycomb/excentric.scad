$fn = 150;

length_inner = 2;
length_outer = 4;
length_center = 18;
length_total = length_center+length_outer+length_inner;
inner_diametr = 15.4;

deep_offset = 3;

/*
difference() {
translate([0,0,length_total/2]) {
    rotate([0,0,30]) {
  cylinder(r=inner_diametr/2, h=length_total, center=true, $fn=6);
    }
}


translate([0,40/2-deep_offset,length_center/2+length_inner]) {
  cube([40, 40, length_center], center=true);
}


}
*/


difference() {
scale([0.7, 1,1])
  cylinder(r=8, h=length_center+length_inner+length_outer,center=true);
  

translate([0,2,-length_center/2+(length_center+length_inner+length_outer)/2-length_outer])
difference() {
  cube([15*3,15*3,length_center],center=true);
  scale([0.8,0.8,1])
    scale([0.7, 1,1])
      cylinder(r=8, h=length_center+1,center=true);
}

translate([0,4,0])
  cylinder(r=3.5/2, h=50, center=true);

translate([0,4,50/2-(length_center+length_inner+length_outer)/2+length_inner])
  cylinder(r=6/2, h=50, center=true);

}


