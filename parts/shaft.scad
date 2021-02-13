include <colors.scad>
include <bom.scad>

module shaft(dia, len)
{
    color(color_metal_hardened)
    rotate([0,0,90])
    rotate([90,0,0])
    cylinder(len, dia/2, dia/2);
    bom_item(str("shaft_",dia,"x",len));
}
