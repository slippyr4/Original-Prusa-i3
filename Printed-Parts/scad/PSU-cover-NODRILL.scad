// PRUSA iteration3
// PSU Cover
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// modifed for china supply and more parametric 23-Mar-2017

PSU_width = 113.7;
PSU_depth = 49.1;
PSU_height =205;

PSU_hole1 = (PSU_width /2) - 25;
PSU_hole2 = (PSU_width /2) + 25;
PSU_side_hole1 = 12;
PSU_side_hole2 = 12+23;



module PSU_COVER()
{
    difference() {
        union() {
            
            // main cube
            translate([0,0,-1])cube([PSU_width-4,50+15,PSU_depth+7]); // Base

            // strengthening fillets on back centred on mounting holes
            translate([PSU_hole1-(14-0.5)/2,0,-3.5])cube([14-0.5,50+15,5]); // Back pillar 1
            translate([PSU_hole2-14/2,0,-3.5])cube([14,50+15,5]); // Back pillar 2

            // end face
            translate([PSU_width-4,0,-1])cube([6,50+15,PSU_depth+7]); 

            // locking tab that locates on PSU grille
            translate([-2,26+12,19])cube([2,2.5,23]); 

            // decorative "wedge" in side
            translate([0,35,PSU_depth-2.5])scale([1.2,1,0.2])rotate([-28,-50,-58])cube([45,45,30]);

            // the edge section that faces the prusa frame
            FRAME_SKIRTS();
        
        }


        PRETTY_CORNERS();

        // main, full depth cutout
        translate([3,2,2])cube([PSU_width-9.98,65.02,PSU_depth+0.32]); // main cutout

        // psu cutout, first part
        translate([-3,50-16.4+15-4,2])cube([PSU_width+1,16.5+4,PSU_depth+0.3]); // insert cutout

        // cutout in end to allow for connector block
        translate([-3,26 ,2])cube([10,100,17]); // right bottom cutout

        // cutout for ledge that PSU sits on
        translate([PSU_width-12, 50-16.4-17.6+15+0.9-4 ,2])cube([10,100,PSU_depth+0.3]); // left bottom cutout

        // side cutout - seems unnecessary
        translate([-3,50-16.4-17.6+15+0.9,2])cube([PSU_width+1,100,10]); //  bottom cutout

        // IEC socket and switch cutout
        translate([5.5,0,0]) SOCKET_CUTOUT();

        // prusa 3d text on side
        translate([20,50,PSU_depth+5.5]) linear_extrude(height = 1) text("Prusa3D", center=true);

     
        MOUNTING_HOLES();
       
        CABLE_EXIT();
     }
}


module SOCKET_CUTOUT()
{   
    iec_width= 27.5;
    iec_height = 19;
    corner_bevel = 4;
    screw_separation = 40;
    offset = 45;

   translate([offset,2,PSU_depth-9])
   difference() {
       // main cutout
       cube([iec_width,iec_height,30]);

       // left corner fillet
       translate([-1,iec_height+1,-1]) 
            rotate([90,0,0])
                polyhedron(points=[[0,0,corner_bevel + 2],[0,0,0],[corner_bevel + 2,0,0],[0,32,corner_bevel + 2],[0,32,0],[corner_bevel + 2,32,0]], faces=[[0,2,1],[3,4,5],[0,1,4,3],[1,2,5,4],[0,3,5,2]]);

       // right corner fillet
       translate([iec_width+1,iec_height+1,-1]) 
              rotate([90,0,-90])
                    polyhedron(points=[[0,0,corner_bevel + 2],[0,0,0],[corner_bevel + 2,0,0],[0,32,corner_bevel + 2],[0,32,0],[corner_bevel + 2,32,0]], faces=[[0,2,1],[3,4,5],[0,1,4,3],[1,2,5,4],[0,3,5,2]]);
   }
    translate([offset - screw_separation/2 + iec_width/2,2 + iec_height/2,PSU_depth-9])cylinder(r=2,h=PSU_depth+1, $fn=8); // socket right hole cutout
    translate([offset + screw_separation/2 + iec_width/2,2 + iec_height/2,PSU_depth-9])cylinder(r=2,h=50, $fn=8); // socket left hole cutout

