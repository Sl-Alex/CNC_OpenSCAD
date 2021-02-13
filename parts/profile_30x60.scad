use <bom.scad>
include <colors.scad>
include <profile_30_dim.scad>

module profile_30x60(length)
{
	color(color_alu)
    rotate([0,90,0])
    rotate([0,0,90])
	linear_extrude(length)
	import("Profile_30x60_B.dxf");
	bom_item(str("profile_30x60x", length));
}
