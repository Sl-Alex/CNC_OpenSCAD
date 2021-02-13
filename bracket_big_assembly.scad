/* MX screw */
use     <parts/mx_screw_lens_hex.scad>
/* MX washer */
use     <parts/mx_washer.scad>
include <parts/mx_washer_dim.scad>
/* Nut 8 B */
use     <parts/nut8b.scad>
/* Small bracket */
use     <parts/bracket_big.scad>
include <parts/bracket_big_dim.scad>
/* MX assembly */
use     <mx_assembly.scad>
/* Aluminium profile */
include <parts/profile_30_dim.scad>

module bracket_big_mx_assembly()
{
    dia = 6;
    len = 14;
    nut_off = profile_th;

    mx_assembly(dia, len, MX_WASHER_th[dia],nut_off+bracket_big_th)
    {
        mx_washer(dia);
        rotate([0,0,90])
        nut8b(dia);
    }
}

module bracket_big_assembly()
{
    bracket_big();
    translate([bracket_big_nut_co_off1 + bracket_big_nut_co_l1/2,0,bracket_big_th])
    bracket_big_mx_assembly();

    translate([bracket_big_nut_co_off2 + bracket_big_nut_co_l2/2,0,bracket_big_th])
    bracket_big_mx_assembly();
    
    translate([bracket_big_th,0,bracket_big_nut_co_off1 + bracket_big_nut_co_l1/2])
    rotate([0,90,0])
    bracket_big_mx_assembly();

    translate([bracket_big_th,0,bracket_big_nut_co_off2 + bracket_big_nut_co_l2/2])
    rotate([0,90,0])
    bracket_big_mx_assembly();
}


// Sample usage
bracket_big_assembly();
