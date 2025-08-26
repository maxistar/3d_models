


module saber() {
  import("Anakin_-_Anakin_Emmitter_Shroud.STL", $fn=150);
}

difference() {
    saber();
  translate([89,135.5,40])
  cylinder(r=15,  h=80, center=true, $fn=150);
}
