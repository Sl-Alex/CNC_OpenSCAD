include <colors.scad>
include <bom.scad>

l = 16;
w = 11.6;
w1 = 7.9;
th = 4.6;
th1 = 1;

delta = 0.1;

module nut8b(dia)
{
    color(color_metal_hardened)
    translate([0,0,th1])
    difference()
    {
        rotate([90,0,0])
        linear_extrude(l,center=true, convexity = 10)
        polygon(points = [
            [-w1/2,0],
            [-w1/2,-th1],
            [-w/2,-th1],
            [-w/2+(th-th1)*cos(45),-th1-(th-th1)*cos(45)],
            [ w/2-(th-th1)*cos(45),-th1-(th-th1)*cos(45)],
            [ w/2,-th1],
            [ w1/2,-th1],
            [ w1/2,0]
        ]);
        translate([0,0,-th-delta])
        cylinder(th+2*delta,dia/2,dia/2);
    }

    bom_item(str("nut8b_m",dia));
}

nut8b(6);