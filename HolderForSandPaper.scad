include <BOSL2/std.scad>

// Set the number of fragments for circular objects (smoothness)
$fn = 100;

// Main disk parameters
DISK_RADIUS = 67;  
DISK_HEIGHT = 4;     

// Protrusion parameters
PROTRUSION_COUNT = 8;
PROTRUSION_DIAMETER = 9;
PROTRUSION_HEIGHT = 9;
PROTRUSION_DISTANCE_FROM_EDGE = 12.75;

// Handle parameters
HANDLE_LENGTH = 85;
HANDLE_WIDTH = 35;    
HANDLE_HEIGHT = 4;  
HANDLE_RADIUS = 2;    

// Derived values
PROTRUSION_RADIUS = PROTRUSION_DIAMETER / 2;
PROTRUSION_PLACEMENT_RADIUS = DISK_RADIUS - PROTRUSION_DISTANCE_FROM_EDGE - PROTRUSION_RADIUS;

// Module for creating rounded handle
module rounded_handle() {
            
    translate([DISK_RADIUS + HANDLE_LENGTH/4, 0, HANDLE_HEIGHT/2])
        difference() {
           cuboid([HANDLE_LENGTH, HANDLE_WIDTH, HANDLE_HEIGHT],rounding=1);
           translate([HANDLE_LENGTH/3, 0, 1])
                cuboid([HANDLE_LENGTH/6, HANDLE_WIDTH/2, HANDLE_HEIGHT+1],rounding=2);
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