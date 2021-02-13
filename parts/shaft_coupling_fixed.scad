use <MCAD/regular_shapes.scad>
include <colors.scad>
include <bom.scad>
include <shaft_coupling_fixed_dim.scad>

D = 25;
L = shaft_coupling_fixed_L;

delta = 0.01;
screw_head_dia = 5;
screw_head_th = 2;
screw_dia = 3;
screw_head_hex_r = 3;
screw_distance = 3;

color_error = "#FF000050";

module shaft_coupling_fixed_screw()
{
    color(color_metal_black)
    rotate([-90,0,0])
    {
        difference()
        {
            cylinder(screw_head_th,screw_head_dia/2,screw_head_dia/2);
            translate([0,0,screw_head_th/3])
            linear_extrude(screw_head_th*2/3+delta, center = false)
    hexagon(screw_head_hex_r/2);
        }
        mirror([0,0,1])
        cylinder(screw_distance + 2,screw_dia/2,screw_dia/2);
    }
}

module shaft_coupling_fixed(d1, d2, shaft_distance)
{
    translate([-L/2,0,0])
    rotate([90,0,0])
    rotate([0,90,0])
    union()
    {
        color(color_alu)
        difference()
        {
            cylinder(L, D/2, D/2);
            translate([0,0,-L/2+delta])
            cylinder(L, d1/2, d1/2);
            translate([0,0,L/2-delta])
            cylinder(L, d2/2, d2/2);
            translate([-D/6,0,L/2])
            cube([D,1,L+2*delta],center=true);
            translate([0,D/2,L/2])
            cube([D+2*delta,D+2*delta,1],center=true);
            rotate([90,0,0])
            translate([-D/3,L/4,-screw_distance-D/2])
            cylinder(D/2,screw_head_dia/2,screw_head_dia/2);
            rotate([90,0,0])
            translate([-D/3,L*3/4,-screw_distance-D/2])
            cylinder(D/2,screw_head_dia/2,screw_head_dia/2);
        }
        translate([-D/3,screw_distance,L/4])
        shaft_coupling_fixed_screw();
        translate([-D/3,screw_distance,L*3/4])
        shaft_coupling_fixed_screw();
    }
    bom_item(str("shaft_coupling_fixed_",d1,"x",d2));
}

//shaft_coupling_fixed(8,10,0, $fn = 50);
