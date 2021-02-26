include <colors.scad>
include <bom.scad>

milling_cutter_len = 38;
milling_cutter_dia = 3;

milling_cutter_cone_len = 15;

module milling_cutter()
{
    translate([0,0,-milling_cutter_len])
    {
        color(color_metal_hardened)
        translate([0,0,milling_cutter_cone_len])
        cylinder(h = milling_cutter_len-milling_cutter_cone_len, d = milling_cutter_dia);
        
        color(color_metal_hardened_dark)
        cylinder(h = milling_cutter_cone_len, r1 = 0, r2 = milling_cutter_dia/2);
    }
    bom_item("milling_cutter");
}

milling_cutter($fn=100);
