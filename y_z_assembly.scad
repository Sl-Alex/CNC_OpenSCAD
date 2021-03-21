/* Aluminium profiles */
use     <parts/profile_30x60.scad>
use     <parts/profile_30x30.scad>
include <parts/profile_30_dim.scad>
/* Small bracket */
use     <bracket_small_assembly.scad>
include <parts/bracket_small_dim.scad>
/* Big bracket */
use     <bracket_big_assembly.scad>
/* Fixed end ballscrew support */
use     <parts/bk12.scad>
include <parts/bk12_dim.scad>
/* Floating end ballscrew support */
use     <parts/bf12.scad>
include <parts/bf12_dim.scad>
/* Step motor */
use     <parts/motor.scad>
include <parts/motor_dim.scad>
/* Ball screw assembly */
use     <sfu1605_assembly.scad>
include <parts/sfu1605_dim.scad>
/* Shaft for ballscrew extension */
use     <parts/shaft.scad>
/* Motor holder Y */
use     <parts/motor_y.scad>
include <parts/motor_y_dim.scad>
/* Plate Y and Z assembly */
use     <plate_y_z_assembly.scad>
include <parts/plate_xyz_dim.scad>
/* Spider coupling */
use     <parts/shaft_coupling_spider.scad>
include <parts/shaft_coupling_spider_dim.scad>
/* Fixed coupling */
use     <parts/shaft_coupling_fixed.scad>
include <parts/shaft_coupling_fixed_dim.scad>
/* Linear rail */
use     <parts/sbr16.scad>
include <parts/sbr16_dim.scad>
/* Linear bearing */
use     <parts/sbr16uu.scad>
include <parts/sbr16uu_dim.scad>
/* BK/BF support spacers */
use     <parts/y_bk12_bf12_support.scad>
include <parts/y_bk12_bf12_support_dim.scad>
/* MX assembly */
use     <mx_assembly.scad>
use     <parts/mx_screw_lens_hex.scad>
/* Nut 8 B */
use     <parts/nut8b.scad>

/* Global CNC dimensions */
include <CNC_dim.scad>

/* Internal variables */
shaft_ext_len = 60;
shaft_ext_distance_motor = 7;
shaft_ext_distance_screw = 7;
shaft_coupling_margin = 1;

y_profile_bottom_h = profile_h + sbr16_h + sbr16uu_h;
y_shaft_offset = (y_profile_bottom_offset + y_profile_bottom_h + y_profile_top_offset)/2;
shaft_ext_offset = shaft_coupling_spider_l_o + shaft_coupling_margin;
ball_screw_offset = y_assembly_y_distance/2+profile_h+shaft_ext_offset-shaft_ext_len - shaft_ext_distance_screw;
profile_fixed_end_support_dist = -ball_screw_offset + profile_h/2+ sfu1605_fixed_end_bearings_len + sfu1605_fixed_end_len - bk12_C2;
profile_floating_end_support_dist = -ball_screw_offset + y_ball_screw_len + profile_h/2 -sfu1605_floating_end_len + bf12_bearing_th/2;
sbr16uu_offset_def = y_sbr16_len/2;

/* Both linear rails */
module y_linear_rail()
{
    translate([0,-y_assembly_y_distance/2,0])
    rotate([0,0,90])
    {
        translate([0,-profile_h,0])
        profile_30x60(y_assembly_y_distance);
        translate([(y_assembly_y_distance-y_sbr16_len)/2,0,profile_h])
        sbr16(y_sbr16_len);
    }
    /* Left brackets */
    translate([0,-y_assembly_y_distance/2,0])
    {
        translate([profile_h/2,0,0])
        rotate([-90,0,0])
        rotate([0,0,90])
        bracket_small_assembly();
        translate([-profile_h/2,0])
        rotate([-90,0,0])
        rotate([0,0,90])
        bracket_small_assembly();
    }
    /* Right brackets */
    translate([0,y_assembly_y_distance/2,0])
    {
        /* Left brackets */
        translate([profile_h/2,0,0])
        rotate([180,0,0])
        rotate([0,0,90])
        bracket_small_assembly();
        translate([-profile_h/2,0])
        rotate([180,0,0])
        rotate([0,0,90])
        bracket_small_assembly();
    }
}

/* Linear bearings */
module y_sbr16uu_assembly()
{
    rotate([0,0,90])
    translate([0,0,profile_h+sbr16_h])
    {
        translate([sbr16uu_L/2,0,0])
        sbr16uu()
        {
            group(){};
            group(){};
            group(){};
            group(){};
        }
        translate([plate_y_w-sbr16uu_L/2,0,0])
        sbr16uu()
        {
            group(){};
            group(){};
            group(){};
            group(){};
        }
    }
}

