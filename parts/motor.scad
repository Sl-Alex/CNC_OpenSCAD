use <bom.scad>
include <colors.scad>
include <motor_dim.scad>

// 23HS8440 (NEMA23 4A motor)
chamfer_r = 1;

module motor_pad()
{
    color(color_alu)
    translate([0,0,-motor_pad_th])
    cylinder(motor_pad_th, motor_pad_dia/2, motor_pad_dia/2);
}

module motor_shaft()
{
    color(color_metal_hardened)
    translate([0,0,-motor_shaft_l])
    difference()
    {
        cylinder(motor_shaft_l, motor_shaft_dia/2, motor_shaft_dia/2);
        translate([motor_shaft_dia/2-motor_shaft_cut_th,-motor_shaft_dia/2,-1])
        cube([motor_shaft_dia,motor_shaft_dia,motor_shaft_cut_l+1]);
    }
}

module motor_base()
{
    color(color_metal_black)
    translate([0,0,motor_alu_th])
    linear_extrude(motor_l - motor_alu_th, false)
    offset(r = chamfer_r, chamfer = true)
    union()
    {
        square([motor_w-chamfer_r*2, motor_pad_dia-chamfer_r*2],true);
        rotate([0,0,90])
            square([motor_w-chamfer_r*2, motor_pad_dia-chamfer_r*2],true);
    }
    color(color_metal_black)
    translate([0,0,motor_holder_th])
    linear_extrude(motor_alu_th-motor_holder_th, false)
    offset(r = chamfer_r, chamfer = true)
    union()
    {
        square([motor_w-chamfer_r*2, motor_pad_dia-chamfer_r*2],true);
        rotate([0,0,90])
            square([motor_w-chamfer_r*2, motor_pad_dia-chamfer_r*2],true);
    }
}

module motor_base_holder()
{
    linear_extrude(motor_holder_th, false)
    offset(r = chamfer_r, chamfer = true)
    square(motor_w-chamfer_r*2,true);
}

module motor()
{
    rotate([0,-90,0])
    union()
    {
        motor_shaft();
        motor_pad();
        motor_base();
        color(color_alu)
        difference()
        {
            motor_base_holder();
            translate([ motor_holder_hole_offset,  motor_holder_hole_offset, -1])
            cylinder(motor_holder_th + 2, motor_holder_hole_dia/2, motor_holder_hole_dia/2);
            translate([ motor_holder_hole_offset, -motor_holder_hole_offset, -1])
            cylinder(motor_holder_th + 2, motor_holder_hole_dia/2, motor_holder_hole_dia/2);
            translate([-motor_holder_hole_offset,  motor_holder_hole_offset, -1])
            cylinder(motor_holder_th + 2, motor_holder_hole_dia/2, motor_holder_hole_dia/2);
            translate([-motor_holder_hole_offset, -motor_holder_hole_offset, -1])
            cylinder(motor_holder_th + 2, motor_holder_hole_dia/2, motor_holder_hole_dia/2);
        }
    }
    bom_item("motor");
}
