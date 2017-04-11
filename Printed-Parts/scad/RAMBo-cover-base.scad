// PRUSA iteration3
// RAMBo base
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// circuit board dimensions

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



// main body
module main_body()
{
    // side panel
    cube( [ case_length , case_width , 2 ] );  

    // upper panel
    cube( [ 1.5 , case_width , case_height ] );  
    // rear panel
    translate( [ 0 , case_width-2 , 0 ] ) cube( [ case_length-13 , 2 , case_height ] );  
    // heatbed ziptie reinforcement
    translate( [ case_length-55.5 , case_width-3.5 , 0.5 ] ) cube( [ 6.5 , 2 , case_height-0.5 ] );   

    // upper panel frame reinforcement
    translate( [ 0 , 0 , 1 ] ) cube( [ 5.5 , 7 , case_height-1 ] );  

    // side panel reinforcement
    translate( [ 0 , 0 , 1 ] ) cube( [ 9 , case_width , 3 ] );  
    translate( [board_length-hole_offset-1 , 0 , 0 ] ) cube( [ 9 , case_width , 4 ] ); 

    // post at bottom
    difference()
    {
        // bottom side reinforcement    
        translate( [case_length-7.5-13 , case_width-6 , 0 ] ) cube( [ 7.5 , 6 , 35 ] ); 
        translate( [ case_length-7.5-13-2 , case_width-13 , 0 ] ) rotate([0,0,45]) cube( [ 7.5 , 6 , 36 ] ); 
    }
    //post at top
    translate( [ 0 , case_width-7 , 0 ] ) cube( [ 5.5 , 7 , 35 ] ); 

    // screw mounting block
    translate( [ case_length/2 - 0.75 - 4.5 , case_width-8 , 0 ] ) cube( [ 9.5 , 7 , 35 ] );  

    // frame side panel
    translate( [ 20 , 0 , 0 ] ) cube( [ case_length-38.5 , 3 , 5 ] );  

    // RAMBo mounting holes
    translate( [ 3.5+board_length-hole_offset  +top_gap, 10+hole_offset , 1 ] ) rotate([0,0,90]) cylinder( h = 7, r = 5.5, $fn=6); 
    translate( [ 3.5+board_length-hole_offset  +top_gap, 10+board_width-hole_offset , 1 ] ) rotate([0,0,90]) cylinder( h = 7, r = 5.5, $fn=6); 
    translate( [ 3.5+hole_offset  +top_gap, 10+hole_offset , 1 ] ) cylinder( h = 7, r = 5.5, $fn=6); 
    translate( [ 3.5+hole_offset  +top_gap, 10+board_width-hole_offset , 1 ] ) cylinder( h = 7, r = 5.5, $fn=6); 
    
    // corners reinforcement
    translate( [ 0 , 10+board_width-hole_offset , 1 ] ) cube( [ 13 +top_gap, case_width-10-board_width+hole_offset , 6 ] );  
    translate( [ 0 , 10+board_width-hole_offset -(sqrt(3) * 5.5)/2 , 1 ] ) cube( [ 7.5 +top_gap, sqrt(3) * 5.5+2 , 6 ] ); 
    translate( [ 0 , 7.75 , 1 ] ) cube( [ 7.5+top_gap , 2.25 + hole_offset + sqrt(3)*5.5/2 , 6 ] ); 
    translate( [ 0 , 0 , 1 ] ) cube( [ 13 +top_gap , 10+hole_offset , 6 ] ); 

    // frame mounting screw blocks
    // these are referenced from the bottom - so that the case grows upwards when dimensions enlarged
    //upper
    translate( [ 1 , 0 , 0 ] ) cube( [ case_length-90.5, 4 , 10 ] );  
    
    // this does nothing
    // translate( [ 18.45 , 0 , 0 ] ) cube( [ 3 , 4 , 5.5] ); 

    //lower
    translate( [ case_length-20.5 , 0 , 0 ] ) cube( [ 20.5 , 4 , 10 ] ); 

    // heatbed filament holder body
    translate( [ case_length-36.9 ,case_width-1.65 , 24 ] ) rotate([0,90,0]) cylinder( h = 18, r = 5, $fn=6); 

    // door closing corner
    translate( [ case_length-16.5 , case_width-3.5 , case_height ] ) cylinder( h = 3, r1=2.5, r2=1, $fn=30);   

    // doors pin upper
    translate( [ 2 , case_width-7 , case_height-4 ] ) cube( [ 6 , 7 , 4] ); 
    translate( [ 4 , case_width-3.5 ,case_height ] ) cylinder( h = 3, r1=2.5, r2=1, $fn=30);   

