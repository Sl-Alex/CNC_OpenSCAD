use <bom.scad>
include <colors.scad>
include <profile_30_dim.scad>

module profile_30x30(length)
{
    color(color_alu)
    translate([0,0,profile_h])
    rotate([0,90,0]) 
    linear_extrude(length)
    import("Profile_30x30_B.dxf");
    bom_item(str("profile_30x30x", length));
}

profile_30x30(100);
