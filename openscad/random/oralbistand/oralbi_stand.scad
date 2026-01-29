//

// import("Oral_B_Toothbrush_Stand_-_3_positions_v1.stl");

// model from https://www.printables.com/model/417605-oral-b-electric-toothbrush-stand-3-positions-with-

module origin() {
translate([-80,-100,0])
  scale([-0.9, 0.9, 0.9])
    import("exported.stl");
}


//intersection() {
  origin();
//  cube([100,100,100], center=true);
//}

