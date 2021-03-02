include <colors.scad>
include <bom.scad>
include <sk16_dim.scad>


sk16_T = 8;
sk16_H = 44;
sk16_E = 25;
sk16_C = 38;

sk16_S = 5.5;

sk16_d = 16;
delta = 0.01;

module sk16_holes()
{
    translate([sk16_C/2,-delta,sk16_B/2])
    rotate([-90,0,0])
    cylinder(sk16_T+2*delta, sk16_S/2, sk16_S/2);
    translate([-sk16_C/2,-delta,sk16_B/2])
    rotate([-90,0,0])
    cylinder(sk16_T+2*delta, sk16_S/2, sk16_S/2);
}

module sk16_holes_plate(dia, plate_th)
{
    union()
    {
        translate([ sk16_B/2,  sk16_C/2, -plate_th-delta])
        cylinder(h = plate_th+2*delta, d = dia);
        translate([ sk16_B/2, -sk16_C/2, -plate_th-delta])
        cylinder(h = plate_th+2*delta, d = dia);
    }
}

module sk16()
{
    rotate([0,0,90])
    rotate([90,0,0])
    color(color_alu)
    difference()
    {
    translate([-sk16_W/2,0,0])
    linear_extrude(sk16_B, convexity=10)
    difference()
    {
        polygon(points = [
            [0,0],
            [sk16_W,0],
            [sk16_W,sk16_T],
            [sk16_E+(sk16_W-sk16_E)/2,sk16_T],
            [sk16_E+(sk16_W-sk16_E)/2,sk16_H],
            [(sk16_W-sk16_E)/2,sk16_H],
            [(sk16_W-sk16_E)/2,sk16_T],
            [0,sk16_T],
        ]);
        translate([sk16_W/2,sk16_h,0])
        circle(sk16_d/2);
        translate([sk16_W/2-0.5,sk16_h,0])
        square([1,sk16_H-sk16_h+delta]);
    }
        sk16_holes();
    }
    if ($children > 0)
    {
        // Shaft
        translate([0,0,sk16_h])
        children(0);
    }
    if ($children > 1)
    {
        // Screw 1
        translate([sk16_B/2,sk16_C/2,sk16_T])
        children(1);
    }
    if ($children > 2)
    {
        // Screw 2
        translate([sk16_B/2,-sk16_C/2,sk16_T])
        children(2);
    }

    bom_item("sk16");
}

sk16();