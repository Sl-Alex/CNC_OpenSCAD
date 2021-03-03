include <MCAD/regular_shapes.scad>
include <colors.scad>
include <bom.scad>
include <motor_z_dim.scad>

motor_w = 57;
motor_nuts_distance = 47.15;
plate_th = 10;
bk12_h = 25;

motor_holder_h = plate_th + bk12_h + motor_w/2;
motor_r = 20;

nut_r = 8.8/2;
nut_delta = 0.2;
nut_th = 5;
nut_r_m = (8 + nut_delta)/2;
m5_hole_r = 5.5/2;
m5_lens_head_r = 9.5/2;

plate_holder_distance = 14;

walls_th = 15;

connector_l = bk12_h + motor_nuts_distance/2 - nut_r_m;

delta = 0.05;

module motor_holder()
{
    cube(size = [motor_holder_h,motor_w,motor_z_th], center = false);
}

module nut_with_hole()
{
    union()
    {
        translate([0,0,-delta])
        cylinder(10 + delta, m5_hole_r, m5_hole_r, center = false);
        translate([0,0,motor_z_th-nut_th])
        rotate([0,0,90])
        hexagon_prism(nut_th + delta, nut_r + nut_delta);
    }
}

module nuts_with_holes()
{
    translate([ motor_nuts_distance/2, motor_nuts_distance/2,0])
    nut_with_hole();
    translate([ motor_nuts_distance/2,-motor_nuts_distance/2,0])
    nut_with_hole();
    translate([-motor_nuts_distance/2, motor_nuts_distance/2,0])
    nut_with_hole();
    translate([-motor_nuts_distance/2,-motor_nuts_distance/2,0])
    nut_with_hole();
}

module walls_cutout()
{
    translate([0,-delta,0])
        rotate([-90,0,0])
            linear_extrude(motor_w/2-motor_nuts_distance/2+nut_r+delta)
                polygon([[-delta,delta],[nut_r_m,delta],[nut_r_m,-nut_th],[-delta,-nut_th-2*nut_r_m]]);
}

module motor_walls()
{
    difference()
    {
        intersection()
        {
            cube(size = [connector_l, motor_w,connector_l], center = false);
            rotate([-90,0,0])
            cylinder(motor_w+2*delta, connector_l, connector_l, center = false);
        }
        walls_cutout();
        translate([0,motor_w/2+motor_nuts_distance/2-nut_r+delta,0])
        walls_cutout();

        translate([walls_th,walls_th,-delta])
        {
            cube(size = [motor_holder_h - plate_th - walls_th + delta, motor_w-walls_th*2,connector_l+2*delta], center = false);
        }
        plate_holders();
    }
    
}

module motor_z()
{
    color(color_plastic_black)
    rotate([0,90,0])
    rotate([0,0,180])
    translate([-motor_holder_h+motor_w/2,-motor_w/2,0])
    difference()
    {
        union()
        {
            motor_holder();
            translate([plate_th,0,motor_z_th])
            motor_walls();
        }
        translate([motor_holder_h-motor_w/2,motor_w/2,0])
        {
            nuts_with_holes();
            translate([0,0,-delta])
            cylinder(motor_z_th + 2*delta + connector_l, motor_r, motor_r, center = false);
        }
    }
    if ($children > 0)
    {
        translate([plate_th,0,-bk12_h+motor_z_plate_holder_th-delta])
        translate([connector_l/2,0,0])
        rotate([0,0,90])
        {
        translate([ plate_holder_distance,plate_holder_distance,0])
        children(0);
        translate([ plate_holder_distance,-plate_holder_distance,0])
        children(0);
        translate([ -plate_holder_distance,plate_holder_distance,0])
        children(0);
        translate([ -plate_holder_distance,-plate_holder_distance,0])
        children(0);
        }
    }
    bom_item("motor_holder_z");
}

module plate_holder()
{
    translate([bk12_h,motor_w/2,connector_l/2])
    rotate([0,90,180])
    {
        translate([0,0,bk12_h-motor_z_plate_holder_th-delta])
        cylinder(bk12_h-motor_z_plate_holder_th+delta, m5_hole_r, m5_hole_r, center = false);
        cylinder(bk12_h-motor_z_plate_holder_th, m5_lens_head_r, m5_lens_head_r, center = false);
    }
}

module plate_holders()
{
    translate([0, plate_holder_distance, plate_holder_distance])
    plate_holder();
    translate([0, plate_holder_distance,-plate_holder_distance])
    plate_holder();
    translate([0,-plate_holder_distance, plate_holder_distance])
    plate_holder();
    translate([0,-plate_holder_distance,-plate_holder_distance])
    plate_holder();
}

module motor_z_plate_holes(dia, plate_th)
{
    translate([plate_th,0,-bk12_h-motor_r/2-delta])
    translate([connector_l/2,0,0])
    rotate([0,0,90])
    {
    translate([ plate_holder_distance,plate_holder_distance,0])
    cylinder(plate_th+2*delta, dia/2, dia/2);
    translate([ plate_holder_distance,-plate_holder_distance,0])
    cylinder(plate_th+2*delta, dia/2, dia/2);
    translate([ -plate_holder_distance,plate_holder_distance,0])
    cylinder(plate_th+2*delta, dia/2, dia/2);
    translate([ -plate_holder_distance,-plate_holder_distance,0])
    cylinder(plate_th+2*delta, dia/2, dia/2);
    }
}

motor_z($fn=50)
{
    cube(1);
}

motor_z_plate_holes(6,10);