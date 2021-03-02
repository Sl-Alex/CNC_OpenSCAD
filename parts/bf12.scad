include <colors.scad>
include <bom.scad>
include <bf12_dim.scad>

delta = 0.1;

module bearing_6000()
{
    color(color_metal_dark)
    rotate([0,90,0])
    difference()
    {
        cylinder(bf12_bearing_th, bf12_bearing_D/2, bf12_bearing_D/2);
        translate([0,0,-1])
        cylinder(bf12_bearing_th+2, bf12_bearing_d/2, bf12_bearing_d/2);
    }
}

module bf12_plate_holes(dia, plate_th)
{
    translate([0,0,-plate_th-delta])
    {
    translate([ 0,bf12_P/2,0])
    cylinder(plate_th+2*delta, dia/2, dia/2);
    translate([ 0,-bf12_P/2,0])
    cylinder(plate_th+2*delta, dia/2, dia/2);
    }
}

module bf12()
{
    translate([-bf12_L/2,0,0])
    union()
    {
        color(color_metal_black)
        difference()
        {
            union()
            {
                translate([0,-bf12_B/2,0])
                cube([bf12_L,bf12_B,bf12_H1]);

                translate([0,-bf12_B1/2,bf12_H1])
                cube([bf12_L,bf12_B1,bf12_H-bf12_H1]);
            }
            translate([-1,0,bf12_h])
                rotate([0,90,0])
                    cylinder(bf12_L+2, bf12_bearing_D/2, bf12_bearing_D/2);
            translate([bf12_L/2,bf12_P/2,-1])
            {
                translate([0,0,bf12_H1])
                cylinder(bf12_Z+1,bf12_Y/2,bf12_Y/2);
                cylinder(bf12_H1+2,bf12_X/2,bf12_X/2);
            }
            translate([bf12_L/2,-bf12_P/2,-1])
            {
                translate([0,0,bf12_H1])
                cylinder(bf12_Z+1,bf12_Y/2,bf12_Y/2);
                cylinder(bf12_H1+2,bf12_X/2,bf12_X/2);
            }
            translate([-1,bf12_P/2,bf12_h])
                rotate([0,90,0])
                    cylinder(bf12_L+2,bf12_d2/2,bf12_d2/2);
            translate([-1,-bf12_P/2,bf12_h])
                rotate([0,90,0])
                    cylinder(bf12_L+2,bf12_d2/2,bf12_d2/2);
            translate([-1,bf12_P/2,bf12_h-bf12_E])
                rotate([0,90,0])
                    cylinder(bf12_L+2,bf12_d2/2,bf12_d2/2);
            translate([-1,-bf12_P/2,bf12_h-bf12_E])
                rotate([0,90,0])
                    cylinder(bf12_L+2,bf12_d2/2,bf12_d2/2);
        }
        
        translate([(bf12_L-bf12_bearing_th)/2,0,bf12_h])
        bearing_6000();
    }
    bom_item("bf12");
}

bf12();
bf12_plate_holes(7,10);