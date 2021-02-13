include <colors.scad>
include <bom.scad>
include <mx_washer_dim.scad>

MX_WASHER_d1 =
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

MX_WASHER_d2 =
[
    -1, // 0
    -1, // 1
    -1, // 2
    7,  // 3
    9,  // 4
    10, // 5
    12, // 6
    -1, // 7
    16, // 8
    -1, // 9
    20, // 10
    -1, // 11
    24  // 12
];

delta = 0.1;

module mx_washer(dia)
{
    color(color_metal_hardened)
    
    translate([0,0,-MX_WASHER_th[dia]])
    difference()
    {
        cylinder(MX_WASHER_th[dia], MX_WASHER_d2[dia]/2, MX_WASHER_d2[dia]/2);
        translate([0,0,-delta])
        cylinder(MX_WASHER_th[dia]+2*delta, MX_WASHER_d1[dia]/2, MX_WASHER_d1[dia]/2);
    }
    bom_item(str("m", dia, "_washer"));
}

mx_washer(6);