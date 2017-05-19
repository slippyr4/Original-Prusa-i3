// PRUSA iteration3
// RAMBo doors
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// MKS BASE
board_length=110.0;
hole_offset=5;
board_width=90;
top_gap=6;

// MKS SBASE
//board_length=146.5;
//hole_offset=4;
//board_width=95;
//top_gap=6;

// RAMBO mini
// board_length=103;
// hole_offset=4;
// board_width=69;
// top_gap=0;

case_length=board_length+15.5+top_gap; // original 118.5
case_width=board_width+23; // original 92
case_height=35; // original 35. this isn't really adequately parameterized

// cover is narrower than the base by 4.5mm which is made up by the hinge tube
// cover is shorted than the base by 13mm because it doesn't have the extra flap bit
cover_width = case_width - 4.5; // originally 87.5
cover_length = case_length - 13; // originally 105.5


module body()
{
    // side panels
    cube( [ cover_length , cover_width , 1 ] );  
    cube( [ cover_length , 2 , 20 ] );  
    cube( [ 2 , cover_width , 20 ] );   

    // corner reinforcement
    translate( [ cover_length-7.5 , 1 , 0 ] ) cube( [ 7.5 , 5 , 20 ] );   
    translate( [ 0.5 , 0.5 , 0 ] ) cube( [ 5 , 6.5 , 20 ] );  
    translate( [ 1 , 0 , 0 ] ) cube( [ 10 , cover_width , 6 ] );   
    translate( [ cover_length-6 , 0 , 0 ] ) cube( [ 6 , cover_width , 7 ] ); 
    translate( [ 10 , 0 , 0 ] ) cube( [ 6 , 5 , 6 ] );   

    // screw thread body 
    translate( [ case_length/2 - 5.25 , 2 , 0 ] ) cube( [ 9.5 , 6 , 20 ] ); 

    // rounded side
    translate( [ 0 , cover_width , 4.5 ] ) rotate([0,90,0]) cylinder( h = cover_length, r = 4.5, $fn=30);

    // upper hinge reinforcement
    translate( [ 0.5 , cover_width-18.5 , -9 ] ) rotate([20,0,0]) cube( [ cover_length-79.5 , 20 , 10 ] ); 
    
    // door closing
    translate( [ 4 , 3.5 , 16.8 ] ) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.8, r2= 3.5, $fn=30);  
    translate( [ cover_length-3.5 , 3.5 , 16.8 ] ) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.8, r2= 3.5, $fn=30); 
}

module ventilation_holes()
    {
        width = (case_width-23-12) / 3;
        start = cover_length - 79;

      for ( i = [start: 5.5: cover_length-10] ){
    //   translate([46 + i,10.5,-1]) cube([3.65,19+50,1.2]);
    //   translate([46 + i,10.5,-1]) cube([3.65,19,10]);
    //   translate([46 + i,10.5+25,-1]) cube([3.65,19,10]);
    //   translate([46 + i,10.5+50,-1]) cube([3.65,19,10]);

        // fill width ribs underneath
        translate([i,10.5,-1]) cube([3.65,case_width-29,1.2]);

        // row 1
        translate([i,10.5,-1]) cube([3.65,width,10]);

        // middle row
        translate([+i,10.5+6 + width,-1]) cube([3.65,width,10]);

        // row 3
        translate([ i,10.5+12 + width*2,-1]) cube([3.65,width,10]);
    }
    // for ( i = [-6 : 0] ){
    //   translate([46 + (i*5.5),10.5,-1]) cube([3.65,19+50,1.2]);
    // }
    // for ( i = [-7 : -6] ){
    //   translate([46 + (i*5.5),20.5,-1]) cube([3.65,19+40,1.2]);
    // }
}

module cutouts()
{
    // door closing screw
    translate( [ case_length/2-0.75 , 4 , 5 ] ) cylinder( h = 17, r = 1.8, $fn=30);  
    translate( [ case_length/2-0.75 , 4 , 18.5 ] ) cylinder( h = 2.6, r1 = 1.8, r2=2.2, $fn=30); 
    translate( [ case_length/2-0.75 , 4 ,15.5] ){
        translate( [ 0 , 0 , 2.5 ] ) cube([5.7,3.8,1], center=true);
        translate( [ 0 , 0 , 3 ] ) cube([3.8,3.8,1], center=true);
    }

    ventilation_holes();
    
    // rounded side cutoff    
    translate( [ cover_length-79 , cover_width , 4.5 ] ) rotate([0,90,0]) cylinder( h = 73, r = 3.5, $fn=30);   
    translate([ cover_length-79 ,cover_width-7.5,5]) cube([73,19,10]); 
    translate([ cover_length-79 ,cover_width-5,1]) cube([73,5,10]); 
    
//////////////////////////

// these lot didn't get bottom referenced, and they should, but might need a bit of redesigning. need to understand the hinges better
    // upper hinge cut
    translate( [ -1, cover_width-27.5 , -10 ] ) cube( [ cover_length+2 , 30 , 10 ] );  
    translate( [ cover_length-106.5 -5, cover_width , 0 ] ) cube( [ 22.5+5 , 10 , 10 ] ); 

    // upper hinge 
    translate( [cover_length-106.5 -5, cover_width-7.5, 6] ) cube( [ 22.5+5, 10 , 10 ] );       
    translate( [cover_length-106.5 -5, cover_width+2.2, 3] ) rotate([70,0,0]) cube( [ 22.5+5, 10 , 5 ] );    
    // hinge hole in case end if the end is close
    translate( [ cover_length-84-21.5-1-5 , cover_width , 4.5 ] ) rotate([0,90,0]) cylinder( h = 22.5+5, r = 2.8, $fn=30);  

    // hinge hole
    translate( [ cover_length-85 ,cover_width , 4.5 ] ) rotate([0,90,0]) cylinder( h = 120, r = 2.6, $fn=30);  

////////////////////////////    

    // door closing 
    translate( [ 4 , 3.5 , 16.9 ] ) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.2, r2= 2.8, $fn=30);  
    translate( [ cover_length-3.5 , 3.5 , 16.9 ] ) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.2, r2= 2.8, $fn=30);  

    // M3 NUT
    translate( [case_length/2-3.6 , 0.5, 16] ) cube( [ 5.7, 10 , 2.2 ] );  

    // side panel lightning slot
    translate( [2 , 10, 3] ) cube( [ 7, cover_width-22.5 , 5 ] );  
    translate( [cover_length-4.5 , 10, 3] ) cube( [ 3, cover_width-17.5 , 5 ] );  

    // corners - cut
    translate( [case_length/2-6.25 , 3, 1] ) rotate([0,0,70]) cube( [ 10, 10 , 50 ] );  
    translate( [case_length/2+1.75 , 12, 1] ) rotate([0,0,-70]) cube( [ 10, 10 , 50 ] );  

    translate( [16 , 2, 1] ) rotate([0,0,45]) cube( [ 5, 5 , 50 ] );  

}

module RAMBo_doors()
{
difference()
{
    body();
    cutouts();
    // large corner cut
    translate( [0 , -20, -3] ) rotate([0,45,45]) cube( [ 30, 30 , 20 ] );  
    }
}
 
RAMBo_doors();
    
    
    
    
    
    
    
    
    
    
