include <colors.scad>
include <bom.scad>
include <sfu1605_nut_housing_dim.scad>

sfu16_nut_housing_D   = 28;
sfu16_nut_housing_B   = 52;
sfu16_nut_housing_H   = 40;
sfu16_nut_housing_h   = 20;
sfu16_nut_housing_E   = 12;
sfu16_nut_housing_L   = 40;
sfu16_nut_housing_C1  = 8;
sfu16_nut_housing_C2  = 24;
sfu16_nut_housing_P   = 40;
sfu16_nut_housing_PCD = 38;

hole_dia = 5;
hole_l = 10;

delta=0.01;

module sfu1605_nut_housing()
{
    color(color_alu)
    translate([0,-sfu16_nut_housing_B/2,-sfu16_nut_housing_H+sfu16_nut_housing_h])
    rotate([0,0,90])
    rotate([90,0,0])
    difference()
    {
        linear_extrude(sfu16_nut_housing_L, convexity=10)
        difference()
        {
            polygon(points = [
                [sfu16_nut_housing_E,0],
                [sfu16_nut_housing_B-sfu16_nut_housing_E,0],
                [sfu16_nut_housing_B,sfu16_nut_housing_E],
                [sfu16_nut_housing_B,sfu16_nut_housing_H],
                [0,sfu16_nut_housing_H],
                [0,sfu16_nut_housing_E],
            ]);
            translate([sfu16_nut_housing_B/2,sfu16_nut_housing_H-sfu16_nut_housing_h,0])
            circle(sfu16_nut_housing_D/2);
        }
        holes_nut();
        rotate([90,0,0])
        holes_holder();
    }
    /* Screws */
    translate([ sfu16_nut_housing_C1,  sfu16_nut_housing_P/2,sfu16_nut_housing_h])
    children(0);
    translate([ sfu16_nut_housing_C1, -sfu16_nut_housing_P/2,sfu16_nut_housing_h])
    children(1);
    translate([ sfu16_nut_housing_C1 + sfu16_nut_housing_C2,  sfu16_nut_housing_P/2,sfu16_nut_housing_h])
    children(2);
    translate([ sfu16_nut_housing_C1 + sfu16_nut_housing_C2, -sfu16_nut_housing_P/2,sfu16_nut_housing_h])
    children(3);
    if ($children > 4)
    {
        for (i = [4:$children-1])
        {
            translate([0,0,sfu16_nut_housing_h])
                children(i);
        }
    }
    bom_item("sfu1605_nut_housing");
}

module holes_nut()
{
    translate([sfu16_nut_housing_B/2+sfu16_nut_housing_PCD/2,sfu16_nut_housing_H-sfu16_nut_housing_h,-delta])
    cylinder(hole_l,hole_dia/2,hole_dia/2);
    translate([sfu16_nut_housing_B/2-sfu16_nut_housing_PCD/2,sfu16_nut_housing_H-sfu16_nut_housing_h,-delta])
    cylinder(hole_l,hole_dia/2,hole_dia/2);
    translate([sfu16_nut_housing_B/2+sfu16_nut_housing_PCD/2*cos(45),sfu16_nut_housing_H-sfu16_nut_housing_h+sfu16_nut_housing_PCD/2*cos(45),-delta])
    cylinder(hole_l,hole_dia/2,hole_dia/2);
    translate([sfu16_nut_housing_B/2-sfu16_nut_housing_PCD/2*cos(45),sfu16_nut_housing_H-sfu16_nut_housing_h+sfu16_nut_housing_PCD/2*cos(45),-delta])
    cylinder(hole_l,hole_dia/2,hole_dia/2);
    translate([sfu16_nut_housing_B/2+sfu16_nut_housing_PCD/2*cos(45),sfu16_nut_housing_H-sfu16_nut_housing_h-sfu16_nut_housing_PCD/2*cos(45),-delta])
    cylinder(hole_l,hole_dia/2,hole_dia/2);
    translate([sfu16_nut_housing_B/2-sfu16_nut_housing_PCD/2*cos(45),sfu16_nut_housing_H-sfu16_nut_housing_h-sfu16_nut_housing_PCD/2*cos(45),-delta])
    cylinder(hole_l,hole_dia/2,hole_dia/2);
}

module holes_holder()
{
    translate([0,0,-sfu16_nut_housing_H])
    translate([0,sfu16_nut_housing_C1,-delta])
    {
        translate([(sfu16_nut_housing_B-sfu16_nut_housing_P)/2,0,0])
        cylinder(hole_l,hole_dia/2,hole_dia/2);
        translate([sfu16_nut_housing_B - (sfu16_nut_housing_B-sfu16_nut_housing_P)/2,0,0])
        cylinder(hole_l,hole_dia/2,hole_dia/2);
        translate([0,sfu16_nut_housing_C2,0])
        {
            translate([(sfu16_nut_housing_B-sfu16_nut_housing_P)/2,0,0])
            cylinder(hole_l,hole_dia/2,hole_dia/2);
            translate([sfu16_nut_housing_B - (sfu16_nut_housing_B-sfu16_nut_housing_P)/2,0,0])
            cylinder(hole_l,hole_dia/2,hole_dia/2);
        }
    }
}

module sfu1605_nut_plate_holes(dia,l)
{
    translate([sfu16_nut_housing_C1,sfu16_nut_housing_H/2,-delta])
    cylinder(d=dia,h = l+2*delta);
    translate([sfu16_nut_housing_C1,-sfu16_nut_housing_H/2,-delta])
    cylinder(d=dia,h = l+2*delta);
    translate([sfu16_nut_housing_C1+sfu16_nut_housing_C2,sfu16_nut_housing_H/2,-delta])
    cylinder(d=dia,h = l+2*delta);
    translate([sfu16_nut_housing_C1+sfu16_nut_housing_C2,-sfu16_nut_housing_H/2,-delta])
    cylinder(d=dia,h = l+2*delta);
}

module sfu1605_nut_spacer(h)
{
    color(color_plastic_black)
    difference()
    {
    translate([0,-sfu16_nut_housing_B/2,0])
    cube([sfu16_nut_housing_H,sfu16_nut_housing_B,h]);
    sfu1605_nut_plate_holes(6.5,10,$fn=100);
    }
    bom_item(str("sfu1605_nut_spacer_", h));
}

sfu1605_nut_housing($fn=100)
{
    cube(1);
    cube(1);
    cube(1);
    cube(1);
}
//sfu1605_nut_spacer(10);

//sfu1605_nut_spacer(10);
