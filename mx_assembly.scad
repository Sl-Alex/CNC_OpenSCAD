/* MX screw */
use     <parts/mx_screw_lens_hex.scad>
/* MX washer */
use     <parts/mx_washer.scad>
include <parts/mx_washer_dim.scad>
/* Nut 8 B */
use     <parts/nut8b.scad>

module mx_assembly(dia, len, washer_th, nut_off){
    if ($children > 0)
    {
        translate([0,0,washer_th])
        {
            mx_screw_lens_hex(dia, len);
            children(0);
        }
    }
    if ($children > 1)
    {
        translate([0,0,-nut_off])
        children(1);
    }
}


// Sample usage
dia = 6;
mx_assembly(dia, 30, MX_WASHER_th[dia],0)
{
    mx_washer(dia);
    nut8b(dia);
}