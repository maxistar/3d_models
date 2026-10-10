liner_heigth = 2.2;
liner_length = 120 - 4;
liner_width = 5;

cut_height = 2;
cut_width = 14;
cut_offset = 40.5;

//  translate([-liner_heigth*0.5, 0, 0])
//    cube([liner_heigth*2, 67, liner_width*2], center=true);

difference() {
  translate([-liner_heigth * 0.5, 0, 0])
    cube([liner_heigth, liner_length, liner_width], center=true);

  translate([-cut_height * 1.5 - cut_height, cut_offset, 0])
    cube([cut_height * 3, cut_width, liner_width + 1], center=true);

  translate([-cut_height * 1.5 - cut_height, -cut_offset, 0])
    cube([cut_height * 3, cut_width, liner_width + 1], center=true);
}