/* Motor with spider and fixed couplings, shaft extension and holder */
module y_motor_complete()
{
    translate([-shaft_ext_offset,0,0])
    shaft(8,shaft_ext_len);
    translate([shaft_coupling_fixed_L/2+profile_h+shaft_coupling_margin,0,0])
    shaft_coupling_fixed(8,10,0);
    translate([-motor_y_th,0,0])
    {
        motor_y();
        motor();
    }
    translate([shaft_coupling_spider_l_o-shaft_coupling_spider_L()-shaft_coupling_margin,0,0])
    shaft_coupling_spider(8,10);
}

module y_profile_bracket_small_x2(dist)
{
    translate([dist/2,profile_h/2,0])
    bracket_small_assembly(0,1);
    translate([-dist/2,profile_h/2,0])
    rotate([0,-90,0])
    bracket_small_assembly(1,0);
}

module y_bk_bf_support()
{
    rotate([0,-90,0])
    {
        profile_30x30(y_profile_top_offset - y_profile_bottom_offset+profile_h);

        translate([profile_h,profile_h/2,0])
        rotate([0,0,90])
        y_profile_bracket_small_x2(profile_h);

        translate([y_profile_top_offset - y_profile_bottom_offset + profile_h,profile_h/2,0])
        rotate([0,0,90])
        y_profile_bracket_small_x2(profile_h);
    }
}

/* Complete Y and Z assembly */
module y_z_assembly(offset_y, offset_z)
{
    /* Left side */
    translate([profile_h,-y_assembly_y_distance/2,0])
    {
        rotate([90,0,0])
        rotate([0,0,90])
        profile_30x60(y_profile_vert_len);
        translate([0,-profile_h/2,0])
        rotate([0,-90,0])
        rotate([180,0,0])
        bracket_big_assembly();
        translate([-profile_h*2,-profile_h/2,0])
        rotate([0,180,0])
        rotate([180,0,0])
        bracket_big_assembly();
    }
    /* Right side */
    translate([profile_h,y_assembly_y_distance/2,0])
    {
        translate([0,profile_h,0])
        rotate([90,0,0])
        rotate([0,0,90])
        profile_30x60(y_profile_vert_len);
        translate([0,profile_h/2,0])
        bracket_big_assembly();
        translate([-profile_h*2,profile_h/2,0])
        rotate([0,-90,0])
        bracket_big_assembly();
    }

    /* Bottom linear rail */
    translate([0,0,y_profile_bottom_offset])
    y_linear_rail();
    /* Top linear rail */
    translate([0,0,y_profile_top_offset])
    y_linear_rail();

    /* Ball screw floating end support profile */
    translate([-profile_h,profile_floating_end_support_dist-profile_h,y_profile_bottom_offset])
    y_bk_bf_support();
    
    /* Ball screw fixed end support profile */
    translate([-profile_h,profile_fixed_end_support_dist-profile_h,y_profile_bottom_offset])
    y_bk_bf_support();

    /* Ball screw assembly */
    translate([-profile_h+y_bk12_bf12_support_th,-ball_screw_offset,y_shaft_offset])
    rotate([90,0,0])
    rotate([0,90,0])
    sfu1605_assembly(y_ball_screw_len,offset_y)
    {
        mx_dia = 6;
        mx_assembly(0,bk12_vert_hole_z+profile_th+y_bk12_bf12_support_th)
        {
            mx_screw_lens_hex(mx_dia, 45);
            group(); //< Empty group instead of a washer
            nut8b(mx_dia);
        }
        mx_assembly(0,bk12_vert_hole_z+profile_th+y_bk12_bf12_support_th)
        {
            mx_screw_lens_hex(mx_dia, 45);
            group(); //< Empty group instead of a washer
            nut8b(mx_dia);
        }
    }

    /* Y plate with Z assembly */
    translate([profile_h,-sbr16uu_offset_def+plate_y_w/2+offset_y,y_profile_top_offset + 140])
    rotate([0,90,0])
    plate_y_z_assembly(offset_z);

    /* Linear bearings */
    translate([0,-sbr16uu_offset_def+offset_y,0])
    {
        translate([0,0,y_profile_bottom_offset])
        y_sbr16uu_assembly();
        translate([0,0,y_profile_top_offset])
        y_sbr16uu_assembly();
    }

    /* BK/BF support spacers */
    translate([-profile_h,-profile_h/2,y_shaft_offset])
    {
        rotate([0,90,0])
        {
            translate([0,profile_floating_end_support_dist,0])
            y_bk12_bf12_support();
            translate([0,profile_fixed_end_support_dist,0])
            y_bk12_bf12_support();
        }
    }
    /* Motor with spider and fixed couplings, shaft extension and holder */
    translate([0,-y_assembly_y_distance/2-profile_h,y_shaft_offset])
    rotate([0,0,90])
    y_motor_complete();
}

y_z_assembly(310,00);