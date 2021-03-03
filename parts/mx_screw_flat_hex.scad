include <MCAD/regular_shapes.scad>
include <colors.scad>
include <bom.scad>

MX_SCREW_FLAT_HEX_t =
[
    -1, // 0
    -1, // 1
    -1, // 2
    1.2,// 3
    1.8,// 4
    2.3,// 5
    2.5,// 6
    -1, // 7
    3.5,// 8
    -1, // 9
    4.4,// 10
];
 
MX_SCREW_FLAT_HEX_k =
[
    -1,  // 0
    -1,  // 1
    -1,  // 2
    1.7, // 3
    2.3, // 4
    2.8, // 5
    3.3, // 6
    -1,  // 7
    4.4, // 8
    -1,  // 9
    5.5, // 10
];

MX_SCREW_FLAT_HEX_S =
[
    -1, // 0
    -1, // 1
    -1, // 2
    2,  // 3
    2.5,// 4
    3,  // 5
    4,  // 6
    -1, // 7
    5,  // 8
    -1, // 9
    6,  // 10
];
 
MX_SCREW_FLAT_HEX_d1 =
[
    -1,  // 0
    -1,  // 1
    -1,  // 2
    6,   // 3
    8,   // 4
    10,  // 5
    12,  // 6
    -1,  // 7
    16,  // 8
    -1,  // 9
    20,  // 10
];

module mx_screw_flat_hex(dia, length)
{
    rotate([180,0,0])
    color(color_metal)
    union()
    {
        translate([0,0,MX_SCREW_FLAT_HEX_k[dia]])
        linear_extrude(length-MX_SCREW_FLAT_HEX_k[dia])
        circle(r = dia/2);
        
        difference()
        {
            intersection()
            {
                translate([0,0,0])
                cylinder(h = MX_SCREW_FLAT_HEX_k[dia], d1 = MX_SCREW_FLAT_HEX_d1[dia], d2 = dia);
            }
            
            translate([0,0, - 1])
            hexagon_prism(MX_SCREW_FLAT_HEX_t[dia] + 1, MX_SCREW_FLAT_HEX_S[dia]/2);
        }
    }
    bom_item(str("m", dia, "x", length, "_screw_lens_hex"));
}

mx_screw_flat_hex(6,20);