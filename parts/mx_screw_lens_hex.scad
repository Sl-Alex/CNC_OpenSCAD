include <MCAD/regular_shapes.scad>
include <colors.scad>
include <bom.scad>

MX_SCREW_LENS_HEX_t =
[
    -1, // 0
    -1, // 1
    -1, // 2
    1.4,// 3
    1.7,// 4
    2.2,// 5
    2.4,// 6
    -1, // 7
    3.2,// 8
    -1, // 9
    3.8,// 10
    -1, // 11
    4.4 // 12
];
 
MX_SCREW_LENS_HEX_k =
[
    -1,  // 0
    -1,  // 1
    -1,  // 2
    1.65,// 3
    2.2, // 4
    2.75,// 5
    3.3, // 6
    -1,  // 7
    4.4, // 8
    -1,  // 9
    5.5, // 10
    -1,  // 11
    6.6  // 12
];

MX_SCREW_LENS_HEX_SW =
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
    -1, // 11
    8   // 12
];
 
MX_SCREW_LENS_HEX_d1 =
[
    -1,  // 0
    -1,  // 1
    -1,  // 2
    5.7, // 3
    7.6, // 4
    9.5, // 5
    10.5,// 6
    -1,  // 7
    14,  // 8
    -1,  // 9
    17.5,// 10
    -1,  // 11
    21   // 12
];

module mx_screw_lens_hex(dia, length)
{
    rotate([180,0,0])
    color(color_metal)
    union()
    {
        linear_extrude(length)
        circle(r = dia/2);
        
        difference()
        {
            intersection()
            {
                translate([0,0,-MX_SCREW_LENS_HEX_k[dia]])
                linear_extrude(MX_SCREW_LENS_HEX_k[dia])
                circle(r = MX_SCREW_LENS_HEX_d1[dia]/2);
                
                /* A bit of magic to make a nice look */
                translate([0,0,1.5])
                sphere(5.6);
            }
            
            translate([0,0,-MX_SCREW_LENS_HEX_k[dia] - 1])
            hexagon_prism(MX_SCREW_LENS_HEX_t[dia] + 1, MX_SCREW_LENS_HEX_SW[dia]/2);
        }
    }
    bom_item(str("m", dia, "x", length, "_screw_lens_hex"));
}

mx_screw_lens_hex(6,10);