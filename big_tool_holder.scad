$fn=128;
DELTA = 0.001;

// Pegs
module peg_board(count, spacing, peg_radius, small_height, bent_radius, top_height, slice_distance, slice_angle = 20) {
    module lower_peg(h) {
        cylinder(h = h, r = peg_radius);
    }

    module upper_peg() {
        render() {
            union() {
                translate([-bent_radius,0,small_height])
                    rotate([90,0,0])
                    rotate_extrude(angle=90, convexity=10)
                    translate([bent_radius, 0])
                    circle(r = peg_radius);
                lower_peg(small_height + DELTA);
                // Top part with chip taken off
                translate([-bent_radius+DELTA,0,small_height + bent_radius])
                rotate([90,180,-90])
                difference() {
                    cylinder(h = top_height + DELTA, r = peg_radius);
                    rotate([slice_angle,0,0])
                    translate([-peg_radius * 3 / 2, slice_distance, -peg_radius * 3 / 2])
                    #cube(peg_radius * 3);
                }
            }
        }
    }
    
    module column() {
        translate([spacing,0,0])
        lower_peg(small_height);
        upper_peg();
    }

    for ( i = [0:1:count-1])
        translate([0, spacing * i, 0])
        column();
}

// Plate
module ring_lip(inner_radius, wall_thickness, wall_height) {
    PWT = wall_thickness / 2;
    PWH = wall_height / 2;
    PLATE_RADIUS = inner_radius + PWT;
    
    translate([0,0,PWH])
        rotate_extrude()
        translate([PLATE_RADIUS,0,0])
        scale([1, PWH / PWT])
        union() {
            circle(r = PWT);
            translate([-PWT,-PWT,0]) square([2 * PWT,PWT]);
        }
}

// ----------------------------------------------------

PEG_SIZE = 6 / 2;
PEG_SPACING = 19.7 + PEG_SIZE * 2;
PEG_DEPTH = 6.3;
BENT_PEG_RADIUS = 2 + PEG_SIZE;
PEG_TOP_HEIGHT = 3;
PEG_SLICE_DISTANCE = 2.6;
PEG_SLICE_ANGLE = 30;
rotate([0,90,90]) translate([0, -PEG_SPACING, 0]) peg_board(count=3, spacing=PEG_SPACING, peg_radius=PEG_SIZE, small_height=PEG_DEPTH, bent_radius=BENT_PEG_RADIUS, top_height=PEG_TOP_HEIGHT, slice_distance=PEG_SLICE_DISTANCE, slice_angle=PEG_SLICE_ANGLE);

PLATE_INNER_RADIUS = 10;
PLATE_WALL_THICKNESS = 1.;
PLATE_WALL_HEIGHT = 1.;
PLATE_OUTER_RADIUS = PLATE_INNER_RADIUS + PLATE_WALL_THICKNESS;
ring_lip(inner_radius=PLATE_INNER_RADIUS, wall_thickness=PLATE_WALL_THICKNESS, wall_height=PLATE_WALL_HEIGHT);

PLATFORM_HEIGHT = 3;
PLATFORM_INNER_RADIUS = 8;
translate([0, 0, -PLATFORM_HEIGHT])
cylinder(h = PLATFORM_HEIGHT, r2 = PLATE_INNER_RADIUS + PLATE_WALL_THICKNESS, r1 = PLATFORM_INNER_RADIUS);

CONNECTOR_WIDTH = PLATFORM_INNER_RADIUS * 2;
CONNECTOR_THICKNESS = 3;
CONNECTOR_HEIGHT = PEG_SPACING;
// Extension from platform bottom
translate([-PLATFORM_INNER_RADIUS, 0, -PLATFORM_HEIGHT])
cube([CONNECTOR_WIDTH, PLATE_OUTER_RADIUS + CONNECTOR_THICKNESS, PLATFORM_HEIGHT]);

// Wall for pegboard
CONNECTOR_PADDING = 5;
CONNECTOR_SLICE_ANGLE = 13;
CONNECTOR_SLICE_BIG_NUMBER = 30;
CONNECTOR_SLICE_VOLUME_DEPTH = 7;
difference() {
    translate([-PLATFORM_INNER_RADIUS, PLATE_OUTER_RADIUS - CONNECTOR_PADDING, 0])
    cube([CONNECTOR_WIDTH, CONNECTOR_THICKNESS + CONNECTOR_PADDING, CONNECTOR_HEIGHT]);
    translate([0,0,-DELTA])
    #cylinder(r=PLATE_INNER_RADIUS + DELTA, h=CONNECTOR_HEIGHT + DELTA);
    
    translate([-PLATFORM_INNER_RADIUS-DELTA,PLATE_OUTER_RADIUS - CONNECTOR_PADDING - DELTA,0])
    rotate([-CONNECTOR_SLICE_ANGLE,0,0])
    translate([0,-CONNECTOR_SLICE_VOLUME_DEPTH,0])
    #cube([2 * (PLATFORM_INNER_RADIUS+DELTA), CONNECTOR_SLICE_VOLUME_DEPTH, CONNECTOR_SLICE_BIG_NUMBER]);
}








