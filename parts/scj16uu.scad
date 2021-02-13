include <MCAD/regular_shapes.scad>
include <bom.scad>
include <scj16uu_dim.scad>

delta = 0.01;
screw_head_th = 3;
screw_head_dia = 5;
screw_l   = scj16uu_G-2*scj16uu_chamfer;
screw_dia = 3;
screw_hex_dia = 3;
screw_hex_th = 2;

module scj16uu_adj_screw()
{
    difference()
    {
        cylinder(screw_head_th, screw_head_dia/2, screw_head_dia/2);
        translate([0,0,-delta])
        hexagon_prism(screw_hex_th + delta, screw_hex_dia/2);
    }
    translate([0,0,screw_head_th])
    cylinder(screw_l, screw_dia/2, screw_dia/2);
}

module scj16uu_base()
{
    scj16uu_pad_w=(scj16uu_W-scj16uu_B);
    linear_extrude(scj16uu_L, convexity = 2)
    difference()
    {
        polygon(points = [
            [2*scj16uu_chamfer,0],
            [scj16uu_W/2-scj16uu_H_w/2-(scj16uu_H-scj16uu_G)*tan(45),0],
            [scj16uu_W/2-scj16uu_H_w/2,-(scj16uu_H-scj16uu_G)],
            [scj16uu_W/2+scj16uu_H_w/2,-(scj16uu_H-scj16uu_G)],
            [scj16uu_W/2+scj16uu_H_w/2+(scj16uu_H-scj16uu_G)*tan(45),0],
            [scj16uu_W-2*scj16uu_chamfer,0],
            [scj16uu_W-scj16uu_chamfer,scj16uu_chamfer],
            [scj16uu_W-scj16uu_chamfer,scj16uu_G - scj16uu_A - scj16uu_chamfer],
            [scj16uu_W,scj16uu_G - scj16uu_A],
            [scj16uu_W,scj16uu_G - scj16uu_chamfer],
            [scj16uu_W-scj16uu_chamfer,scj16uu_G],
            [scj16uu_W+scj16uu_chamfer-scj16uu_pad_w, scj16uu_G],
            [scj16uu_W-scj16uu_pad_w, scj16uu_G-scj16uu_chamfer],
            [scj16uu_W/2+scj16uu_pad_w/2, scj16uu_G-scj16uu_chamfer],
            [scj16uu_W/2+scj16uu_pad_w/2-scj16uu_chamfer, scj16uu_G],
            [scj16uu_W/2-scj16uu_pad_w/2+scj16uu_chamfer, scj16uu_G],
            [scj16uu_W/2-scj16uu_pad_w/2, scj16uu_G-scj16uu_chamfer],
            [scj16uu_pad_w, scj16uu_G-scj16uu_chamfer],
            [scj16uu_pad_w-scj16uu_chamfer, scj16uu_G],
            [scj16uu_chamfer,scj16uu_G],
            [0,scj16uu_G-scj16uu_chamfer],
            [0,scj16uu_G - scj16uu_A],
            [scj16uu_chamfer,scj16uu_G - scj16uu_A-scj16uu_chamfer],
            [scj16uu_chamfer,scj16uu_chamfer],
        ]);
        translate([scj16uu_W/2,scj16uu_G-scj16uu_h,0])
        {
            circle(scj16uu_co_ext/2);
        }
    }
}

module scj16uu_insertion()
{
    translate([scj16uu_W/2,scj16uu_G-scj16uu_h,scj16uu_chamfer])
    linear_extrude(scj16uu_L-2*scj16uu_chamfer, convexity = 2)
    difference()
    {
        circle(scj16uu_co_ext/2);
        circle(scj16uu_co_int/2);
    }
}

module scj16uu_holes()
{
    translate([scj16uu_W/2,scj16uu_G+delta,scj16uu_L/2])
    rotate([0,0,0])
    rotate([90,0,0])
    {
    translate([ scj16uu_B/2,  scj16uu_C/2,0])
    cylinder(scj16uu_H, scj16uu_S/2, scj16uu_S/2);
    translate([ scj16uu_B/2, -scj16uu_C/2,0])
    cylinder(scj16uu_H, scj16uu_S/2, scj16uu_S/2);
    translate([-scj16uu_B/2,  scj16uu_C/2,0])
    cylinder(scj16uu_H, scj16uu_S/2, scj16uu_S/2);
    translate([-scj16uu_B/2, -scj16uu_C/2,0])
    cylinder(scj16uu_H, scj16uu_S/2, scj16uu_S/2);
    }
}

module scj16uu_plate_holes(dia, plate_th)
{
    translate([0,0,-1])
    rotate([0,0,90])
    {
    translate([ scj16uu_B/2,  scj16uu_C/2,0])
    cylinder(plate_th+2, dia/2, dia/2);
    translate([ scj16uu_B/2, -scj16uu_C/2,0])
    cylinder(plate_th, dia/2, dia/2);
    translate([-scj16uu_B/2,  scj16uu_C/2,0])
    cylinder(plate_th, dia/2, dia/2);
    translate([-scj16uu_B/2, -scj16uu_C/2,0])
    cylinder(plate_th, dia/2, dia/2);
    }
}

module scj16uu()
{
    color("#A0A0C0")
    difference()
    {
        translate([-scj16uu_L/2,-scj16uu_W/2,-scj16uu_G+scj16uu_h])
        rotate([0,90,0])
        rotate([0,0,90])
        {
            difference()
            {
                scj16uu_base();
                scj16uu_holes();
            }
        }
        translate([-scj16uu_L/2-delta,0,0])
        cube([scj16uu_L+2*delta,scj16uu_W,1]);
    }
    color("#808080")
    difference()
    {
        translate([-scj16uu_L/2,-scj16uu_W/2,-scj16uu_G+scj16uu_h])
        rotate([0,90,0])
        rotate([0,0,90])
        scj16uu_insertion();
        translate([-scj16uu_L/2-delta,0,-delta])
        cube([scj16uu_L+2*delta,scj16uu_W,1+2*delta]);
    }
    color("#505050")
    translate([0,scj16uu_B/2,-scj16uu_G+scj16uu_h-screw_head_th])
    scj16uu_adj_screw();
    bom_item("scj16uu");
}

//scj16uu($fn = 100);
scj16uu_plate_holes(6,15,$fn = 100);
