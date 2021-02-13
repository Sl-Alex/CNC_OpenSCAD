include <sfu1605_dim.scad>
include <colors.scad>
include <bom.scad>

module sfu1605(length)
{
    color(color_metal_hardened)
    rotate([0,90,0])
    union()
    {
        cylinder(sfu1605_fixed_end_len, sfu1605_fixed_end_dia/2, sfu1605_fixed_end_dia/2, center = false);

        translate([0,0,sfu1605_fixed_end_len])
            cylinder(sfu1605_fixed_end_bearings_len, sfu1605_fixed_end_bearings_dia/2, sfu1605_fixed_end_bearings_dia/2, center = false);

        translate([0,0,sfu1605_fixed_end_bearings_len + sfu1605_fixed_end_len])
            cylinder(length - sfu1605_fixed_end_bearings_len - sfu1605_fixed_end_len - sfu1605_floating_end_len, sfu1605_thread_dia/2, sfu1605_thread_dia/2, center = false);

        translate([0,0,length - sfu1605_floating_end_len])
            cylinder(sfu1605_floating_end_len, sfu1605_floating_end_dia/2, sfu1605_floating_end_dia/2, center = false);
    }
    bom_item(str("sfu1605_", length));
}
