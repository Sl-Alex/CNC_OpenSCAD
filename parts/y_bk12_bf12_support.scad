use <MCAD/regular_shapes.scad>
include <colors.scad>
include <bom.scad>
include <y_bk12_bf12_support_dim.scad>

profile_h = 30;
profile_pad_w = 8;
profile_pad_th = 1;

delta = 0.5;

base_l = 60;
y_bk12_bf12_support_th = 5; // TODO!

m6_dia = 6.5;
m6_distance = 46;

module y_bk12_bf12_base ()
{
    translate([0,0,y_bk12_bf12_support_th/2])
    cube([
        base_l,
        profile_h,
        y_bk12_bf12_support_th
        ],center=true);
}


module y_bk12_bf12_profile_pad()
{
    translate([0,0,-profile_pad_th/2])
    cube([
        base_l,
        profile_pad_w, 
        profile_pad_th
        ],center=true);
}

module y_bk12_bf12_m6_pocket()
{
    translate([0,0,-delta-profile_pad_th])
    linear_extrude(y_bk12_bf12_support_th + 2 * delta + 2*profile_pad_th)
    circle(r = m6_dia/2);
}

module y_bk12_bf12_support()
{
    color(color_plastic_black)
    difference()
    {
        union()
        {
            y_bk12_bf12_base();
            y_bk12_bf12_profile_pad();
        }
        translate([ -m6_distance/2,  0, 0])
            y_bk12_bf12_m6_pocket();
        translate([m6_distance/2,  0, 0])
            y_bk12_bf12_m6_pocket();
    }
    bom_item("y_bk12_bf12_support");
}