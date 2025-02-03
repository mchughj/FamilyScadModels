include <BOSL2/std.scad>

// Set the number of fragments for circular objects (smoothness)
$fn = 100;

// Main disk parameters
DISK_RADIUS = 62.5;  
DISK_HEIGHT = 3;     

// Protrusion parameters
PROTRUSION_COUNT = 8;
PROTRUSION_DIAMETER = 9;
PROTRUSION_HEIGHT = 9;
PROTRUSION_DISTANCE_FROM_EDGE = 12.75;

// Handle parameters
HANDLE_LENGTH = 30;
HANDLE_WIDTH = 28;    
HANDLE_HEIGHT = 3;  
HANDLE_RADIUS = 1; 

THUMB_WIDTH = 15;
THUMB_LENGTH = 20;   

// Derived values
PROTRUSION_RADIUS = PROTRUSION_DIAMETER / 2;
PROTRUSION_PLACEMENT_RADIUS = DISK_RADIUS - PROTRUSION_DISTANCE_FROM_EDGE - PROTRUSION_RADIUS;

// Module for creating rounded handle
module rounded_handle() {
            
    translate([DISK_RADIUS-4, 0, HANDLE_HEIGHT/2])
        difference() {
           cuboid([HANDLE_LENGTH, HANDLE_WIDTH, HANDLE_HEIGHT],anchor=LEFT, rounding=HANDLE_RADIUS);
           translate([HANDLE_LENGTH - THUMB_LENGTH - 3, 0, 1])
                // cuboid([THUMB_LENGTH, THUMB_WIDTH, HANDLE_HEIGHT+1],anchor=LEFT, rounding=8, edges = [FWD+RIGHT,BACK+RIGHT], round=2);
                cuboid([THUMB_LENGTH, THUMB_WIDTH, HANDLE_HEIGHT+1],anchor=LEFT, rounding=HANDLE_RADIUS + 1);
        };
    
}

// Module for creating a single protrusion
module protrusion() {
    cylinder(h=PROTRUSION_HEIGHT, r1=PROTRUSION_DIAMETER/2, r2=(PROTRUSION_DIAMETER-1)/2);
}

// Main assembly
union() {
    // Main disk body
    cylinder(h=DISK_HEIGHT, r=DISK_RADIUS);
    
    // Add protrusions
    for (i = [0:PROTRUSION_COUNT-1]) {
        rotate([0, 0, i * (360 / PROTRUSION_COUNT)])
            translate([PROTRUSION_PLACEMENT_RADIUS, 0, 0])
                protrusion();
    }
    
    // Add handle
    rounded_handle();
}