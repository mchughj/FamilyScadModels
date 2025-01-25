
$fn = 200;
ROUND_FN = 40;
BIG = 200;


// V0 - 75.0
// V1 - 73.5
// V2 - 72.5
PICKLEBALL_RADIUS = 72.5 / 2;
HOLDER_HEIGHT = 30;
EXPANSION_FACTOR = 1;
HOLDER_THICKNESS = EXPANSION_FACTOR - 0.9;
module holder_shell(inner_hole_size, shell_thickness) {
    rotate([0,0,45])
    translate([0,0,HOLDER_HEIGHT/2])
    difference() {
        sphere(r=inner_hole_size+shell_thickness);
        // Remove top and bottom
        translate([-BIG/2,-BIG/2,-HOLDER_HEIGHT/2-BIG])
        cube(BIG);
        translate([-BIG/2,-BIG/2,HOLDER_HEIGHT/2])
        cube(BIG);
        // Remove inner
        sphere(r=inner_hole_size);
        // Remove a 1/4 sector of the ring to insert the pickleball into
        translate([0,0,-BIG/2])
        cube(BIG);
    }
}

module holder() {
    translate([0,0,EXPANSION_FACTOR])
    minkowski() {
        holder_shell(PICKLEBALL_RADIUS + EXPANSION_FACTOR, HOLDER_THICKNESS);
        sphere(r=EXPANSION_FACTOR, $fn=ROUND_FN);
    }
}

KEYCHAIN_SPACING_FROM_WALL = 3;
KEYCHAIN_RADIUS = 6.5;
KEYCHAIN_HOLE_RADIUS = 4;
KEYCHAIN_HEIGHT = 4;
KEYCHAIN_EXPANSION = 1;
module keychain_attachment() {
    translate([0,0,KEYCHAIN_EXPANSION])
    minkowski() {
        difference() {
            union() {
                cylinder(r=KEYCHAIN_RADIUS, h=KEYCHAIN_HEIGHT);
                translate([-KEYCHAIN_RADIUS,0,0])
                    cube([KEYCHAIN_RADIUS*2,
                          KEYCHAIN_SPACING_FROM_WALL+KEYCHAIN_RADIUS+HOLDER_THICKNESS,
                          KEYCHAIN_HEIGHT]);
            }
            translate([0,0,-1])
                cylinder(r=KEYCHAIN_HOLE_RADIUS+KEYCHAIN_EXPANSION, h=KEYCHAIN_HEIGHT+2);

        }
        sphere(r=KEYCHAIN_EXPANSION, $fn=ROUND_FN);
    }
}

BOTTOM_SHEAR = 0.1;
module pickleball_keychain() {
    offset = KEYCHAIN_RADIUS + KEYCHAIN_SPACING_FROM_WALL + PICKLEBALL_RADIUS - EXPANSION_FACTOR * 2;
    difference() {
        translate([0,0,-BOTTOM_SHEAR])
        union() {
            holder();
            translate([0,-offset,0])
                keychain_attachment();
        }
        // Trimming the whole bottom of shape to make flat
        translate([-BIG/2,-BIG/2,-BIG])
        cube(BIG);
        // Take out the center again
        translate([0,0,-BOTTOM_SHEAR+HOLDER_HEIGHT/2+EXPANSION_FACTOR])
        sphere(r=PICKLEBALL_RADIUS + 0.007);
    }
}

pickleball_keychain();
