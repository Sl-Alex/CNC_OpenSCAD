include <colors.scad>
use     <bom.scad>
include <bracket_small_dim.scad>

th_side = 3.2;
nut_co_w = 7;
nut_w = 8;
nut_th = 1.5;

module side()
{
    difference()
    {
        union()
        {
            cube(size = [bracket_small_l,bracket_small_w,bracket_small_th], center = false);
            translate([0,(bracket_small_w-nut_w)/2,0])
                rotate([-90,0,0])
                    linear_extrude(height = nut_w, center = false)
                        polygon(points=[[0,0],[nut_th,0],[0,nut_th]]);
            translate([bracket_small_l-bracket_small_th,(bracket_small_w-nut_w)/2,0])
                rotate([-90,0,0])
                    linear_extrude(height = nut_w, center = false)
                        polygon(points=[[0,0],[nut_th,0],[0,nut_th]]);
        }
        translate([bracket_small_nut_co_off1,(bracket_small_w-nut_co_w)/2,-0.1])
            cube(size = [bracket_small_nut_co_l1, nut_co_w, , bracket_small_th + 0.2]);
    }
}

module bracket_small()
{
    translate([0,-bracket_small_w/2,0])
    color(color_alu)
    union()
    {
        side();
        mirror(v= [1, 0, 0] )
            rotate([0,-90,0])
                side();

        rotate([90,0,0])
        {
            translate([0,0,-th_side])
                    linear_extrude(height = th_side, center = false)
                        polygon(points=[[bracket_small_th,bracket_small_th],[bracket_small_l,bracket_small_th],[bracket_small_th,bracket_small_l]]);
            translate([0,0,-bracket_small_w])
                    linear_extrude(height = th_side, center = false)
                        polygon(points=[[bracket_small_th,bracket_small_th],[bracket_small_l,bracket_small_th],[bracket_small_th,bracket_small_l]]);
        }
    }
    bom_item("bracket_small");
}

bracket_small();
