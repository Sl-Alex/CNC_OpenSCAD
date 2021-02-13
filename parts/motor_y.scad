use <MCAD/regular_shapes.scad>
include <colors.scad>
include <bom.scad>
include <motor_y_dim.scad>

motor_w = 57;
motor_pad_r = 20;
bk12_axis_h = 25;
profile_h = 30;
profile_pad_w = 8;
profile_pad_th = 1;

holder_side_th = 5;
delta = 0.5;

base_l = motor_w + 15*2;

nut_radius = 8.8/2;
nut_delta = 0.2;
nut_th = 4.5;
nut_distance = 47.14;
m5_dia = 5.3;
m6_dia = 6.5;

window_th = 5;
window_w = 30;

module base ()
{
    translate([0,0,motor_y_th/2])
    cube([
        base_l,
        profile_h * 2,
        motor_y_th
        ],center=true);
}


module nut_pocket()
{
    translate([ 0, 0, -delta])
    {
        linear_extrude(nut_th+delta, center = false)
        hexagon(nut_radius + nut_delta);
        translate([0,0,3*delta])
        linear_extrude(motor_y_th)
        circle(r = m5_dia/2);
    }
}

module profile_pad()
{
    translate([0,0,-profile_pad_th/2])
    cube([
        base_l,
        profile_pad_w, 
        profile_pad_th
        ],center=true);
}

module m6_pocket()
{
    translate([0,0,-delta-profile_pad_th])
    linear_extrude(motor_y_th + 2 * delta + 2*profile_pad_th)
    circle(r = m6_dia/2);
}

module motor_cutout()
{
    translate([0,0,-delta-profile_pad_th])
    linear_extrude(motor_y_th + +profile_pad_th + 2*delta)
    circle(r = motor_pad_r);
}

module window()
{
    translate([0,0,(motor_y_th-window_th-profile_pad_th)/2])
    cube([
        window_w+2*delta,
        profile_h * 2 + 2*delta,
        motor_y_th-window_th+delta+profile_pad_th
        ],center=true);
}

module motor_y()
{
    color(color_plastic_black)
    rotate([0,-90,0])
    translate([0,0,-motor_y_th])
    difference()
    {
        union()
        {
            base();
            translate([0, profile_h/2,0])
                profile_pad();
            translate([0,-profile_h/2,0])
                profile_pad();
        }
        motor_cutout();
        {
            translate([ nut_distance/2,  nut_distance/2, 0])
                nut_pocket();
            translate([ nut_distance/2, -nut_distance/2, 0])
                nut_pocket();
            translate([-nut_distance/2,  nut_distance/2, 0])
                nut_pocket();
            translate([-nut_distance/2, -nut_distance/2, 0])
                nut_pocket();
        }
        window();
        translate([ base_l/2-7,  profile_h/2, 0])
            m6_pocket();
        translate([ base_l/2-7, -profile_h/2, 0])
            m6_pocket();
        translate([-base_l/2+7,  profile_h/2, 0])
            m6_pocket();
        translate([-base_l/2+7, -profile_h/2, 0])
            m6_pocket();
    }
    bom_item("motor_holder_y");
}

//motor_y();
