include <colors.scad>
include <bom.scad>
include <bracket_big_dim.scad>

th_side = 5.5;
nut_co_w = 6.5;
nut_w = 8;
nut_th = 2.5;

module side()
{
    difference()
    {
        union()
        {
            cube(size = [bracket_big_l,bracket_big_w,bracket_big_th], center = false);
            translate([0,(bracket_big_w-nut_w)/2,0])
                rotate([-90,0,0])
                    linear_extrude(height = nut_w, center = false)
                        polygon(points=[[0,0],[nut_th,0],[0,nut_th]]);
            translate([bracket_big_l-bracket_big_th,(bracket_big_w-nut_w)/2,0])
                rotate([-90,0,0])
                    linear_extrude(height = nut_w, center = false)
                        polygon(points=[[0,0],[nut_th,0],[0,nut_th]]);
        }
        translate([bracket_big_nut_co_off1,(bracket_big_w-nut_co_w)/2,-0.1])
            cube(size = [bracket_big_nut_co_l1, nut_co_w, bracket_big_th + 0.2]);
        translate([bracket_big_nut_co_off2,(bracket_big_w-nut_co_w)/2,-0.1])
            cube(size = [bracket_big_nut_co_l2, nut_co_w, bracket_big_th + 0.2]);
    }
}


module bracket_big()
{
    color(color_alu)
    translate([0,-bracket_big_w/2,0])
    union()
    {    
        side();
        mirror(v= [1, 0, 0] )
            rotate([0,-90,0])
                side();

        translate([0,th_side,0])
            rotate([90,0,0])
                linear_extrude(height = th_side, center = false)
                    polygon(points=[[bracket_big_th,bracket_big_th],[bracket_big_l,bracket_big_th],[bracket_big_th,bracket_big_l]]);
    }
    bom_item("bracket_big");
}

bracket_big();