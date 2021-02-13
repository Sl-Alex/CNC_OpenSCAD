/* MX screw */
use     <parts/mx_screw_lens_hex.scad>
/* MX washer */
use     <parts/mx_washer.scad>
include <parts/mx_washer_dim.scad>
/* Nut 8 B */
use     <parts/nut8b.scad>
/* Small bracket */
use     <parts/bracket_small.scad>
include <parts/bracket_small_dim.scad>
/* MX assembly */
use     <mx_assembly.scad>
/* Aluminium profile */
include <parts/profile_30_dim.scad>

module bracket_small_assembly(rotate_1, rotate_2)
{
    dia = 6;
    len = 14;
    nut_off = profile_th;
    bracket_small();
    translate([profile_h/2,0,bracket_small_th])
    mx_assembly(dia, len, MX_WASHER_th[dia],nut_off+bracket_small_th)
    {
        mx_washer(dia);
        if (rotate_1)
        {
            nut8b(dia);
        }
        else
        {
            rotate([0,0,90])
            nut8b(dia);
        }
    }

    translate([bracket_small_th,0,profile_h/2])
    rotate([0,90,0])
    mx_assembly(dia, len, MX_WASHER_th[dia],nut_off+bracket_small_th)
    {
        mx_washer(dia);
        if (rotate_2)
        {
            nut8b(dia);
        }
        else
        {
            rotate([0,0,90])
            nut8b(dia);
        }
    }
}


// Sample usage
bracket_small_assembly();
