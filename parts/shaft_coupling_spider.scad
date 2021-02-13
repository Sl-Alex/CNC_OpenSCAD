include <sfu1605_dim.scad>
include <colors.scad>
include <bom.scad>
include <shaft_coupling_spider_dim.scad>

c_th = 6.5;

delta = 0.5;
screw_head_dia = 5;
screw_head_th = 2;
screw_dia = 3;
screw_distance = 3;

color_error = "#FF000050";

module shaft_coupling_spider_insertion()
{
    translate([0,0,delta])
    intersection()
    {
        cylinder(shaft_coupling_spider_l_i-2*delta, (shaft_coupling_spider_D+delta)/2, (shaft_coupling_spider_D+delta)/2, center = false);

        union()
        {
            translate([-c_th/2,-(shaft_coupling_spider_D+20)/2,0])
            cube([c_th,shaft_coupling_spider_D+20,shaft_coupling_spider_l_i-2*delta]);
            translate([-(shaft_coupling_spider_D+20)/2,-c_th/2,0])
            cube([shaft_coupling_spider_D+20,c_th,shaft_coupling_spider_l_i-2*delta]);
        }
    }
}

module shaft_coupling_spider_cutout()
{
    intersection()
    {
        cylinder(shaft_coupling_spider_l_i+1, shaft_coupling_spider_D/2+1, shaft_coupling_spider_D/2+1, center = false);

        union()
        {
            translate([-c_th/2,-(shaft_coupling_spider_D+20)/2,0])
            cube([c_th,shaft_coupling_spider_D+20,shaft_coupling_spider_l_i+1]);
            translate([-(shaft_coupling_spider_D+20)/2,-c_th/2,0])
            cube([shaft_coupling_spider_D+20,c_th,shaft_coupling_spider_l_i+1]);
        }
    }
    cube([shaft_coupling_spider_D+1,shaft_coupling_spider_D+1,shaft_coupling_spider_l_i+1]);
    rotate([0,0,180])
    cube([shaft_coupling_spider_D+1,shaft_coupling_spider_D+1,shaft_coupling_spider_l_i+1]);
}

module shaft_coupling_spider_end(d)
{
    color(color_alu)
    difference()
    {
        cylinder(shaft_coupling_spider_l_o + shaft_coupling_spider_l_i - 0.8*delta, shaft_coupling_spider_D/2, shaft_coupling_spider_D/2, center = false);
    
        translate([0,0,shaft_coupling_spider_l_o])
        {
            shaft_coupling_spider_cutout();
        }
        translate([0,0,-delta])
        cylinder(shaft_coupling_spider_l_o + shaft_coupling_spider_l_i+2*delta, d/2 ,d/2, center = false);

        rotate([0,0,45])
        translate([-shaft_coupling_spider_D/4,-0.5,-delta])
        cube([shaft_coupling_spider_D,1,shaft_coupling_spider_l_o+2*delta]);

        rotate([0,0,45])
        rotate([90,0,0])
        translate([d/2+(shaft_coupling_spider_D-d)/4,shaft_coupling_spider_l_o/2,screw_distance])
        cylinder(shaft_coupling_spider_D/2,screw_head_dia/2,screw_head_dia/2);
    }
    color(color_metal_black)
    rotate([0,0,45])
    rotate([90,0,0])
    translate([d/2+(shaft_coupling_spider_D-d)/4,shaft_coupling_spider_l_o/2,screw_distance-0.5])
    {
        cylinder(screw_head_th,screw_head_dia/2,screw_head_dia/2);
        mirror([0,0,1])
        cylinder(screw_distance + 2,screw_dia/2,screw_dia/2);
    }
}

module shaft_coupling_spider(d1, d2, shaft_distance = shaft_coupling_spider_l_i)
{
    fail = ((shaft_distance < shaft_coupling_spider_l_i) || (shaft_distance > (1.8 * shaft_coupling_spider_l_i))) ? 1: 0;
    shift_distance = shaft_distance - shaft_coupling_spider_l_i;
    translate([-shaft_coupling_spider_l_o,0,0])
    rotate([-45,0,0])
    rotate([0,90,0])
    {
        /* One end */
        if (fail)
        {
            color(color_error)
            shaft_coupling_spider_end(d1);
        }
        else
        {
            shaft_coupling_spider_end(d1);
        }
        
        /* Opposite end */
        translate([0,0,shift_distance])
        if (fail)
        {
            color(color_error)
            translate([0,0,shaft_coupling_spider_l_o + shaft_coupling_spider_l_i + shaft_coupling_spider_l_o])
            rotate([0,180,0])
            shaft_coupling_spider_end(d2);
        }
        else
        {
            translate([0,0,shaft_coupling_spider_l_o + shaft_coupling_spider_l_i + shaft_coupling_spider_l_o])
            rotate([0,180,0])
            shaft_coupling_spider_end(d2);
        }

        /* Insertion */
        color("red")
        translate([0,0,shaft_coupling_spider_l_o+shift_distance/2])
        shaft_coupling_spider_insertion();

        bom_item(str("shaft_coupling_spider_", d1, "x", d2));
    }
}

shaft_coupling_spider(8,10,15, $fn = 50);
