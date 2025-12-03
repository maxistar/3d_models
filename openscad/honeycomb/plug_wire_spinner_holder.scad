length_inner = 9;
length_total = length_inner;
inner_diametr = 15.4;

wire_offset = 6;


translate([0,0,4/2+length_total])
  cube([10,26,4], center=true);
 
    
translate([0,-12,4/2+length_total])
rotate([90,0,90]) {
  linear_extrude(10, center=true) {
    polygon([[0,0], [0,40], [5,40], [7, 30], [5, 30], [5,0]]);
  } 
}

translate([0,12,4/2+length_total])
rotate([90,0,-90]) {
  linear_extrude(10, center=true) {
    polygon([[0,0], [0,40], [5,40], [7, 30], [5, 30], [5,0]]);
  } 
}

deep_offset = -3;

translate([0,0,length_total/2]) {
    rotate([0,0,30]) {
  cylinder(r=inner_diametr/2, h=length_total, center=true, $fn=6);
    }
}


//cube([15,9,20], center=true);