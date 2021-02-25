use <MCAD/regular_shapes.scad>
include <colors.scad>

spindle_body_dia  = 52;
spindle_body_h    = 90;
spindle_body_bearing_cylinder_dia = 26;
spindle_body_bearing_cylinder_h = 6.5;
spindle_shaft_dia = 8;
spindle_shaft_h = 32;
spindle_er11_nut_dia = 19;
spindle_er11_nut_total_h   = 13;
spindle_er11_nut_hex_h   = spindle_er11_nut_total_h/2;
spindle_er11_nut_in_dia = 9;
spindle_er11_dist = 0.3;
spindle_er11_in_dia = 3.175;
spindle_body_er11_nut_dist = 39;

spindle_fan_dia = 57;
spindle_fan_h   = 26;
spindle_fan_in_h = spindle_fan_h - 7;
spindle_fan_top_in_dia = 37.5;
spindle_fan_in_th = 2;
spindle_fan_th  = 2;
spindle_fan_shaft_dia = 15;
spindle_body_fan_dist = 9;

spindle_head_base_dia = 16;
spindle_head_base_h = 21;
spindle_head_h_total = 37;
spindle_head_dia = 14;
spindle_head_bevel_h = 8;
spindle_body_head_dist = 9;

delta = 0.1;

module spindle_head()
{
    translate([0,0,-spindle_head_h_total])
    difference()
    {
        union()
        {
            translate([0,0,spindle_head_h_total - spindle_head_base_h])
            cylinder(h=spindle_head_base_h,d=spindle_head_base_dia);
            cylinder(h=spindle_head_h_total - spindle_head_base_h,d=spindle_head_dia);
        }
    translate([spindle_head_dia/2,-spindle_head_base_dia/2,spindle_head_h_total - spindle_head_base_h-delta])
    cube([spindle_head_base_dia-spindle_head_dia+delta,spindle_head_base_dia,spindle_head_bevel_h+delta]);

    translate([-spindle_head_dia/2-spindle_head_base_dia+spindle_head_dia-delta,-spindle_head_base_dia/2,spindle_head_h_total - spindle_head_base_h-delta])
    cube([spindle_head_base_dia-spindle_head_dia+delta,spindle_head_base_dia,spindle_head_bevel_h+delta]);
    }
}


module spindle_body()
{
    cylinder(h=spindle_body_h,d=spindle_body_dia);
    translate([0,0,spindle_body_h])
    cylinder(h = spindle_shaft_h, d = spindle_shaft_dia);
    translate([0,0,-spindle_shaft_h])
    cylinder(h = spindle_shaft_h, d = spindle_shaft_dia);
    translate([0,0,-spindle_body_bearing_cylinder_h])
    cylinder(h = spindle_body_bearing_cylinder_h, d = spindle_body_bearing_cylinder_dia);
    translate([0,0,spindle_body_h])
    cylinder(h = spindle_body_bearing_cylinder_h, d = spindle_body_bearing_cylinder_dia);
}

module spindle_er11_nut()
{
    translate([0,0,-spindle_er11_nut_total_h-delta])
    difference()
    {
        union()
        {
            translate([0,0,spindle_er11_nut_hex_h])
            cylinder(h=spindle_er11_nut_total_h-spindle_er11_nut_hex_h, d = spindle_er11_nut_dia);

            linear_extrude(spindle_er11_nut_hex_h)
            hexagon(spindle_er11_nut_dia/2);
        }
        
        translate([0,0,-delta])
        cylinder(h = spindle_er11_nut_total_h + 2*delta, d = spindle_er11_nut_in_dia);
    }
}

