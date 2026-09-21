
module canopener() {
    translate([-124.5, -119.5, -4.8]) {
import("canopener.stl");
    }
}

module simple_text() {
    translate([-8, 2.5, -0.1]) {
      linear_extrude(0.6)
        text("Neu", font="Liberation Sans:style=Bold",  size=6.5);

      translate([-0, -6.5, -0.0])
        linear_extrude(0.5)
          text("Conf", font="Liberation Sans", size=5.5);
        
        translate([-2, -1, -0.0])
      linear_extrude(0.5, $fn=10)   
        circle(r=1);
        
                translate([19, -1, -0.0])
      linear_extrude(0.5, $fn=10)   
        circle(r=1);
    }
}

difference() {
canopener();

rotate([0, 0, 180]){
scale([-1, 1, 1]) {
simple_text();
}}

}