    // x-axis cables entry hole body
    translate( [ case_length-29.5 , 2 , 0 ] ) cylinder( h = 5, r = 6, $fn=6);   
}


module ventilation_holes()
{
    // stock is 14 blocks of 5.5 width = 77mm  
    // refactored to fit as many as we can in the equivalent length

    // width of ribs was 69 (19 + gap(6) + 19 + gap(6) + 19)

    width = (case_width-23-12) / 3;

     for ( i = [0 : 5.5: case_length-41.5-top_gap] ){
         // fill width ribs underneath
        translate([13 +top_gap+ i,10.5,-1]) cube([3.65,case_width-29,1.2]);

        // row 1
        translate([13+top_gap + i,10.5,-1]) cube([3.65,width,10]);

        // middle row
        translate([13 +top_gap+ i,10.5+6 + width,-1]) cube([3.65,width,10]);

        // row 3
        translate([13 +top_gap+ i,10.5+12 + width*2,-1]) cube([3.65,width,10]);
    }
}

module cutouts(){
    // side     
    translate( [ 12 , 19 , 1 ] ) cube( [ case_length-33 , case_width-41 , 3 ] );   

    // RAMBo M3 screws
    translate( [ 3.5+board_length-hole_offset +top_gap, 10+hole_offset  , -1 ] ) cylinder( h = 10, r = 1.9, $fn=30);  
    translate( [ 3.5+board_length-hole_offset +top_gap, 10+board_width-hole_offset , -1 ] ) cylinder( h = 10, r = 1.9, $fn=30);  
    translate( [ 3.5+hole_offset +top_gap, 10+hole_offset , -1 ] ) cylinder( h = 10, r = 1.9, $fn=30);  
    translate( [ 3.5+hole_offset +top_gap, 10+board_width-hole_offset , -1 ] ) cylinder( h = 10, r = 1.9, $fn=30);     

    translate( [ 3.5+board_length-hole_offset +top_gap, 10+hole_offset  , 6 ] ) cylinder( h = 3, r1 = 1.9, r2=2.4, $fn=30);  
    translate( [ 3.5+board_length-hole_offset +top_gap, 10+board_width-hole_offset, 6 ] ) cylinder( h = 3, r1 = 1.9, r2=2.4, $fn=30);  
    translate( [ 3.5+hole_offset+top_gap , 10+hole_offset , 6 ] ) cylinder( h = 3, r1 = 1.9, r2=2.4, $fn=30);  
    translate( [ 3.5+hole_offset +top_gap, 10+board_width-hole_offset , 6 ] ) cylinder( h = 3, r1 = 1.9, r2=2.4, $fn=30);     

    translate( [ 2 , 0 , 0 ] ) ventilation_holes();
    
    // frame mounting screws
    //upper    
    translate( [ case_length-100, -2 , 15.6 ] ) rotate([0,45,0]) cube( [ 15 , 10 , 10] );     
    translate( [ case_length-102 , 8 , 5 ] ) rotate([90,0,0]) cylinder( h = 10, r = 1.6, $fn=30);   
    translate( [ case_length-102 , 9 , 5 ] ) rotate([90,0,0]) cylinder( h = 5, r = 3, $fn=30);   
    translate( [ case_length-103.35 , -2 , 5 ] ) cube( [ 2.7 , 15 , 10] ); 
    translate( [ case_length-103.4 , -2 , 7 ] ) rotate([0,5,0]) cube( [ 2.8 , 15 , 10] ); 
    translate( [ case_length-103.4 , -2 , 7 ] ) rotate([0,-5,0]) cube( [ 2.8 , 15 , 10] ); 


    //lower
    translate( [ case_length-8 , 9 , 5 ] ) rotate([90,0,0]) cylinder( h = 10, r = 1.6, $fn=30);   
    translate( [ case_length-8, 9 , 5 ] ) rotate([90,0,0]) cylinder( h = 5, r = 3, $fn=30);       
    translate( [ case_length, -2 , 6 ] ) rotate([0,-45,0]) cube( [ 5 , 15 , 15] ); 
    translate( [ case_length-24 , -2 , 8.5 ] ) rotate([0,45,0]) cube( [ 5 , 8 , 15] ); 
    translate( [ case_length-9.35 , -2 , 5 ] ) cube( [ 2.7 , 15 , 10] ); 
    translate( [ case_length-9.2 , -2 , 6.5 ] ) rotate([0,5,0]) cube( [ 2.5 , 15 , 10] ); 
    translate( [ case_length-9.3 , -2 , 6.5 ] ) rotate([0,-5,0]) cube( [ 2.5 , 15 , 10] ); 