    translate([1,2,PSU_depth-5])cube([20,14,30]); // switch cutout

    translate([offset - screw_separation/2 + iec_width/2,2 + iec_height/2,PSU_depth-9])cylinder(r=3.25,h=15-1.5, $fn=6); // socket left hole cutout nuttrap
    translate([offset + screw_separation/2 + iec_width/2,2 + iec_height/2,PSU_depth-9])cylinder(r=3.25,h=15-1.5, $fn=6); // socket left hole cutout nuttrap

}

module CABLE_EXIT()
{
    for(i=[0:10]){
        translate([10+i,6,-10])cylinder(r=3,h=50); //  left back mounthole cutout
    }
}

module MOUNTING_HOLES()
{
    translate([PSU_hole1,28+32.5,-10])cylinder(r=2,h=50,$fn=15); //  left back mounthole cutout
    translate([PSU_hole1,28+32.5,-3.7])cylinder(r2=2, r1=3.5,h=1.5,$fn=15);

    translate([PSU_hole2,28+32.5,-10])cylinder(r=2,h=50,$fn=15); //  right back mounthole cutout
    translate([PSU_hole2,28+32.5,-3.7])cylinder(r2=2, r1=3.5,h=1.5,$fn=15);


     // 50-16.4+15-4
    // fiddling with screw locations here
    translate([PSU_width+31,28 + 32.5,PSU_side_hole1+2])rotate([0,-90,0])cylinder(r=2,h=50,$fn=35); // Left side bracket screw hole
    translate([PSU_width+2.1,28+32.5,PSU_side_hole1+2])rotate([0,-90,0])cylinder(r2=2, r1=3.5,h=3,$fn=15);

    translate([PSU_width+31,28+32.5,PSU_side_hole2+2])rotate([0,-90,0])cylinder(r=2,h=50,$fn=35); // Left side bracket screw hole
    translate([PSU_width+2.1,28+32.5,PSU_side_hole2+2])rotate([0,-90,0])cylinder(r2=2, r1=3.5,h=3,$fn=15);
}

module FRAME_SKIRTS()
{
     translate([-1.6,0,0])cube([1.65,65,2]); // Frame skirt 1
     translate([-1.6,0,0])cube([1.65,30-4,PSU_depth+6]); // Frame skirt 2
     translate([-1.6,0,PSU_depth+2])cube([1.65,65,4]); // Frame skirt 3
       
}

module PRETTY_CORNERS()
{
    //pretty corners
    translate([-11,-2,-2])rotate([0,0,-45])cube([10,10,PSU_depth+9]);
    translate([PSU_width-1,-2,-2])rotate([0,0,-45])cube([10,10,PSU_depth+9]);

    translate([-3,-9,-5])rotate([-45,0,0])cube([PSU_width+31,10,10]);
    translate([-3,-12,PSU_depth+7])rotate([-45,0,0])cube([PSU_width+31,10,10]);

    translate([-3,45+15,-5])rotate([-45,0,0])cube([PSU_width+31,10,10]);
    translate([-3,48+15,PSU_depth+7])rotate([-45,0,0])cube([PSU_width+31,10,10]);

    translate([PSU_width-4,70,-2])rotate([0,0,-45])cube([10,10,PSU_depth+9]);


    translate([PSU_width-4,0-10,-20])rotate([0,-45,-45])cube([20,20,20]);
    translate([PSU_width-4,0-10,PSU_depth-4])rotate([0,-45,-45])cube([20,20,20]);


    translate([PSU_width-4,60,-10])rotate([-35,-45,-45])cube([20,20,20]);
    translate([PSU_width-4,60,PSU_depth+16])rotate([-55,48,-48])cube([20,20,20]);

    translate([PSU_width-20,-5,PSU_depth+19.5])rotate([0,45,0])cube([20,90,20]);

    translate([PSU_width-20,4,-14.5])rotate([0,45,0])cube([20,90,20]);


    translate([-14,-5,PSU_depth+19.5])rotate([0,45,0])cube([20,90,20]);
}

