// All measurements in millimeters

// Encompassing disk for the plate
DISK_DIAMETER = 63.51;  
DISK_THICKNESS = 2.9;  

// Underneath the disk is another disk
UNDER_DISK_DIAMETER = 47;
UNDER_DISK_THICKNESS = 2;

// But a little bit of the underdisk is cut out
HALF_MOON_UNDERCUT_DIAMETER = 30 * 1.75;

// Through the meat of the circle is notch cut out
NOTCH_CUT_OUT_DIAMETER = 4;

// Offsets for the various cutouts
NOTCH_OFFSET = DISK_DIAMETER / 2;
HALFMOON_OFFSET = ( DISK_DIAMETER / 2 ) + ( HALF_MOON_UNDERCUT_DIAMETER / 4 );

BLADE_PASS_THROUGH_WIDTH = 3;
BLADE_PASS_THROUGH_OFFSET_Y = DISK_DIAMETER/8;
BLADE_PASS_THROUGH_OFFSET_X = -1.5;

module main_body() {
  union() {
    // Main disk body
    cylinder(h=DISK_THICKNESS, d=DISK_DIAMETER, $fn=200);
      
    // Under circle - actually drawn on top
    translate([0, 0, DISK_THICKNESS])
       cylinder(h=UNDER_DISK_THICKNESS, d=UNDER_DISK_DIAMETER, $fn=100);
  }
}
          
        
      
// Main module for the disk
module main_disk() {
   difference() {
      main_body();
               
      // Notch
      translate([NOTCH_OFFSET, 0, -1])
         cylinder(h=DISK_THICKNESS + 2, d=NOTCH_CUT_OUT_DIAMETER, $fn=100);
       
      translate([HALFMOON_OFFSET, 0, DISK_THICKNESS+0.01]) 
         cylinder(h=UNDER_DISK_THICKNESS + 1, d=HALF_MOON_UNDERCUT_DIAMETER, $fn=100);
       
      
      translate([-BLADE_PASS_THROUGH_WIDTH/2 + BLADE_PASS_THROUGH_OFFSET_X, 
                 -BLADE_PASS_THROUGH_OFFSET_Y, 
                 -1])
         cube( [BLADE_PASS_THROUGH_WIDTH,
                DISK_DIAMETER, 
                DISK_THICKNESS + UNDER_DISK_THICKNESS + 2], center=false);
        
 
         
    }
}

// Render the disk
main_disk();