    // flat bottom under the frame screws
    translate( [ -1 , -2 , -5 ] ) cube( [ case_length+2 , 15 , 5] ); 
    
    // USB connector hole - i don't want that
    //translate( [ -1 , 41.5 , 11 ] ) cube( [ 5.5 , 13 , 11 ] );  

    // reset button - i don't want that
    //translate( [ -2 , 65 , 14 ] ) rotate([0,90,0]) cylinder( h = 10, r = 2, $fn=30);  

    // door closing screw 
    translate( [ case_length/2 - 0.75 , case_width-4 , -1 ] ) cylinder( h = 43, r = 1.9, $fn=30);  


    // heatbed cable opening hole
    difference()
    {
    translate( [ case_length-43 , case_width+2 , 24 ] ) rotate([90,90,0]) cylinder( h = 5, r = 7, $fn=6); 
    translate( [ case_length-47.5 , case_width-12 , 13.5 ] ) cube( [ 8 , 15 , 5] ); 
    }
    translate( [ case_length-45.5 , case_width-12 , 20.5 ] ) cube( [ 5 , 15 , 15] ); 


    // heatbed cable ziptie holes
    translate( [ case_length-54.5 , case_width-5 , 30 ] ) cube( [ 4 , 10 , 2 ] );   
    translate( [ case_length-54.5 , case_width-5 , 16 ] ) cube( [ 4 , 10 , 2 ] );   



    // heatbed filament holder hole
    translate( [ case_length-37.5 , case_width-3 , 24 ] ) rotate([0,90,0]) cylinder( h = 17, r = 1.8, $fn=30);   
    translate( [ case_length-37.5 , case_width-3 , 24 ] ) rotate([0,90,0]) cylinder( h = 2, r = 2, r2=1.8, $fn=30);   
    translate( [ case_length-48.5 , case_width , 15 ] ) cube( [ 30 , 10 , 15] ); 


