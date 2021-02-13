use <MCAD/regular_shapes.scad>
include <colors.scad>
include <bom.scad>
include <motor_x_dim.scad>

motor_pad_r = 20;
motor_w = 57;
bk12_shaft_h = 25;
profile_h = 30;
profile_pad_w = 8;
profile_pad_th = 1;

holder_side_th = 5;
delta = 0.5;

nut_radius = 8.8/2;
nut_delta = 0.2;
nut_th = 4.5;
nut_distance = 47.14;
m5_dia = 5.3;
m6_dia = 6.5;

module base ()
{
    cube([
        motor_x_h + motor_w/2, 
        motor_w + delta * 2 + holder_side_th * 2,
        motor_x_th
        ],center=false);
}

module nut_pocket()
{
    rotate([0,0,90])
    linear_extrude(nut_th+delta, center = false)
    hexagon(nut_radius + nut_delta);
    translate([0,0,3*delta])
    linear_extrude(motor_x_th)
    circle(r = m5_dia/2);
}

module profile_pad()
{
    translate([0,0,-profile_pad_th])
    cube([
        profile_pad_w, 
        motor_w + delta * 2 + holder_side_th * 2,
        profile_pad_th
        ],center=false);
}

module m6_pocket()
{
    translate([0,0,-delta-profile_pad_th])
    linear_extrude(motor_x_th + 2 * delta + 2*profile_pad_th)
    circle(r = m6_dia/2);
}

module motor_cutout()
{
    linear_extrude(motor_x_th + 2*delta)
    circle(r = motor_pad_r);
}

module motor_x()
{
    color(color_plastic_black)
    rotate([0,-90,0])
    translate([-profile_h-bk12_shaft_h,-motor_w/2-holder_side_th,-motor_x_th])
    difference()
    {
        union()
        {
            base();
            translate([-profile_pad_w/2+profile_h/2,0,0])
                profile_pad();
        }
        translate([profile_h + bk12_shaft_h, motor_w/2 + delta + holder_side_th,-delta])
        {
            motor_cutout();
            translate([ nut_distance/2,  nut_distance/2, -delta])
                nut_pocket();
            translate([ nut_distance/2, -nut_distance/2, -delta])
                nut_pocket();
            translate([-nut_distance/2,  nut_distance/2, -delta])
                nut_pocket();
            translate([-nut_distance/2, -nut_distance/2, -delta])
                nut_pocket();
        }
        translate([profile_h/2, 10, 0])
            m6_pocket();
        translate([profile_h/2, motor_w + delta * 2 + holder_side_th * 2 - 10, 0])
            m6_pocket();
    }
    bom_item("motor_holder_x");
}

//motor_x();