module spindle_er11_collet()
{
    translate([0,0,-spindle_er11_nut_total_h-2*delta])
    {
        difference()
        {
            cylinder(h = spindle_er11_nut_total_h + 2*delta, d = spindle_er11_nut_in_dia);

            translate([-spindle_er11_nut_in_dia/2, -spindle_er11_dist/2, -delta])
                cube([spindle_er11_nut_in_dia+2*delta, spindle_er11_dist,spindle_er11_nut_hex_h-1]);

            rotate([0,0,-60])
            translate([-spindle_er11_nut_in_dia/2, -spindle_er11_dist/2, -delta])
                cube([spindle_er11_nut_in_dia+2*delta, spindle_er11_dist,spindle_er11_nut_hex_h-1]);

            rotate([0,0,60])
            translate([-spindle_er11_nut_in_dia/2, -spindle_er11_dist/2, -delta])
                cube([spindle_er11_nut_in_dia+2*delta, spindle_er11_dist,spindle_er11_nut_hex_h-1]);
            
            translate([0,0,-delta])
            cylinder(h = spindle_er11_nut_total_h, d = spindle_er11_in_dia);
        }
    }
}

module spindle()
{
    color(color_metal)
    translate([0,0,spindle_body_h+spindle_body_fan_dist])
    spindle_fan($fn=100);

    color(color_metal)
    spindle_body($fn=100);

    translate([0,0,-spindle_body_er11_nut_dist])
    {
        color(color_metal_black)
        spindle_er11_nut($fn=100);
        color(color_metal)
        spindle_er11_collet($fn=100);
    }

    color(color_metal)
    translate([0,0,-spindle_body_head_dist])
    spindle_head($fn=100);
}

//spindle();

module spindle_fan()
{
    difference()
    {
        cylinder(h = spindle_fan_h, d = spindle_fan_dia);
        translate([0,0,-delta])
        cylinder(h = spindle_fan_h-spindle_fan_th+delta, d = spindle_fan_dia-2*spindle_fan_th);

        translate([0,0,delta])
        cylinder(h = spindle_fan_h+delta, d = spindle_fan_top_in_dia);

    }

    difference()
    {
        union()
        {
        cylinder(h = spindle_fan_h, d = spindle_fan_shaft_dia);

            translate([-(spindle_fan_dia-spindle_fan_th)/2, -spindle_fan_in_th/2, spindle_fan_h-spindle_fan_in_h])
                cube([spindle_fan_dia-spindle_fan_th, spindle_fan_in_th,spindle_fan_in_h]);

            rotate([0,0,30])
            translate([-(spindle_fan_dia-spindle_fan_th)/2, -spindle_fan_in_th/2, spindle_fan_h-spindle_fan_in_h])
                cube([spindle_fan_dia-spindle_fan_th, spindle_fan_in_th,spindle_fan_in_h]);

            rotate([0,0,60])
            translate([-(spindle_fan_dia-spindle_fan_th)/2, -spindle_fan_in_th/2, spindle_fan_h-spindle_fan_in_h])
                cube([spindle_fan_dia-spindle_fan_th, spindle_fan_in_th,spindle_fan_in_h]);

            rotate([0,0,90])
            translate([-(spindle_fan_dia-spindle_fan_th)/2, -spindle_fan_in_th/2, spindle_fan_h-spindle_fan_in_h])
                cube([spindle_fan_dia-spindle_fan_th, spindle_fan_in_th,spindle_fan_in_h]);

            rotate([0,0,120])
            translate([-(spindle_fan_dia-spindle_fan_th)/2, -spindle_fan_in_th/2, spindle_fan_h-spindle_fan_in_h])
                cube([spindle_fan_dia-spindle_fan_th, spindle_fan_in_th,spindle_fan_in_h]);

            rotate([0,0,150])
            translate([-(spindle_fan_dia-spindle_fan_th)/2, -spindle_fan_in_th/2, spindle_fan_h-spindle_fan_in_h])
                cube([spindle_fan_dia-spindle_fan_th, spindle_fan_in_th,spindle_fan_in_h]);
        }
        translate([0,0,-delta])
        cylinder(h = spindle_fan_h+2*delta, d = spindle_shaft_dia);
        translate([0,0,spindle_fan_h-2])
        cylinder(h = spindle_fan_th+delta, d = spindle_fan_top_in_dia);
    }
}

spindle($fn=100);