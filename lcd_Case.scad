// Alunar LCD Display case
// based on the PanelOne case v0.1
// 
// This version by Steve Luzynski
// GNU GPL v3
// January 2017

// For more information on the PanelOne case:
// http://blog.think3dprint3d.com/2014/04/OpenSCAD-PanelOne-case-design.html
//
//
// by Tony Lock
// GNU GPL v3
// Apr 2014


clearance = 0.8;
wall_width = 1.6; 
layer_height = 0.2;

m3_diameter = 3.6;
m3_nut_diameter = 5.3;
m3_nut_diameter_bigger=((m3_nut_diameter / 2) / cos (180 / 6))*2;

// LCD Module
lcd_scrn_x = 76.9;
lcd_scrn_y = 25;
lcd_scrn_z = 7;

lcd_board_x = 98;
lcd_board_y = 60;
lcd_board_z = 1.6;

lcd_hole_d=3;
lcd_hole_offset=(lcd_hole_d/2)+1;

lcd_pl_offset_x=13.4;
lcd_pl_offset_y=-7.7;

//board edge to center of first connector hole
lcd_connect_x=22.8;
lcd_connect_y=50.4;

//Main circuit board
pl_x=150;
pl_y=55;
pl_z=1.6; 

pl_hole_d = 3;
pl_hole_offset=(pl_hole_d/2)+1;

pl_mounting_hole_dia=2.9;
pl_mounting_hole1_x=2.5;
pl_mounting_hole2_x=147.5;
pl_mounting_hole1_y=2.5; 
pl_mounting_hole2_y=2.5;
pl_mounting_hole3_x=2.5;
pl_mounting_hole4_x=147.5;
pl_mounting_hole3_y=52.2; 
pl_mounting_hole4_y=52.2;

//rotary encoder
click_encoder_x=13.5;
click_encoder_y=12.9;
click_encoder_z=6.7;
click_encoder_shaft_dia=6+clearance;
click_encoder_shaft_h=14.7;
click_encoder_knob_dia=25;
click_encoder_offset_x=136.15;
click_encoder_offset_y=24.1;

// reset button
reset_button_x=6.2;
reset_button_y=6.2;
reset_button_z=7.4;
reset_button_offset_x=133.8;
reset_button_offset_y=5.6;
reset_button_offset_z=-reset_button_z;

//headers
//lcd connection header
lcd_h_x=(16*2.54)+2.54;
lcd_h_y=2.54;
lcd_h_z=3; 
lcd_h_offset_x=lcd_connect_x; 
lcd_h_offset_y=lcd_connect_y;
lcd_h_offset_z=pl_z;

//IDC headers, use the clearance required for the plug
//these are much bigger on z than the actual headers for clearance
idc_h_x=16; 
idc_h_y=14+clearance;
idc_h_z=pl_z+click_encoder_z;
idc1_offset_x=47; 
idc1_offset_y=16.6; 
idc1_offset_z=-idc_h_z;
idc2_offset_x=69.5; 
idc2_offset_y=16.6;
idc2_offset_z=idc1_offset_z;

//SD card slot
SD_slot_x=29.5; 
SD_slot_y=20;
SD_slot_z=4;
SD_slot_offset_x=0;
SD_slot_offset_y=8.5;
SD_slot_offset_z=-SD_slot_z;

//case variables
shell_split_z = pl_z+SD_slot_z; 
shell_width=wall_width+clearance;
shell_top = pl_z+click_encoder_z+2;

//mount variables
mount_x=(lcd_hole_offset+shell_width)*2;
mount_z=4;
mount_a=19;
mount_b=49;
mount_c=62.9;
mount_angle=41.87;

module LCD_assembly() {
    translate([lcd_pl_offset_x,lcd_pl_offset_y,lcd_h_offset_z+lcd_h_z])
        lcd();
        pl_board();
   //lcd connection header
    color("black")
        translate([lcd_h_offset_x,lcd_h_offset_y,lcd_h_offset_z])
            cube([lcd_h_x,lcd_h_y,lcd_h_z]);
}

//LCD screen
module lcd() {
    difference(){
        union(){
            color("OliveDrab")
                translate([0,0,0])
                    cube([lcd_board_x,lcd_board_y,lcd_board_z]);
            color("DarkSlateGray")
                translate([(lcd_board_x-lcd_scrn_x)/2,(lcd_board_y-lcd_scrn_y)/2,lcd_board_z])
                    cube([lcd_scrn_x,lcd_scrn_y,lcd_scrn_z]);
        }
        for(i=[lcd_hole_offset,lcd_board_x-lcd_hole_offset]){
            for(j=[lcd_hole_offset,lcd_board_y-lcd_hole_offset]){
                translate([i,j,lcd_board_z])
                    cylinder(r=lcd_hole_d/2,h=lcd_board_z+3,$fn=12,center=true);
            }
        }
    }
}



