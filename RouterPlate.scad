// Global constants for easy customization
// All measurements in millimeters unless otherwise specified

// Disk dimensions - all in mm
DISK_DIAMETER = 110.3;  
DISK_THICKNESS = 3.4;  
CENTER_HOLE_DIAMETER = 8;  

// Screw hole parameters
SCREW_HOLE_DIAMETER = 3.7;  
SCREW_HEAD_DIAMETER = 7.6;
EDGE_TO_HOLE_DISTANCE = 3;  // Distance from disk edge to outer screw wall
CHAMFER_START_FROM_BOTTOM = 0.75;  // Where chamfer begins from bottom

// Calculated values
SCREW_HOLE_RADIUS = SCREW_HOLE_DIAMETER / 2;
DISK_RADIUS = DISK_DIAMETER / 2;
SCREW_CIRCLE_OFFSET = (DISK_DIAMETER / 2) - EDGE_TO_HOLE_DISTANCE - SCREW_HOLE_RADIUS;
CHAMFER_HEIGHT = DISK_THICKNESS - CHAMFER_START_FROM_BOTTOM;  

// Main module for the disk
module main_disk() {
    difference() {
        // Main disk body
        cylinder(h=DISK_THICKNESS, d=DISK_DIAMETER, $fn=200);
        
        // Center hole
        translate([0, 0, -1])
            cylinder(h=DISK_THICKNESS + 2, d=CENTER_HOLE_DIAMETER, $fn=100);
        
        // Create three screw holes with chamfers
        for (angle = [0:120:359]) {
            rotate([0, 0, angle])
                translate([SCREW_CIRCLE_OFFSET, 0, 0])
                    screw_hole_with_chamfer();
        }
    }
}

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

// Render the disk
main_disk();