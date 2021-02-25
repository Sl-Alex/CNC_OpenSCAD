include <colors.scad>
include <bom.scad>
include <MCAD/nuts_and_bolts.scad>
use <MCAD/regular_shapes.scad>

delta = 0.1;

MX_NUT_IN_DIA =
[
    -1,  // 0
    -1,  // 1
    -1,  // 2
    3.2, // 3
    4.3, // 4
    5.3, // 5
    6.4, // 6
    -1,  // 7
    8.4, // 8
    -1,  // 9
    10.5,// 10
    -1,  // 11
    13   // 12
];

module mx_nut(dia)
{
    color(color_metal_hardened)
    
    translate([0,0,-METRIC_NUT_THICKNESS[dia]])
    //translate([0,0,-MX_WASHER_th[dia]])
    difference()
    {
        linear_extrude(METRIC_NUT_THICKNESS[dia],false)
        hexagon(METRIC_NUT_AC_WIDTHS[dia]/2);

        translate([0,0,-delta])
        cylinder(h = METRIC_NUT_THICKNESS[dia]+2*delta, d = MX_NUT_IN_DIA[dia]);
    }
    bom_item(str("m", dia, "_nut"));
}

mx_nut(6);