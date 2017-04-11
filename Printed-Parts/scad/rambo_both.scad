

use <RAMBo-cover-doors.scad>;
use <RAMBo-cover-base.scad>;



// MKS SBASE
board_length=146.5;
hole_offset=4;
board_width=95;
top_gap=6;

// RAMBO mini
// board_length=103;
// hole_offset=4;
// board_width=69;
// top_gap=0;

case_length=board_length+15.5+top_gap; // original 118.5
case_width=board_width+23; // original 92
case_height=35; // original 35. this isn't really adequately parameterized



rambo();

translate([0,case_width,56]) rotate([180,0,0]) RAMBo_doors();