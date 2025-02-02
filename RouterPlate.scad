// Router plate used in an older model Rockler Router Lift.
// Outer diameter of the plate is roughly 4 11/32" in diameter.
//
// The reason that I made these, other than they have replaced
// the lift with better ones (multiple gears) and I cannot find
// a plate that will fit this one, is because I need a way to 
// specify multiple bit holes so that the plate that I use matches
// the bit.  
//
// Set CENTER_HOLE_DIAMETER to something slightly large than the bit
// diameter. 

// All measurements in millimeters

// Main disk dimensions
DISK_DIAMETER = 110.3;  
DISK_THICKNESS = 3.4;  
CENTER_HOLE_DIAMETER = 8;  

// Screw hole parameters
NUMBER_SCREW_HOLES = 3;
SCREW_HOLE_DIAMETER = 3.7;  
SCREW_HEAD_DIAMETER = 7.6;
EDGE_TO_HOLE_DISTANCE = 3;  // Distance from disk edge to outer screw wall
CHAMFER_START_FROM_BOTTOM = 0.75;  // Where chamfer begins from bottom

// Calculated values
SCREW_CIRCLE_OFFSET = (DISK_DIAMETER / 2) - EDGE_TO_HOLE_DISTANCE - (SCREW_HOLE_DIAMETER / 2);
CHAMFER_HEIGHT = DISK_THICKNESS - CHAMFER_START_FROM_BOTTOM;  

// Module for a single screw hole with chamfer
module screw_hole_with_chamfer() {
    union() {
        // Main screw hole
        translate([0, 0, -1])
            cylinder(h=DISK_THICKNESS + 2, d=SCREW_HOLE_DIAMETER, $fn=50);
        
        // Chamfer
 
        translate([0, 0, CHAMFER_START_FROM_BOTTOM])
            cylinder(h=CHAMFER_HEIGHT+0.01,  // Adding 0.001 to go through the plane 
                    d1=SCREW_HOLE_DIAMETER, 
                    d2=SCREW_HEAD_DIAMETER, 
                    $fn=50);
 
    }
}

difference() {
    // Main disk body
    cylinder(h=DISK_THICKNESS, d=DISK_DIAMETER, $fn=200);
    
    // Center hole
    translate([0, 0, -1])
        cylinder(h=DISK_THICKNESS + 2, d=CENTER_HOLE_DIAMETER, $fn=100);
    
    // Create screw holes with chamfers
    for (i = [0:NUMBER_SCREW_HOLES-1]) {
        rotate([0, 0, i * (360 / NUMBER_SCREW_HOLES)])
             translate([SCREW_CIRCLE_OFFSET, 0, 0])
                screw_hole_with_chamfer();
    }
}