    // nut traps HEX  
    translate( [ 3.5+hole_offset +top_gap, 10+hole_offset  , -1 ] ){
    cylinder( h = 4, r = 3.2, $fn=6);  
    rotate([0,0,0]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    rotate([0,0,60]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    rotate([0,0,120]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    }

    translate( [ 3.5+board_length-hole_offset +top_gap, 10+hole_offset  , -1 ] ){
    cylinder( h = 4, r = 3.2, $fn=6);  
    rotate([0,0,0]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    rotate([0,0,60]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    rotate([0,0,120]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    }

    translate( [ 3.5+board_length-hole_offset+top_gap, 10+board_width-hole_offset , -1 ] ){
    cylinder( h = 4, r = 3.2, $fn=6);  
    rotate([0,0,0]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    rotate([0,0,60]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    rotate([0,0,120]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    }

    translate( [ 3.5+hole_offset +top_gap, 10+board_width-hole_offset , -1 ] ){
    cylinder( h = 4, r = 3.2, $fn=6);  
    rotate([0,0,0]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    rotate([0,0,60]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    rotate([0,0,120]) resize([0,2,0]) cylinder( h = 4, r = 3.5, $fn=6);  
    }

    translate( [ 3.5+hole_offset +top_gap, 10+hole_offset , -1 ] ) cylinder( h = 1.5, r1 = 5, r2=3.2, $fn=6);  
    translate( [ 3.5+board_length-hole_offset +top_gap, 10+hole_offset , -1 ] ) cylinder( h = 1.5, r1 = 5, r2=3.2, $fn=6);  
    translate( [ 3.5+board_length-hole_offset +top_gap, 10+board_width-hole_offset  , -1 ] ) cylinder( h = 1.5, r1 = 5, r2=3.2, $fn=6);  
    translate( [ 3.5+hole_offset +top_gap, 10+board_width-hole_offset  , -1 ] ) cylinder( h = 1.5, r1 = 5, r2=3.2, $fn=6);  

    translate( [ case_length/2 - 0.75, case_width-4 , -1 ] ) cylinder( h = 4, r = 3.2, $fn=30);   

    // door closing corners
    translate( [ 8 , case_width-12 , 28 ] ) rotate([0,0,45]) cube( [ 5 , 5 , 10] ); 
    translate( [ case_length-12.5 , case_width-11 , 4 ] ) rotate([0,0,45]) cube( [ 5 , 5 , 40] ); 

    // inner edges cutout  
    translate( [ case_length/2 - 0.75 - 4.5 , case_width-12.5 , 2 ] ) rotate([0,0,45]) cube( [ 5 , 5 , 50] ); 
    translate( [ case_length-48.5 , case_width-9.5 , 2 ] ) rotate([0,0,45]) cube( [ 5 , 5 , 50] ); 
    translate( [ 6 , case_width-12 , 7 ] ) rotate([0,0,45]) cube( [ 5 , 5 , 24] ); 
    translate( [ 5.5 , 4 , 7 ] ) rotate([0,0,45]) cube( [ 3 , 5 , 29] ); 

    // x axis cable hole
    translate( [ case_length-29.5 , 2 , -1 ] ) cylinder( h = 10, r = 4, $fn=6);   
    translate( [ case_length-38.5 , -5 , -1 ] ) cube( [ 15, 5, 10] ); 

    // large corner coutout
    translate( [ -27 , case_width-12 , -54 ] ) rotate([50,0,45]) cube( [ 50, 50, 50] ); 
    translate( [ case_length+19 , case_width-32 , -10 ] ) rotate([0,0,45]) cube( [ 50, 50, 50] ); 


}

// extruder cable holder
module ext_cable_holder()
{
difference()
{
    // body
    union(){
        rotate([90,0,0]) translate([-8, 26, -28]) rotate([0,90,0]) cylinder( h = 4, r1 = 8, r2=11, $fn=6);    
        rotate([90,0,0]) translate([-4, 26, -28]) rotate([0,90,0]) cylinder( h = 4, r1 = 11, r2=11, $fn=6);    
        rotate([90,0,0]) translate( [ 1.5 , 26 , -28 ] ) rotate([0,90,0]) cylinder( h = 10, r1 = 13, r2=7.5, $fn=6);
        translate( [-4, 28, 16.5 ] ) rotate([0,45,0]) cube( [ 6 , 5.5 , 7 ] );          
    }
    
    // upper cut
    translate( [ -15 , 13 , 15] ) cube( [ 15 , 15 , 25 ] );  
    // lower cut
    translate( [ 1.5 , 26 , 10] ) cube( [ 15 , 15 , 26 ] );  
 
    // ziptie holder
    difference(){
        rotate([90,0,0]) translate([-4, 26, -28]) rotate([0,90,0]) cylinder( h = 3.5, r = 8.5,  $fn=30);    
        rotate([90,0,0]) translate([-5, 26, -28]) rotate([0,90,0]) cylinder( h = 5.5, r = 6.2,  $fn=30);    
        }
}
}


module rambo_cover()
{
    
}

module filament_holes()
{
    difference()
    {
        union()
        {
            // extruder cable filament holder body
            translate( [ 4.5 , 25.5 , 26 ] ) rotate([0,90,0]) cylinder( h = 7, r = 3.5, $fn=6);  
            translate( [ 4.5 , 22.5 , 22.5] ) cube( [ 7 , 3 , 7 ] );   
            translate( [ 4.5 , 23.5 , 20.8] ) cube( [ 7 , 2.5 , 7 ] );   
            translate( [ 4.5 , 24.7 , 26 ] ) rotate([0,90,0]) cylinder( h = 7, r = 3, $fn=30);   
        }
        // extruder filament inner hole
        translate( [ -5 , 25 , 26 ] ) rotate([0,90,0]) cylinder( h = 20, r = 1.75, $fn=30);   
        translate( [ 4, 25 , 26 ] ) rotate([0,90,0]) cylinder( h =3, r1 = 1.9, r2=1.75, $fn=30);   
    }
}

module rambo()
{
    difference()
    {

        union()
        {
            ext_cable_holder();   
            difference()
            {
                main_body();
                cutouts();    
            }
        }


        // upper extruder cable opening
        translate( [ -5 , 28 , 26 ] ) rotate([0,90,-15]) cylinder( h = 20, r = 1.4, $fn=30);  
        
        // main hole
        translate( [ -10 , 28 , 26 ] ) rotate([0,90,0]) cylinder( h = 24, r = 5.5, $fn=30);   
        // cable opening slot
        translate( [ -15 , 26.5 , 30 ] ) cube( [ 30 , 3 , 10 ] ); 
        
        // flatten on door side 
        translate( [ -15 , 20 , 35 ] ) cube( [ 30 , 20 , 20 ] );  

        // opening slot cuts
        translate( [ -1.5 , 26 , 33] ) rotate([45,0,45]) cube( [ 3 , 3 , 3 ] );  
        translate( [ 1 , 28 , 33] ) rotate([45,0,45]) cube( [ 3 , 3 , 3 ] );  


        // screw body edge   
        translate( [ case_length/2 +5.75 ,case_width-17.8 , 2] ) rotate([0,0,45]) cube( [ 10 , 10 , 50 ] );     
        
        // lightening slots
        translate( [ case_length-18.5 ,21 , 2] ) cube( [ 5 , case_width-44 , 5 ] );     
        translate( [ 3 ,21 , 2] ) cube( [ 4.5, case_width-44 , 5 ] );     


        // bottom holes print supports
        translate( [ 3.5+hole_offset +top_gap, 10+hole_offset ,0] ){
        translate( [ 0 , 0 , 2.5 ] ) cube([3.2,5.6,2], center=true);
        translate( [ 0 , 0 , 3 ] ) cube([3.2,3.8,2], center=true);
        }

        translate( [ 3.5+board_length-hole_offset +top_gap, 10+hole_offset ,0] ){
        translate( [ 0 , 0 , 2.5 ] ) cube([3.2,5.6,2], center=true);
        translate( [ 0 , 0 , 3 ] ) cube([3.2,3.8,2], center=true);
        }

        translate( [ 3.5+board_length-hole_offset +top_gap, 10+board_width-hole_offset ,0] ){
        translate( [ 0 , 0 , 2.5 ] ) cube([3.2,5.6,2], center=true);
        translate( [ 0 , 0 , 3 ] ) cube([3.2,3.8,2], center=true);
        }

        translate( [ 3.5+hole_offset +top_gap, 10+board_width-hole_offset ,0] ){
        translate( [ 0 , 0 , 2.5 ] ) cube([3.2,5.6,2], center=true);
        translate( [ 0 , 0 , 3 ] ) cube([3.2,3.8,2], center=true);
        }

        translate( [ case_length/2 - 0.75 , case_width-4 ,0] ){
           intersection(){cylinder(r=3.2, h=10, $fn=30);
        translate( [ 0 , 0 , 2.5 ] ) cube([3.8,8,2], center=true);}
        translate( [ 0 , 0 , 3 ] ) cube([3.8,3.8,2], center=true);
        }


    }

    filament_holes();
}


module sbase()
{

sbase_width = 146.5;
sbase_depth = 95;
sbase_hole_offset = 4;

    difference()
    {
        union()
        {
             // pcb
            cube([sbase_width,sbase_depth,1.5]);

            // ethernet
            translate([sbase_width - 21, 29 ,1.5])cube([21,16,13.5]);

            // usb
            translate([sbase_width - 16.5, 50.8 ,1.5])cube([16.5,12.2,11]);

            // sd holder
            translate([sbase_width - 14.6, 9.2 ,1.5])cube([14.6,14.85,2]);
            #translate([sbase_width - 15 + 2.6, 10 ,2.5])cube([15,11,1]);

            // big caps
            translate([sbase_width -7.3, sbase_depth-23, 1.5]) cylinder(r=13/2,h=20);
            translate([sbase_width -22, sbase_depth-23, 1.5]) cylinder(r=13/2,h=20);

            // power connectors
            translate([sbase_width -26.5, sbase_depth-10.7, 1.5])cube([10.6,10.7,18.2]);
             translate([sbase_width -43.2, sbase_depth-10.7, 1.5])cube([10.6,10.7,18.2]);

             // stepper connectors
             for(x = [0:78.8/4:78.8])
             {
                translate([11.7+x,0,1.5]) cube([12.5,5.75,7]);
             }

             // stepper driver heatsink
             translate([12.3,15.2,1.5]) cube ([90,6,15.5]);

             // pins near the drivers
             translate([1,8.5,1.5]) cube ([2.5,15,8.4]);


        }

        // holes
        translate([sbase_hole_offset,sbase_hole_offset,-1]) cylinder(r=1.8, h = 6);
        translate([sbase_width-sbase_hole_offset,sbase_depth-4,-1]) cylinder(r=1.8, h = 6);
        translate([sbase_width-sbase_hole_offset,sbase_hole_offset,-1]) cylinder(r=1.8, h = 6);
        translate([4,sbase_depth-sbase_hole_offset,-1]) cylinder(r=1.8, h = 6);
    }
   
}


rambo();
%translate([7.5-4 + top_gap,14-4,1+7])  sbase();