//base circuit board simplified
module pl_board() {
    difference(){
        union(){
            color("lightgreen")cube([pl_x,pl_y,pl_z]);
            //click encoder
            color("darkgrey"){
                translate([click_encoder_offset_x,click_encoder_offset_y,pl_z+(click_encoder_z)/2])
                    cube([click_encoder_x,click_encoder_y,click_encoder_z],center=true);
                translate([click_encoder_offset_x,click_encoder_offset_y,pl_z+click_encoder_z+(click_encoder_shaft_h)/2])
                    cylinder(r=click_encoder_shaft_dia/2,h=click_encoder_shaft_h,center=true);
            }        
        }

        //mounting holes

        for(i=[pl_hole_offset,pl_x-pl_hole_offset]){
            for(j=[pl_hole_offset,pl_y-pl_hole_offset]){
                translate([i,j,pl_z])
                    cylinder(r=pl_hole_d/2,h=pl_z+3,$fn=12,center=true);
            }
        }
    }
    //SD board 
    color("lightblue")    
        translate([SD_slot_offset_x,SD_slot_offset_y,SD_slot_offset_z]) 
            cube([SD_slot_x,SD_slot_y,SD_slot_z]);
   //IDC headers
    color("darkgrey"){
        translate([idc1_offset_x,idc1_offset_y,idc1_offset_z])
            cube([idc_h_x,idc_h_y,idc_h_z]);
        translate([idc2_offset_x,idc2_offset_y,idc2_offset_z])
            cube([idc_h_x,idc_h_y,idc_h_z]);
    }
    // reset button
    color("orange")
        translate([reset_button_offset_x,reset_button_offset_y,reset_button_offset_z])
            cube([reset_button_x,reset_button_y,reset_button_z]);
}


module back() {
    side=8; //for the supports
    difference(){
        union(){
            difference(){
                translate([-shell_width,-shell_width,-shell_width])
                    cube([pl_x+shell_width*2,pl_y+shell_width*2,shell_split_z+shell_width]);
                translate([-clearance,-clearance,-clearance])
                    cube([pl_x+clearance*2,pl_y+clearance*2,shell_split_z+clearance+0.01]);
                LCD_assembly();
            }
            //corner supports
            for(i=[-wall_width,pl_y-side+wall_width]){
                translate([-wall_width,i,-shell_width])
                    cube([side,side,4.35]);
                translate([pl_x-side+wall_width,i,-shell_width])
                    cube([side,side,4.35]);
            }
            //additional support
            translate([lcd_board_x-side,-wall_width,-shell_width])
                cube([side,side/2,8.75]);
        }
        case_screw_holes(0);
    }
}

module front() {
    side=8; //for the supports
    difference(){
        union(){
            difference(){
                translate([-shell_width,-shell_width,shell_split_z])
                    cube([pl_x+shell_width*2,pl_y+shell_width*2,shell_top-shell_split_z +shell_width]);
                translate([-clearance,-clearance,shell_split_z-0.01])
                    cube([pl_x+clearance*2,pl_y+clearance*2,shell_top-shell_split_z +clearance]);
                LCD_assembly();
            }
            //corner supports
            for(i=[-wall_width,pl_x-side+wall_width])
                for(j=[-wall_width,pl_y-side+wall_width]){
                    translate([i,j,shell_split_z])
                        cube([side,side,shell_top-shell_split_z+wall_width]);
                }
            //additional supports
            for(i=[-wall_width,pl_y-side/2+wall_width]){
                translate([lcd_board_x-side,i,shell_split_z])
                cube([side,side/2,shell_top-shell_split_z+wall_width]);
            }
        }
        case_screw_holes(shell_top+shell_width);
    }
}


module mount()
{
	difference(){
		union(){
			linear_extrude(height=mount_x)
				polygon([[mount_c-mount_a,-mount_z],
						[mount_c-mount_a-mount_z,-mount_z],
						[mount_c-mount_a-mount_z,-mount_z/2],
						[-mount_z/2,mount_b-mount_z],
						[-mount_a,mount_b-mount_z],
						[-mount_a,mount_b],
						[0,mount_b],
						[mount_c-mount_a,0]]);

			for(i=[(lcd_hole_offset-pl_mounting_hole2_y)/2,(pl_mounting_hole2_y-lcd_hole_offset)/2]){
				translate([21.30,16.73,mount_x])
					rotate([0,90,mount_angle])
						translate([0,i,0])
							cube([mount_x,mount_x,1.6]);
			}
		}

		//shave off a bit of the mount brackets
		translate([mount_c-mount_a-mount_z-3,-mount_z-8.5,-2])
				cube([10,10,mount_x+4]);

		//case holes
		for(i=[(lcd_hole_offset-pl_mounting_hole2_y)/2,(pl_mounting_hole2_y-lcd_hole_offset)/2])
		translate([17.4,20.5,mount_x/2])
			rotate([0,90,mount_angle])
				translate([0,i,0]){
					cylinder(r=lcd_hole_d/2, h=mount_z*4, $fn=20);
					cylinder(r=m3_nut_diameter_bigger/2+layer_height*2, h=3.5, $fn=6);
				}

		//frame mounting holes
		translate([-11.5,35,mount_x/2])
			rotate([0,90,90])
				cylinder(r=lcd_hole_d/2, h=mount_z*4, $fn=20);
	}
}


module case_screw_holes(z_height=0, dia=lcd_hole_d) {
    
    for(i=[pl_hole_offset,pl_x-pl_hole_offset]){
        for(j=[pl_hole_offset,pl_y-pl_hole_offset]){
                translate([i,j,z_height])
                    cylinder(r=dia/2,h=shell_width*2+30,$fn=12,center=true);
            }
        }
}

//LCD_assembly();
//lcd();
//pl_board();
//front();
//back();
//mount();

translate([shell_width,pl_y*2+shell_width*4,shell_top+shell_width])
    rotate([180,0,0])
        color("blue") front();

translate([shell_width,shell_width,shell_width])
    color("purple")back();

translate([shell_width+mount_x*2,pl_y*2+shell_width*4+20,0])
        mount();
translate([shell_width+mount_x*5,pl_y*2+shell_width*4+20,0])
        mount();