include <colors.scad>
use     <bom.scad>
include <spindle_holder_dim.scad>

delta = 0.1;

module spindle_holder_base()
{
    translate([-90/2,20,0])
    rotate([90,0,0])
    linear_extrude(spindle_holder_y,false, convexity = 50, $fn=30)
        difference()
        {
            polygon([
                [0,0],
                [0,10],
                [1,10+1],
                [1,spindle_holder_hole_z],
                [(90-55)/2,spindle_holder_hole_z],
                [(90-27)/2,68],
                [(90+27)/2,68],
                [(90+55)/2,spindle_holder_hole_z],
                [90-1,spindle_holder_hole_z],
                [90-1,10+1],
                [90,10],
                [90,0],
                ]);

            translate([90/2,spindle_holder_spindle_offset,0])
                circle(d = spindle_holder_spindle_dia, $fn=100);

            translate([90/2,spindle_holder_spindle_offset-1.5,0])
                square([90/2,3],false);
        }
}

module spindle_holder_holes()
{
    translate([0,0,-delta])
    {
        translate([spindle_holder_hole_dist_x/2,spindle_holder_hole_dist_y/2,0])
            cylinder(h = spindle_holder_hole_z+2*delta, d = 6.5);
        translate([spindle_holder_hole_dist_x/2,-spindle_holder_hole_dist_y/2,0])
            cylinder(h = spindle_holder_hole_z+2*delta, d = 6.5);
        translate([-spindle_holder_hole_dist_x/2,spindle_holder_hole_dist_y/2,0])
            cylinder(h = spindle_holder_hole_z+2*delta, d = 6.5);
        translate([-spindle_holder_hole_dist_x/2,-spindle_holder_hole_dist_y/2,0])
            cylinder(h = spindle_holder_hole_z+2*delta, d = 6.5);
    }
}

module spindle_holder_plate_holes(dia, plate_th)
{
    translate([0,0,-0.1])
    {
        translate([spindle_holder_hole_dist_x/2,10,-plate_th])
            cylinder(h = plate_th+0.2, d = dia);
        translate([spindle_holder_hole_dist_x/2,-10,-plate_th])
            cylinder(h = plate_th+0.2, d = dia);
        translate([-spindle_holder_hole_dist_x/2,10,-plate_th])
            cylinder(h = plate_th+0.2, d = dia);
        translate([-spindle_holder_hole_dist_x/2,-10,-plate_th])
            cylinder(h = plate_th+0.2, d = dia);
    }
}

module spindle_holder()
{
    color(color_plastic_black)
    {
        difference()
        {
            spindle_holder_base();
            spindle_holder_holes($fn=30);
        }
    }
}

/* Spindle holder assembly (holder+spindle+screws) */
module spindle_holder_assembly()
{
    /* Spindle holder itself */
    spindle_holder();

    /* Spindle */
    translate([
        0,
        -spindle_holder_y/2,
        spindle_holder_spindle_offset])
    children(0);
    
    /* Screw 1 */
    translate([
        spindle_holder_hole_dist_x/2,
        spindle_holder_hole_dist_y/2,
        spindle_holder_hole_z])
    children(1);

    /* Screw 2 */
    translate([
        -spindle_holder_hole_dist_x/2,
        spindle_holder_hole_dist_y/2,
        spindle_holder_hole_z])
    children(2);

    /* Screw 3 */
    translate([
        spindle_holder_hole_dist_x/2,
        -spindle_holder_hole_dist_y/2,
        spindle_holder_hole_z])
    children(3);

    /* Screw 4 */
    translate([
        -spindle_holder_hole_dist_x/2,
        -spindle_holder_hole_dist_y/2,
        spindle_holder_hole_z])
    children(4);
}

spindle_holder_assembly($fn=100)
{
    group(){};
    group(){};
    group(){};
    group(){};
    group(){};
}
