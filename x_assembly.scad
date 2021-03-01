/* Aluminium profiles */
use     <parts/profile_30x60.scad>
include <parts/profile_30_dim.scad>
/* Small bracket */
use     <bracket_small_assembly.scad>
include <parts/bracket_small_dim.scad>
/* Step motor */
use     <parts/motor.scad>
include <parts/motor_dim.scad>
/* Ball screw assembly */
use     <sfu1605_assembly.scad>
/* Motor holder X */
use     <parts/motor_x.scad>
include <parts/motor_x_dim.scad>
/* Spider coupling */
use     <parts/shaft_coupling_spider.scad>
/* Linear rail */
use     <parts/sbr16.scad>
include <parts/sbr16_dim.scad>
/* Linear bearing */
use     <parts/sbr16uu.scad>
include <parts/sbr16uu_dim.scad>
/* X plate */
use     <parts/plate_x.scad>
include <parts/plate_x_dim.scad>
/* MX assembly */
use     <mx_assembly.scad>
/* MX screw */
use     <parts/mx_screw_lens_hex.scad>
/* MX washer */
use     <parts/mx_washer.scad>
include <parts/mx_washer_dim.scad>
/* Nut 8 B */
use     <parts/nut8b.scad>

include <parts/bf12_dim.scad>
include <parts/sfu1605_nut_housing_dim.scad>
include <parts/sfu1605_nut_dim.scad>
include <parts/sfu1605_dim.scad>

/* Global CNC dimensions */
include <CNC_dim.scad>

/* Internal variables */
profile_long_len   = sfu1605_assembly_get_screw_offset_fixed_x3(x_ballscrew_len)+profile_h/2;
profile_short_len = y_assembly_y_distance-profile_h*6;

sbr16uu_plate_dist = 10;

/* Motor with spider coupling and holder */
module x_motor_complete()
{
    translate([-motor_x_th,0,motor_x_h])
    {
        motor_x();
        motor();
        translate([motor_shaft_l,0,0])
        shaft_coupling_spider(8,10,15, $fn = 50);
    }
}

/* Aluminium base */
module x_alu_base()
{
    translate([0,-(2*profile_h + y_assembly_y_distance)/2])
    {
        /* 2 short profiles */
        translate([sfu1605_assembly_get_screw_offset_fixed_x3(x_ballscrew_len)+profile_h/2,profile_h*4,0])
            rotate([0,0,90])
                profile_30x60(profile_short_len);
        translate([profile_h*2,profile_h*2*2,0])
            rotate([0,0,90])
                profile_30x60(profile_short_len);
        /* 2 blocks of long profiles */
        profile_30x60(profile_long_len);
        translate([0,profile_h*2,0])
        profile_30x60(profile_long_len);
        translate([0,profile_short_len+profile_h*2*2,0])
        {
            profile_30x60(profile_long_len);
            translate([0,profile_h*2,0])
            profile_30x60(profile_long_len);
        }
    }
    translate([profile_h*2,profile_short_len/2,profile_h/2])
    rotate([90,0,0])
    bracket_small_assembly();
    translate([profile_h*2,-profile_short_len/2,profile_h/2])
    rotate([0,0,90])
    rotate([90,0,0])
    bracket_small_assembly();
    translate([profile_long_len-profile_h*2,profile_short_len/2,profile_h/2])
    rotate([0,0,-90])
    rotate([90,0,0])
    bracket_small_assembly();
    translate([profile_long_len-profile_h*2,-profile_short_len/2,profile_h/2])
    rotate([0,0,-180])
    rotate([90,0,0])
    bracket_small_assembly();
}

/* Linear bearings */
module x_sbr16uu_assembly()
{
    translate([sbr16uu_L/2,0,sbr16_h])
    {
        translate([0,-profile_short_len/2-profile_h*2,0])
        {
            sbr16uu()
            {
                sbr16uu_spacer(sbr16uu_plate_dist);
            }
            translate([sbr16uu_L + x_sbr16uu_distance,0,0])
            sbr16uu()
            {
                sbr16uu_spacer(sbr16uu_plate_dist);
            }
        }
        translate([0, profile_short_len/2+profile_h*2,0])
        {
            sbr16uu()
            {
                sbr16uu_spacer(sbr16uu_plate_dist);
            }
            translate([sbr16uu_L + x_sbr16uu_distance,0,0])
            sbr16uu()
            {
                sbr16uu_spacer(sbr16uu_plate_dist);
            }
        }
    }
}

/* Complete X assembly */
module x_assembly(offset)
{
    /* Aluminium base */
    x_alu_base();
    
    /* Motor with spider coupling and holder */
    x_motor_complete();

    translate([sfu1605_assembly_get_screw_offset_fixed_x2()-profile_h*3/2+offset + sfu1605_fixed_end_len + sfu1605_fixed_end_bearings_len+sfu1605_nut_big_len,0,profile_h+bf12_shaft_h+sfu16_nut_housing_h])
    sfu1605_nut_spacer(bk12_h+sbr16uu_h + sbr16uu_plate_dist - (bf12_shaft_h+sfu16_nut_housing_h));

//

    /* Ballscrew with supports */
    translate([sfu1605_assembly_get_screw_offset_fixed_x2()-profile_h*3/2,0,profile_h])
    sfu1605_assembly(x_ballscrew_len,offset)
    {
        mx_dia = 6;
        mx_assembly(mx_dia, 37, 0,bk12_vert_hole_z+profile_th)
        {
            group(); //< Empty group instead of a washer
            nut8b(mx_dia);
        }
        mx_assembly(mx_dia, 37, 0,bk12_vert_hole_z+profile_th)
        {
            group(); //< Empty group instead of a washer
            nut8b(mx_dia);
        }
    }

    /* Linear rails and linear bearings */
    translate([(profile_long_len-x_sbr16_len)/2,0,profile_h])
    {
        /* Both X rails */
        translate([0, profile_short_len/2+profile_h*2,0])
        sbr16(x_sbr16_len);
        translate([0,-profile_short_len/2-profile_h*2,0])
        sbr16(x_sbr16_len);
        /* X bearings and plate */
        translate([offset,0,0])
        {
            /* SBR16UU */
            x_sbr16uu_assembly();
            /* X plate */
            translate([x_sbr16uu_distance/2+sbr16uu_L-profile_long_len/2,0,bk12_h+sbr16uu_h + sbr16uu_plate_dist])
            plate_x(profile_long_len,profile_short_len+profile_h*6-10)
            {
                translate([sbr16uu_L/2-x_sbr16uu_distance/2-sbr16uu_L+profile_long_len/2,profile_short_len/2+profile_h*2,0])
                sbr16uu_plate_holes(6, plate_x_th+2);
                translate([sbr16uu_L/2-x_sbr16uu_distance/2-sbr16uu_L+profile_long_len/2,-profile_short_len/2-profile_h*2,0])
                sbr16uu_plate_holes(6, plate_x_th+2);
                translate([sbr16uu_L + x_sbr16uu_distance + sbr16uu_L/2-x_sbr16uu_distance/2-sbr16uu_L+profile_long_len/2,profile_short_len/2+profile_h*2,0])
                sbr16uu_plate_holes(6, plate_x_th+2);
                translate([sbr16uu_L + x_sbr16uu_distance + sbr16uu_L/2-x_sbr16uu_distance/2-sbr16uu_L+profile_long_len/2,-profile_short_len/2-profile_h*2,0])
                sbr16uu_plate_holes(6, plate_x_th+2);
            }
        }
    }
    
}

x_assembly(180, $fn=30);