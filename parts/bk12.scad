include <colors.scad>
include <bom.scad>
include <bk12_dim.scad>

module bk12_lock_nut()
{
    color(color_metal_black)
    translate([bk12_th+bk12_th_ext+0.0,0,bk12_shaft_h])
    rotate([0,90,0])
    union()
    {
    difference()
    {
        intersection()
        {
            translate([0,0,bk12_lock_nut_th/2-0.01])
                cube([bk12_lock_nut_T,bk12_lock_nut_T,bk12_lock_nut_th-0.01], center=true);
            rotate([0,0,45])
            translate([0,0,bk12_lock_nut_th/2-0.01])
                cube([bk12_lock_nut_t,bk12_lock_nut_t,bk12_lock_nut_th-0.01], center=true);
        }
        translate([0,0,-1])
        cylinder(bk12_lock_nut_th+2, (bk12_lock_nut_d-0.01)/2, (bk12_lock_nut_d-0.01)/2);
    }
}
}

module bk12_sealing_thread()
{
    rotate([0,90,0])
    color(color_metal_dark)
    translate([-bk12_shaft_h,0,0])
    union()
    {
        difference()
        {
            union()
            {
                translate([0,0,bk12_sealing_TH - bk12_sealing_th])
                    cylinder(bk12_sealing_th, bk12_sealing_D/2, bk12_sealing_D/2);
                cylinder(bk12_sealing_TH, bk12_sealing_d1/2, bk12_sealing_d1/2);
            }
            translate([0,0,-1])
                cylinder(bk12_sealing_TH+2, bk12_sealing_d2/2, bk12_sealing_d2/2);
        }
    }
}

module bk12_sealing_motor()
{
    rotate([0,90,0])
    translate([-bk12_shaft_h,0,bk12_th + bk12_th_ext - bk12_sealing_TH])
    color(color_metal_dark)
    union()
    {
        difference()
        {
            union()
            {
                cylinder(bk12_sealing_th, bk12_sealing_D/2, bk12_sealing_D/2);
                cylinder(bk12_sealing_TH, bk12_sealing_d1/2, bk12_sealing_d1/2);
            }
            translate([0,0,-1])
                cylinder(bk12_sealing_TH+2, bk12_sealing_d2/2, bk12_sealing_d2/2);
        }
    }
}

module bk12()
{    
    rotate([0,0,180])
    
    translate([-bk12_L/2,0,0])
    union()
    {
        color(color_metal_black)
        difference()
        {
            union()
            {
                translate([0,-bk12_B/2,0])
                cube([bk12_L,bk12_B,bk12_H1]);

                translate([0,-bk12_B1/2,bk12_H-bk12_B1])
                cube([bk12_L+bk12_L1,bk12_B1,bk12_B1]);
            }
            translate([-1,0,bk12_h])
                rotate([0,90,0])
                    cylinder(bk12_L+bk12_L1+2, bk12_bearing_D/2, bk12_bearing_D/2);
            translate([bk12_L/2+bk12_C1/2,bk12_P/2,-1])
            {
                translate([0,0,bk12_H1])
                cylinder(bk12_Z+1,bk12_Y/2,bk12_Y/2);
                cylinder(bk12_H1+2,bk12_X/2,bk12_X/2);
            }
            translate([bk12_L/2-bk12_C1/2,bk12_P/2,-1])
            {
                translate([0,0,bk12_H1])
                cylinder(bk12_Z+1,bk12_Y/2,bk12_Y/2);
                cylinder(bk12_H1+2,bk12_X/2,bk12_X/2);
            }
            translate([bk12_L/2+bk12_C1/2,-bk12_P/2,-1])
            {
                translate([0,0,bk12_H1])
                cylinder(bk12_Z+1,bk12_Y/2,bk12_Y/2);
                cylinder(bk12_H1+2,bk12_X/2,bk12_X/2);
            }
            translate([bk12_L/2-bk12_C1/2,-bk12_P/2,-1])
            {
                translate([0,0,bk12_H1])
                cylinder(bk12_Z+1,bk12_Y/2,bk12_Y/2);
                cylinder(bk12_H1+2,bk12_X/2,bk12_X/2);
            }
            translate([-1,bk12_P/2,bk12_h])
                rotate([0,90,0])
                    cylinder(bk12_L+2,bk12_d2/2,bk12_d2/2);
            translate([-1,-bk12_P/2,bk12_h])
                rotate([0,90,0])
                    cylinder(bk12_L+2,bk12_d2/2,bk12_d2/2);
            translate([-1,bk12_P/2,bk12_h-bk12_E])
                rotate([0,90,0])
                    cylinder(bk12_L+2,bk12_d2/2,bk12_d2/2);
            translate([-1,-bk12_P/2,bk12_h-bk12_E])
                rotate([0,90,0])
                    cylinder(bk12_L+2,bk12_d2/2,bk12_d2/2);
        }
        
        bk12_sealing_motor();
        bk12_sealing_thread();
        bk12_lock_nut();
    }
    bom_item("bk12");
}