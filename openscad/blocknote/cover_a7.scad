// cover for the blocknote

use <blocknote.scad>


module blocknote_a7() {

  bloknote_width = 145/2;
  bloknote_length = 105;

  cover(bloknote_width=bloknote_width, bloknote_length=bloknote_length, number_of_holes = 11, holes_offset=1);
    
}

blocknote_a7();