module PSU_Y_REINFORCEMENT()
{
    difference()
    {
        union()     // base shape
        {
            translate([ 59.5, 0, -18 ]) cube([ 33, 6, 19 ]);  // reinforcement plate
            translate([ 73.5, 5, -18 ]) cube([ 5, 16, 19 ]);  // vertical_reinforcement    
        }
        union()    // cutouts
        {
            
               
            translate([ 87.5, -8, -20 ]) rotate([ 0, 45, 0 ]) cube([ 10, 20, 10 ]);  //corner cut
            translate([ 52.5, -8, -20 ]) rotate([ 0, 45, 0 ]) cube([ 10, 20, 10 ]);  //corner cut
            translate([ 68.5, 20, -34 ]) rotate([ 45, 0, 0 ]) cube([ 15, 23, 20 ]);  //vertical reinf cutout
            
            translate([ 88, 8, -11.5 ]) rotate([ 90, 0, 0]) cylinder( h = 10, r = 1.8, $fn=30 );  //hole A
            translate([ 68, 8, -11.5 ]) rotate([ 90, 0, 0 ]) cylinder( h = 10, r = 1.8, $fn=30 );  //hole B
            
            translate([ 88, 8, -9.5 ]) rotate([ 90, 0, 0]) cylinder( h = 10, r = 1.8, $fn=30 );  //hole A
            translate([ 68, 8, -9.5 ]) rotate([ 90, 0, 0 ]) cylinder( h = 10, r = 1.8, $fn=30 );  //hole B
            
            translate([ 86.2, -10, -11.5 ]) cube([ 3.6, 20, 2 ]);  // hole cut extension
            translate([ 66.2, -10, -11.5 ]) cube([ 3.6, 20, 2 ]);  // hole cut extension
            
            
        }
    }
}

module PSU(){
        difference() {
           union() {
                cube([PSU_width,PSU_height,PSU_depth]);
                //screws
                translate([32,32,-10]) cylinder( h = 20, r = 2, $fn=30 );
                translate([32+50,32,-10]) cylinder( h = 20, r = 2, $fn=30 );
                translate([PSU_width-10,32,12]) rotate([0,90,0]) cylinder( h = 20, r = 2, $fn=30 );
                translate([PSU_width-10,32,12+23]) rotate([0,90,0]) cylinder( h = 20, r = 2, $fn=30 );

            }
            //main cutout
           translate([1.5,0,8]) difference(){ 
                cube([PSU_width-(2*1.5),20,45]);
                translate([20,1,0]) cube([88,15,17]); //connector strip
           } 
           for(i=[0:1]){
            $fn=60;
            translate([0,5+1.5,12+1.5+i*22]) rotate([0,90,0]) cylinder(r=1.5,h=1.5); //  slots
            translate([0,5,12+1.5+i*11]) cube([1.5,3,11]); //  slots

            translate([PSU_width-1.5,5+1.5,12+1.5+i*22]) rotate([0,90,0]) cylinder(r=1.5,h=1.5); //  slots
            translate([PSU_width-1.5,5,12+1.5+i*11]) cube([1.5,3,11]); //  slots
               
            translate([0,5+7+1.5,12+1.5+i*22]) rotate([0,90,0]) cylinder(r=1.5,h=1.5);
            translate([0,5+7,12+1.5+i*11]) cube([1.5,3,11]); //  slots
   
            translate([PSU_width-1.5,5+7+1.5,12+1.5+i*22]) rotate([0,90,0]) cylinder(r=1.5,h=1.5);
            translate([PSU_width-1.5,5+7,12+1.5+i*11]) cube([1.5,3,11]); //  slots
            
            translate([0,5+7+7+1.5,12+1.5+i*22]) rotate([0,90,0]) cylinder(r=1.5,h=1.5);
            translate([0,5+7+7,12+1.5+i*11]) cube([1.5,3,11]); //  slots

            translate([PSU_width-1.5,5+7+7+1.5,12+1.5+i*22]) rotate([0,90,0]) cylinder(r=1.5,h=1.5);
            translate([PSU_width-1.5,5+7+7,12+1.5+i*11]) cube([1.5,3,11]); //  slots

           }

        }
}

module FINAL_PART(){
   // rotate([90,0,-90])
    union()
        {
            PSU_COVER();
            PSU_Y_REINFORCEMENT();
        }   
}

FINAL_PART();
//rotate([90,0,-90]) %translate([-2.0,30-4,2]) PSU();

