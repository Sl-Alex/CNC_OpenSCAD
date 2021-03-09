/* Ball screw */
use     <parts/sfu1605.scad>
include <parts/sfu1605_dim.scad>
/* Ball screw nut */
use     <parts/sfu1605_nut.scad>
include <parts/sfu1605_nut_dim.scad>
/* Ball screw nut housing */
use     <parts/sfu1605_nut_housing.scad>
include <parts/sfu1605_nut_housing_dim.scad>
/* Ball screw fixed end support */
use <parts/bk12.scad>
include <parts/bk12_dim.scad>
/* Ball screw floating end support */
use <parts/bf12.scad>
include <parts/bf12_dim.scad>
/* MX assembly */
use     <mx_assembly.scad>
use     <parts/mx_screw_lens_hex.scad>
use     <parts/mx_screw_flat_hex.scad>
/* MX washer */
use     <parts/mx_washer.scad>
include <parts/mx_washer_dim.scad>
/* Nut 8 B */
use     <parts/nut8b.scad>

function sfu1605_get_travel(length) = 
    (length - sfu1605_fixed_end_len - sfu1605_fixed_end_bearings_len - sfu1605_floating_end_len - sfu1605_nut_len-(bf12_th/2-bf12_bearing_th/2));

function sfu1605_assembly_get_screw_offset_fixed_x1() =
    sfu1605_fixed_end_bearings_len + sfu1605_fixed_end_len - bk12_C2 - bk12_C1;

function sfu1605_assembly_get_screw_offset_fixed_x2() =
    sfu1605_fixed_end_bearings_len + sfu1605_fixed_end_len - bk12_C2;

function sfu1605_assembly_get_screw_offset_fixed_x3(length) =
    length - sfu1605_floating_end_len + bf12_bearing_th / 2;

/* Ball screw assembly */
module sfu1605_assembly(length, nut_offset)
{
    /* End supports */
    translate([length+bf12_bearing_th/2-sfu1605_floating_end_len,0,0])
    union()
    {
        /* Floating end */
        bf12()
        {
            /* 2 screws */
            if ($children > 0)
            {
                children(0);
            }
        }
    }

    translate([-bk12_th/2+sfu1605_fixed_end_len+sfu1605_fixed_end_bearings_len,0,0])
    union()
    {
        /* Fixed end */
        bk12()
        {
            /* 4 screws */
            if ($children > 1)
            {
                children(1);
            }
            if ($children > 2)
            {
                children(2);
            }
        }
    }

    /* Ball screw with nut */
    translate([0,0,bf12_shaft_h])
    union()
    {
        sfu1605(length);
        if (nut_offset >= sfu1605_get_travel(length))
        {
            translate([length - sfu1605_floating_end_len - sfu1605_nut_len-(bf12_th/2-bf12_bearing_th/2)-0.01,0,0])
            {
                sfu1605_nut();
                translate([sfu1605_nut_big_len,0,0])
                sfu1605_nut_housing();
            }
        }
        else
        {
            translate([nut_offset + sfu1605_fixed_end_len + sfu1605_fixed_end_bearings_len,0,0])
            {
                sfu1605_nut();
                translate([sfu1605_nut_big_len,0,0])
                sfu1605_nut_housing()
                {
                    if ($children > 3)
                    children(3);
                    if ($children > 3)
                    children(3);
                    if ($children > 3)
                    children(3);
                    if ($children > 3)
                    children(3);
                }
            }
        }
    }
}

sfu1605_assembly(500,100)
{
    mx_dia = 6;
    mx_assembly(0,bk12_vert_hole_z)
    {
        mx_screw_lens_hex(mx_dia, 40);
        group(); //< Empty group instead of a washer
        nut8b(mx_dia);
    }
    mx_assembly(0,bk12_vert_hole_z)
    {
        mx_screw_lens_hex(mx_dia, 40);
        group(); //< Empty group instead of a washer
        nut8b(mx_dia);
    }
    mx_assembly(0,bk12_vert_hole_z)
    {
        mx_screw_lens_hex(mx_dia, 40);
        group(); //< Empty group instead of a washer
        nut8b(mx_dia);
    }
    mx_assembly(10,0)
    {
        mx_screw_flat_hex(5, 20);
    }

}