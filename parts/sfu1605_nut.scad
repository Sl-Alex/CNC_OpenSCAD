include <sfu1605_nut_dim.scad>
include <colors.scad>
include <bom.scad>

module sfu1605_nut()
{
    color(color_metal_hardened_dark)
    rotate([0,90,0])
    difference()
    {
        intersection()
        {
            union()
            {
                cylinder(sfu1605_nut_big_len, sfu1605_nut_big_dia/2, sfu1605_nut_big_dia/2, center = false);

                translate([0,0,sfu1605_nut_big_len])
                    cylinder(sfu1605_nut_small_len, sfu1605_nut_small_dia/2, sfu1605_nut_small_dia/2, center = false);
            }
            translate([-sfu1605_nut_cut_len/2,-sfu1605_nut_big_dia/2,0])
                cube([sfu1605_nut_cut_len,sfu1605_nut_big_dia,sfu1605_nut_len]);
        }
        translate([0,0,-1])
            cylinder(sfu1605_nut_big_len + sfu1605_nut_small_len+2, sfu1605_nut_inner_dia/2, sfu1605_nut_inner_dia/2, center = false);
        translate([0,sfu1605_nut_hole_distance/2,-1])
            cylinder(sfu1605_nut_small_len + 2, sfu1605_nut_hole_dia/2, sfu1605_nut_hole_dia/2, center = false);
        translate([0,-sfu1605_nut_hole_distance/2,-1])
            cylinder(sfu1605_nut_small_len + 2, sfu1605_nut_hole_dia/2, sfu1605_nut_hole_dia/2, center = false);
        translate([sfu1605_nut_hole_distance/2*sin(sfu1605_nut_hole_angle),sfu1605_nut_hole_distance/2*cos(sfu1605_nut_hole_angle),-1])
            cylinder(sfu1605_nut_small_len + 2, sfu1605_nut_hole_dia/2, sfu1605_nut_hole_dia/2, center = false);
        translate([-sfu1605_nut_hole_distance/2*sin(sfu1605_nut_hole_angle),sfu1605_nut_hole_distance/2*cos(sfu1605_nut_hole_angle),-1])
            cylinder(sfu1605_nut_small_len + 2, sfu1605_nut_hole_dia/2, sfu1605_nut_hole_dia/2, center = false);
        translate([sfu1605_nut_hole_distance/2*sin(sfu1605_nut_hole_angle),-sfu1605_nut_hole_distance/2*cos(sfu1605_nut_hole_angle),-1])
            cylinder(sfu1605_nut_small_len + 2, sfu1605_nut_hole_dia/2, sfu1605_nut_hole_dia/2, center = false);
        translate([-sfu1605_nut_hole_distance/2*sin(sfu1605_nut_hole_angle),-sfu1605_nut_hole_distance/2*cos(sfu1605_nut_hole_angle),-1])
            cylinder(sfu1605_nut_small_len + 2, sfu1605_nut_hole_dia/2, sfu1605_nut_hole_dia/2, center = false);
    }
    bom_item("sfu1605_nut");
}
